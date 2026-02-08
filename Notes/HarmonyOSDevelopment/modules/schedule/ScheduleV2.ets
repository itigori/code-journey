import { DateUtil } from "basic/src/main/ets/utils/dataFormat"
import { ComponentConst } from "basic/src/main/ets/ComponentConst";
import { NumberUtil } from "basic/src/main/ets/utils/NumberUtil"
import { inspector, UIInspector } from "@kit.ArkUI";

/**
 * 周日期项类型定义：包含周一到周日的日期，以及本周所属的主要月份
 */
export interface WeekDateItem {
  weekNumber: number; // 第N周（从1开始）
  month: number; // 本周主要月份（数字，1-12）
  monthName: string; // 月份名称（中文）
  monday: Date; // 周一日期（Date对象）
  tuesday: Date; // 周二日期
  wednesday: Date; // 周三日期
  thursday: Date; // 周四日期
  friday: Date; // 周五日期
  saturday: Date; // 周六日期
  sunday: Date; // 周日日期
  weekDateRange: Date[]; // 本周日期数组 [周一, 周二, ..., 周日]
  weekTimeRange: Date[]; // 本周时间范围 [周一, 周日]
}

/**
 * 根据开始日期和周数，生成每周的详细日期信息
 * @param initialDate 开始日期（任意日期，会自动校准到第一周的周一）
 * @param weekCount 总周数
 * @returns WeekDateItem[] 每周的日期信息数组
 */
export function generateWeekDates(initialDate: Date, weekCount: number): WeekDateItem[] {
  const weekDateList: WeekDateItem[] = []
  const monthNames = ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'];

  try {
    // 1. 校准初始日期到第一周的周一
    const startDate = new Date(initialDate);
    const dayOfWeek = startDate.getDay(); // 0(周日)-6(周六)
    // 计算与周一的差值：周日(0)需要减6天，周一(1)减0天，周二(2)减1天...
    const diffToMonday = dayOfWeek === 0 ? -6 : 1 - dayOfWeek;
    startDate.setDate(startDate.getDate() + diffToMonday);

    // 2. 循环生成每一周的日期
    for (let weekNum = 1; weekNum <= weekCount; weekNum++) {
      const weekStart = new Date(startDate); // 本周周一
      const weekDates: Date[] = [];

      // 生成本周周一到周日的日期
      for (let day = 0; day < 7; day++) {
        const currentDate = new Date(weekStart);
        currentDate.setDate(weekStart.getDate() + day);
        weekDates.push(currentDate);
      }

      // 3. 确定本周的主要月份（以周一的月份为准）
      const mainMonth = weekDates[0].getMonth() + 1;

      // 4. 组装每周的日期信息
      weekDateList.push({
        weekNumber: weekNum,
        month: mainMonth,
        monthName: monthNames[mainMonth - 1],
        monday: weekDates[0],
        tuesday: weekDates[1],
        wednesday: weekDates[2],
        thursday: weekDates[3],
        friday: weekDates[4],
        saturday: weekDates[5],
        sunday: weekDates[6],
        weekDateRange: weekDates,
        weekTimeRange: [weekDates[0], weekDates[6]]
      });

      // 5. 准备下一周的开始日期（当前周一 + 7天）
      startDate.setDate(startDate.getDate() + 7);
    }
  } catch (error) {
    console.error('生成周日期失败:', error);
  }

  return weekDateList;
}

/**
 * 时间段分割下标信息实体类
 * 用于定义日程的大时间段分割（如上午/下午/晚上），包含分割的下标和时间段名称
 */
export class TimeInfo {
  divideTime: number = 0 // 该时间段的结束下标（用于分割日程下标）
  periodName: string | Resource = '' // 时间段名称

  /**
   * 构造函数
   * @param divideTime 时间段结束下标
   * @param periodName 时间段名称
   */
  constructor(divideTime: number, periodName: string | Resource) {
    this.divideTime = divideTime
    this.periodName = periodName
  }
}

/**
 * 日程信息数据结构实体类
 * 定义单条日程的核心信息，用于渲染日程卡片
 */
export class CourseInfo {
  daySchedule: number[] = [] // 课程在当天的时间段下标 [开始下标, 结束下标]，固定长度2
  weekDay: number = 0 // 课程所在的星期几（下标，与dateList/指南线下标对应）
  weekNumber: number[] = [] // 课程所属的周数 [1,3,5]
  courseName: string = '' // 课程名称/标题
  standardColor: string = '' // 普通色
  darkColor: string = '' // 边框色
  courseTeacher: string = '' // 老师
  courseCampus: string = '' // 校区（默认不显示，设置可开）
  courseLocation: string = '' // 地点
  courseType: string = '' // 教室类型（默认不显示，设置可开）

  /**
   * 构造函数
   * @param daySchedule 日程时间段下标[开始,结束]
   * @param weekDay 日程所在星期几（下标）
   * @param weekNumber 课程所属周数
   * @param scheduleName 日程名称
   * @param standardColor 背景色
   * @param darkColor 边框色
   * @param courseTeacher 老师
   * @param courseCampus 校区
   * @param courseLocation 地点
   * @param courseType 教室类型
   */
  constructor(
    daySchedule: number[],
    weekDay: number,
    weekNumber: number[],
    scheduleName: string,
    standardColor: string,
    darkColor: string,
    courseTeacher: string,
    courseCampus: string,
    courseLocation: string,
    courseType: string
  ) {
    this.daySchedule = daySchedule
    this.weekDay = weekDay
    this.weekNumber = weekNumber
    this.courseName = scheduleName
    this.standardColor = standardColor
    this.darkColor = darkColor
    this.courseTeacher = courseTeacher
    this.courseCampus = courseCampus
    this.courseLocation = courseLocation
    this.courseType = courseType
  }
}

export class Formatter {
  public static padZero(value: number, width: number = 2): string {
    return value.toString().padStart(width, '0')
  }
}

/**
 * 组件绘制步骤枚举
 * 用于控制组件的分阶段渲染，避免「指南线未计算完成就渲染依赖组件」导致的布局错乱
 * 核心原因：指南线位置需要等顶部栏和根容器布局完成后才能计算
 */
enum DrawStep {
  NONE, // 初始状态：仅绘制顶部月份胶囊，暂不绘制依赖指南线的组件
  VERTICAL_GUIDELINE, // 指南线计算完成：可绘制所有依赖指南线的组件（顶部日期、日程信息）
}

enum WeekState {
  INSIDE, // 在学期内
  FRONT,  // 学期未开始
  BACK  // 学期已结束
}

/**
 * 周维度日程流展示主组件
 * @ComponentV2 鸿蒙ArkTS的组件装饰器
 */
@ComponentV2
export struct ScheduleFlow {
  // 【必传参数】当前选中的日期（用于日期高亮）
  @Param @Require currentDate: Date
  // 【必传参数】学期开始日期
  @Param @Require semesterStartDate: Date
  // 【必传参数】总周数
  @Param @Require totalWeekCount: number
  // 【必传参数】时间段分割配置数组
  @Param @Require divideTimes: TimeInfo[]
  // 【必传参数】日程的最大下标（用于生成所有日程下标）
  @Param @Require scheduleMaxIndex: number
  // 【必传参数】日程列表数据
  @Param @Require scheduleList: CourseInfo[]
  // 【可选参数】日程卡片点击回调函数
  @Param scheduleClick?: (scheduleInfo: CourseInfo) => void = undefined

  // 本地状态：页面水平内边距
  @Local horizontalPadding: number = 5
  // 本地状态：组件垂直内边距
  @Local verticalPadding: number = 8
  // 本地状态：垂直指南线数组
  @Local verticalGuidelines: GuideLineStyle[] = []
  // 本地状态：组件绘制步骤
  @Local drawStep: DrawStep = DrawStep.NONE
  // 本地状态：周日期信息列表
  @Local weekDateList: WeekDateItem[] = []
  // 本地状态：当前显示的周数
  @Local currentWeekNumber: number = 1
  // 本地状态：周状态
  @Local isInWeek: WeekState = WeekState.INSIDE
  @Local weekNumber: number = -1

  @Local swiperIndex: number = 0

  // 私有只读：顶部月份胶囊的锚点ID（用于布局监听、相对对齐、获取布局信息）
  private readonly _TOP_BAR_ANCHOR = 'top_bar_month';
  // 私有只读：指南线ID后缀（用于生成唯一指南线ID）
  private readonly _GUIDELINE_SUFFIX = 'guideline_';
  // 私有：指南线唯一ID数组（存储所有生成的指南线ID）
  private _guidelineIdArray: string[] = [];
  // 私有只读：时间段分割栏ID后缀
  private readonly _PERIOD_SUFFIX = 'period_';
  // 私有：时间段分割栏唯一ID数组
  private _periodIdArray: string[] = [];
  // 私有只读：日程下标胶囊ID后缀
  private readonly _SCHEDULE_INDEX_SUFFIX = 'schedule_index_';
  // 私有：日程下标胶囊唯一ID数组
  private _scheduleIndexIdArray: string[] = [];
  // 私有只读：日程信息卡片ID后缀
  private readonly _SCHEDULE_INFO_SUFFIX = 'schedule_info_';
  // 私有：日程信息卡片唯一ID数组
  private _scheduleInfoIdArray: string[] = [];
  // 私有：顶部月份胶囊是否完成布局（标记位，避免重复计算指南线）
  private isTopBarLayout: boolean = false;
  // 私有：根容器是否完成布局（标记位，避免重复计算指南线）
  private isRootLayout: boolean = false;

  /**
   * 组件生命周期：即将出现时执行（只执行一次）
   * 核心操作：初始化组件ID、生成周日期列表、监听布局事件、计算指南线
   */
  aboutToAppear(): void {
    // 初始化周日期列表
    this.weekDateList = generateWeekDates(this.semesterStartDate, this.totalWeekCount);
    // 初始化所有动态生成的组件唯一ID数组
    this.initComponentId();
    // 获取当前组件的UI上下文，进而获取UI检查器（用于布局监听和组件信息获取）
    const uiInspector: UIInspector = this.getUIContext().getUIInspector();

    // 动态监听当前周的布局，而非固定ID
    this.updateLayoutListeners(uiInspector);

    // 1. 先获取今日日期和学期周范围的关键日期
    const today = new Date(); // 今日日期
    const firstWeekStart = this.weekDateList[0]?.weekTimeRange[0]; // 学期第1周开始（周一）
    const lastWeekEnd = this.weekDateList[this.weekDateList.length - 1]?.weekTimeRange[1]; // 学期最后1周结束（周日）
    let todayWeekState: WeekState = WeekState.INSIDE;
    let todayWeekNumber = 0;

    // 2. 基于今日日期判断状态和所在周数
    if (firstWeekStart && today < firstWeekStart) {
      // 今日在所有周之前 → FRONT
      todayWeekState = WeekState.FRONT;
    } else if (lastWeekEnd && today > lastWeekEnd) {
      // 今日在所有周之后 → BACK
      todayWeekState = WeekState.BACK;
    } else if (firstWeekStart && lastWeekEnd) {
      // 今日在学期内 → INSIDE，计算今日所在周数
      todayWeekState = WeekState.INSIDE;
      for (const weekItem of this.weekDateList) {
        if (today >= weekItem.weekTimeRange[0] && today <= weekItem.weekTimeRange[1]) {
          todayWeekNumber = weekItem.weekNumber;
          break;
        }
      }
    }
    this.isInWeek = todayWeekState
    this.weekNumber = todayWeekNumber + 1


    // 初始化周状态
    this.updateWeekState();
  }

  /**
   * 动态更新布局监听器（适配当前周的ID）
   */
  private updateLayoutListeners(uiInspector: UIInspector) {
    // 当前周的顶部栏ID和根容器ID
    const currentTopBarId = `${this._TOP_BAR_ANCHOR}_${this.currentWeekNumber}`;
    const currentRootId = `schedule_flow_root_${this.currentWeekNumber}`;

    // 创建顶部月份胶囊的布局观察者
    const topBarListener: inspector.ComponentObserver = uiInspector.createComponentObserver(currentTopBarId);
    // 创建根容器的布局观察者
    const rootListener: inspector.ComponentObserver = uiInspector.createComponentObserver(currentRootId);

    // 监听顶部月份胶囊的layout事件
    topBarListener.on('layout', () => {
      this.isTopBarLayout = true;
      this.computeVerticalGuideline();
    });
    // 监听根容器的layout事件
    rootListener.on('layout', () => {
      this.isRootLayout = true;
      this.computeVerticalGuideline();
    });
  }

  /**
   * 更新当前周的状态（学期内/未开始/已结束）
   */
  private updateWeekState() {
    const today = new Date();
    const firstWeekStart = this.weekDateList[0]?.weekTimeRange[0];
    const lastWeekEnd = this.weekDateList[this.weekDateList.length - 1]?.weekTimeRange[1];

    if (!firstWeekStart || !lastWeekEnd) {
      this.isInWeek = WeekState.INSIDE;
      return;
    }

    if (today < firstWeekStart) {
      this.isInWeek = WeekState.FRONT;
    } else if (today > lastWeekEnd) {
      this.isInWeek = WeekState.BACK;
    } else {
      this.isInWeek = WeekState.INSIDE;
      // 计算当前是第几周
      for (const weekItem of this.weekDateList) {
        if (today >= weekItem.weekTimeRange[0] && today <= weekItem.weekTimeRange[1]) {
          this.currentWeekNumber = weekItem.weekNumber;
          this.swiperIndex = weekItem.weekNumber - 1; // 同步swiper索引
          break;
        }
      }
    }
  }

  /**
   * 初始化所有动态组件的唯一ID数组
   * 为指南线、时间段分割栏、日程下标、日程卡片生成唯一ID，避免布局冲突
   */
  initComponentId() {
    // 1. 初始化指南线ID：一周7天，每天需要左右2条指南线，共14条
    const guidelineCount = 7;
    NumberUtil.range(guidelineCount * 2).forEach((_, index: number) => {
      this._guidelineIdArray.push(`${this._GUIDELINE_SUFFIX}${index}`);
    });
    // 2. 初始化时间段分割栏ID：根据分割配置数量生成
    this.divideTimes.forEach((_, timePeriodIndex: number) => {
      this._periodIdArray.push(`${this._PERIOD_SUFFIX}${timePeriodIndex}`);
    });
    // 3. 初始化日程下标ID：根据最大下标数量生成
    NumberUtil.range(this.scheduleMaxIndex + 1).forEach((_, index: number) => {
      this._scheduleIndexIdArray.push(`${this._SCHEDULE_INDEX_SUFFIX}${index}`);
    });
    // 4. 初始化日程卡片ID：根据日程列表数量生成
    this.scheduleList.forEach((_, index: number) => {
      this._scheduleInfoIdArray.push(`${this._SCHEDULE_INFO_SUFFIX}${index}`);
    });
  }

  /**
   * 过滤指定周的课程列表
   * @param weekNumber 周数
   * @returns CourseInfo[] 该周的课程列表
   */
  private filterCourseByWeek(weekNumber: number): CourseInfo[] {
    return this.scheduleList.filter(course =>
    course.weekNumber.includes(weekNumber)
    );
  }

  build() {
    Column() {
      // 周数信息栏
      Column() {
        Row({ space: 10 }) {
          Text() {
            Span($r('[basic].string.week_n_front'))
            Span(`${this.currentWeekNumber}`)
            Span($r('[basic].string.week_n_back'))
          }
          .fontWeight(FontWeight.Regular)

          if (this.isInWeek === WeekState.INSIDE) {
            Text() {
              Span($r('[basic].string.current_week_n_front'))
              Span(`${this.weekNumber}`)
              Span($r('[basic].string.current_week_n_back'))
            }
            .fontWeight(FontWeight.Regular)
          }
          if (this.isInWeek === WeekState.FRONT) {
            Text($r('[basic].string.semester_not_started')) // 学期未开始
              .fontWeight(FontWeight.Regular)
          }
          if (this.isInWeek === WeekState.BACK) {
            Text($r('[basic].string.semester_has_ended')) // 学期已结束
              .fontWeight(FontWeight.Regular)
          }
        }
        .width('100%')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .padding({
        right: 10,
        left: 10
      })

      // 周切换Swiper
      Swiper() {
        // 按周数渲染每个页面
        ForEach(this.weekDateList, (weekItem: WeekDateItem) => {
          RelativeContainer() {
            // 顶部日期栏（使用当前周的日期）
            this.topDateBarBuilder(weekItem)

            // 核心区
            Scroll() {
              Column() {
                RelativeContainer() {
                  // 构建时间段分割栏 + 日程下标胶囊
                  this.scheduleDivideBuilder()
                  // 课程卡片（仅显示当前周的课程）
                  this.scheduleFlowBuilder(this.filterCourseByWeek(weekItem.weekNumber))
                }
                .width('100%')
                .height('auto')
                .guideLine(this.verticalGuidelines)
              }
              .constraintSize({ minHeight: '100%' }) // 最小高度占满父容器
              .justifyContent(FlexAlign.Start)
            }
            .width('100%')
            .alignRules({
              top: ComponentConst.bindBottom(`${this._TOP_BAR_ANCHOR}_${weekItem.weekNumber}`), // 绑定当前周的顶部栏ID
              bottom: ComponentConst.bindBottom()
            })
            .scrollBar(BarState.Off)
            .edgeEffect(EdgeEffect.Spring)
            .margin({ top: 12 })
            .id(`schedule_flow_container_${weekItem.weekNumber}`)
          }
          .width('100%')
          .height('100%')
          .guideLine(this.verticalGuidelines)
          .id(`schedule_flow_root_${weekItem.weekNumber}`) // 周唯一ID
        }, (item: WeekDateItem) => `week_${item.weekNumber}`) // ForEach唯一标识
      }
      .index(this.swiperIndex) // 使用同步后的索引
      .autoPlay(false)
      .indicator(false)
      .loop(false)
      .width('100%')
      .height('100%')
      .onChange((index: number) => {
        // 切换Swiper时更新当前周数
        this.currentWeekNumber = this.weekDateList[index]?.weekNumber || 1;
        this.swiperIndex = index; // 同步索引
        // 重新更新布局监听并计算指南线
        this.isTopBarLayout = false;
        this.isRootLayout = false;
        this.updateLayoutListeners(this.getUIContext().getUIInspector());
        this.computeVerticalGuideline();
      })
    }
    .width('100%')
    .height('100%')
  }

  /**
   * 构建器：顶部日期栏（左侧月份胶囊 + 右侧周日期）
   * @param weekItem 当前周的日期信息
   */
  @Builder
  topDateBarBuilder(weekItem: WeekDateItem) {
    // 左侧月份显示（当前周的主要月份）
    Column() {
      // 月份数字
      Text(weekItem.month.toString())
        .fontSize(12)
        .fontColor($r('[basic].color.standard_font_color'))
        .fontWeight(FontWeight.Bold)
      // 月份文字
      Text($r('[basic].string.month'))
        .fontSize($r('[basic].float.schedule_month_size'))
        .fontColor($r('[basic].color.standard_font_color'))
        .fontWeight(FontWeight.Bold)
        .margin({ top: 2 })
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .width(24)
    .height(40)
    .id(`${this._TOP_BAR_ANCHOR}_${weekItem.weekNumber}`) // 周唯一的锚点ID
    .margin({
      top: 16,
      left: 8,
    })

    // 渲染条件改为指南线计算完成（VERTICAL_GUIDELINE）
    if (this.drawStep === DrawStep.VERTICAL_GUIDELINE) {
      ForEach(weekItem.weekDateRange, (dateTime: Date, index: number) => {
        Column() {
          Text(this.weekDayShort[index])
            .fontSize($r('[basic].float.schedule_weekDay_size'))
            .fontColor(DateUtil.isSameDate(dateTime, this.currentDate)
              ? $r('[basic].color.standard_font_color')
              : $r('[basic].color.main_grey'))
          // 日期文字：特殊处理1号（展示「X月」，否则展示「X」）
          Text() {
            if (dateTime.getDate() !== 1) {
              Span(`${Formatter.padZero(dateTime.getDate())}`)
            } else {
              Span(`${dateTime.getMonth() + 1}`)
              Span($r('[basic].string.month_short'))
            }
          }
          .fontSize(12)
          .fontColor(DateUtil.isSameDate(dateTime, this.currentDate)
            ? $r('[basic].color.standard_font_color')
            : $r('[basic].color.main_grey'))
          .margin({ top: 2 })
        }
        .borderRadius(18)
        .padding({
          top: 5,
          left: 10,
          right: 10
        })
        // 指南线下标计算（前置2个空指南线，所以下标是 2 + index*2 和 2 + index*2 +1）
        .alignRules({
          top: ComponentConst.bindTop(`${this._TOP_BAR_ANCHOR}_${weekItem.weekNumber}`),
          bottom: ComponentConst.bindBottom(`${this._TOP_BAR_ANCHOR}_${weekItem.weekNumber}`),
          left: ComponentConst.bindStart(this.verticalGuidelines[2 + index * 2].id),
          right: ComponentConst.bindEnd(this.verticalGuidelines[2 + index * 2 + 1].id)
        })
      }, (item: Date) => item.toLocaleString())
    }
  }

  /**
   * 构建器：时间段分割栏 + 日程下标胶囊
   * 按divideTimes配置，渲染「上午/下午」等分割栏，并在下方生成连续的日程下标
   */
  @Builder scheduleDivideBuilder() {
    // 循环渲染每个时间段分割配置
    ForEach(this.divideTimes, (timeInfo: TimeInfo, timePeriodIndex: number) => {
      // 时间段分割栏（如「上午」）
      Row() {
        Text(timeInfo.periodName)
          .fontSize(16)
          .fontColor($r('[basic].color.standard_font_color'))
      }
      .width('100%')
      // 分割栏的相对布局规则：第一个分割栏置顶，后续分割栏对齐上一个分割栏的最后一个下标底部
      .alignRules({
        top: timePeriodIndex === 0 ?
          undefined :
          ComponentConst.bindBottom(this._scheduleIndexIdArray[this.divideTimes[timePeriodIndex - 1].divideTime]),
      })
      .id(this._periodIdArray[timePeriodIndex]) // 分割栏唯一ID
      .margin({ top: 5 })
      .padding({
        left: 5,
      })

      // 循环渲染当前时间段下的所有日程下标胶囊
      ForEach(this.getDivideIndexRange(timePeriodIndex), (scheduleIndex: number, index: number) => {
        Column() {
          Text(`${scheduleIndex}`) // 下标数字（1/2/3...）
            .fontSize(12)
            .fontColor($r('[basic].color.standard_font_color'))
          Text('00:00') // todo 时间
            .fontSize(10)
            .fontColor($r('[basic].color.standard_font_color'))
          Text('00:00')
            .fontSize(10)
            .fontColor($r('[basic].color.standard_font_color'))
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .height(60)
        .borderRadius(18)
        // 下标胶囊的相对布局规则：第一个下标对齐分割栏底部，后续下标对齐上一个下标底部
        .alignRules({
          top: ComponentConst.bindBottom(index === 0 ?
            this._periodIdArray[timePeriodIndex] :
            this._scheduleIndexIdArray[scheduleIndex - 1]
          ),
        })
        .margin({
          top: 5,
          left: this.horizontalPadding,
          right: 5
        })
        .id(this._scheduleIndexIdArray[scheduleIndex]) // 下标胶囊唯一ID（用于日程卡片的上下定位）
      }, (item: number) => item.toString()) // ForEach唯一标识：下标数字
    }, (item: TimeInfo) => item.periodName.toString()) // ForEach唯一标识：时间段名称
  }

  /**
   * 构建器：日程信息卡片
   * 仅当指南线计算完成后才绘制，根据日程的下标和星期几，自动定位到对应位置
   * @param currentWeekCourses 当前周的课程列表
   */
  @Builder scheduleFlowBuilder(currentWeekCourses: CourseInfo[]) {
    // 指南线未计算完成，不绘制
    if (this.drawStep === DrawStep.VERTICAL_GUIDELINE) {
      // 循环渲染每个日程卡片
      ForEach(currentWeekCourses, (courseInfo: CourseInfo, index: number) => {
        Stack() {
          Column() {
            Text() {
              Span(courseInfo.courseName) // 课程名称
              Span('@' + courseInfo.courseCampus) // 校区
              Span(courseInfo.courseLocation) // 地点
            }
            .width('100%')
            .height('100%')
            .fontSize(13)
            .fontColor(Color.White) // 日程文字色
            .fontWeight(FontWeight.Bold)
            .borderRadius(12)

            Text(courseInfo.courseTeacher) // 老师
              .width('100%')
              .height('100%')
              .fontSize(13)
              .fontColor(Color.White) // 日程文字色
              .fontWeight(FontWeight.Regular)
              .borderRadius(12)
          }
          .justifyContent(FlexAlign.Center)
          .width('100%')
          .alignItems(HorizontalAlign.Center)
        }
        .clip(true)
        .borderWidth(2) // 边框宽度
        .borderColor(courseInfo.darkColor) // 边框色（半透明）
        .borderRadius(6) // 卡片圆角
        .backgroundColor(courseInfo.standardColor) // 背景色（低透明度）
        // 日程卡片的核心定位规则：基于下标胶囊上下对齐，基于星期几指南线左右对齐
        .alignRules({
          top: ComponentConst.bindTop(this._scheduleIndexIdArray[courseInfo.daySchedule[0]]), // 上对齐开始下标
          bottom: ComponentConst.bindBottom(this._scheduleIndexIdArray[courseInfo.daySchedule[1]]), // 下对齐结束下标
          left: ComponentConst.bindStart(this.verticalGuidelines[2 + courseInfo.weekDay * 2].id), // 修复：指南线下标偏移
          right: ComponentConst.bindEnd(this.verticalGuidelines[2 + courseInfo.weekDay * 2 + 1].id), // 修复：指南线下标偏移
        })
        .padding({ left: 2, right: 2 }) // 卡片内边距
        .margin({ bottom: 5 }) // 卡片底部外边距
        .id(`${this._SCHEDULE_INFO_SUFFIX}${index}`) // 日程卡片唯一ID
        .onClick(() => {
          // 触发日程点击回调（可选链，避免回调未定义时报错）
          this.scheduleClick?.(courseInfo);
        })
      }, (item: CourseInfo) => `${item.weekDay}_${item.daySchedule.join('_')}_${item.courseName}_${item.weekNumber.join('_')}`)
    }
  }

  /**
   * 核心方法：计算垂直指南线的位置
   * 指南线是整个组件自适应布局的核心，仅当顶部栏和根容器都布局完成后才执行
   * 计算完成后更新指南线数组，并切换绘制步骤为VERTICAL_GUIDELINE
   */
  computeVerticalGuideline() {
    // 未完成布局，直接返回（避免重复计算/计算错误）
    if (!this.isTopBarLayout || !this.isRootLayout) {
      return;
    }
    // 获取当前周的顶部月份胶囊ID
    const currentTopBarId = `${this._TOP_BAR_ANCHOR}_${this.currentWeekNumber}`;
    // 获取顶部月份胶囊的布局信息（坐标、宽高，px单位）
    const topBarInfo = this.getUIContext().getComponentUtils().getRectangleById(currentTopBarId);
    // 获取当前周的根容器ID
    const currentRootId = `schedule_flow_root_${this.currentWeekNumber}`;
    // 获取根容器的布局信息（px单位）
    const parentInfo = this.getUIContext().getComponentUtils().getRectangleById(currentRootId);

    // 容错处理：如果获取不到布局信息，使用默认值
    if (!topBarInfo || !parentInfo) {
      console.warn('获取布局信息失败，使用默认值');
      return;
    }

    // 转换px到vp：计算月份胶囊右侧的起始横坐标（指南线的左侧偏移）
    const leftVp = this.getUIContext().px2vp(topBarInfo.localOffset.x + topBarInfo.size.width);
    // 转换px到vp：根容器的宽度
    const parentWidth = this.getUIContext().px2vp(parentInfo.size.width);
    const space = 8; // 日期卡片之间的间距（包括首尾）
    const count = 7; // 一周7天，固定数量
    // 计算每个日期卡片的宽度：自适应平分剩余空间
    const targetWidth = (parentWidth - leftVp - (count + 1) * space) / count;

    let newVerticalGuidelines: GuideLineStyle[] = [];
    // 循环生成7天的左右指南线（共14条）
    for (let i = 0; i < count; i++) {
      // 左侧指南线：当前日期的左边界
      newVerticalGuidelines.push({
        id: `${this._guidelineIdArray[i * 2]}_${this.currentWeekNumber}`, // 周唯一ID
        direction: Axis.Vertical, // 垂直指南线
        position: { start: leftVp + space + i * (space + targetWidth) }, // 起始位置（从左到右）
      });
      // 右侧指南线：当前日期的右边界
      newVerticalGuidelines.push({
        id: `${this._guidelineIdArray[i * 2 + 1]}_${this.currentWeekNumber}`, // 周唯一ID
        direction: Axis.Vertical,
        position: { start: leftVp + (i + 1) * (space + targetWidth) },
      });
    }
    // 关键：添加2个空指南线占位，让星期几的下标与指南线下标严格匹配
    const emptyGuidelineStyle0: GuideLineStyle = { id: `empty_guideline_0_${this.currentWeekNumber}`, direction: Axis.Vertical, position: { start: 0 } };
    const emptyGuidelineStyle1: GuideLineStyle = { id: `empty_guideline_1_${this.currentWeekNumber}`, direction: Axis.Vertical, position: { start: 0 } };
    newVerticalGuidelines = [emptyGuidelineStyle0, emptyGuidelineStyle1, ...newVerticalGuidelines];

    // 更新指南线数组（响应式，触发组件重新渲染）
    this.verticalGuidelines = newVerticalGuidelines;
    // 切换绘制步骤，允许绘制所有依赖指南线的组件
    this.drawStep = DrawStep.VERTICAL_GUIDELINE;
  }

  /**
   * 计算指定时间段分割下的日程下标范围
   * 为scheduleDivideBuilder提供下标数组，用于循环生成下标胶囊
   * @param divideTimeIndex 时间段分割的索引
   * @returns number[] 连续的下标数组（如[1,2,3,4]）
   */
  getDivideIndexRange(divideTimeIndex: number): number[] {
    // 开始下标：第一个时间段从1开始，后续从上个时间段的结束下标+1开始
    const startIndex = divideTimeIndex === 0 ? 1 : this.divideTimes[divideTimeIndex - 1].divideTime + 1;
    // 结束下标：当前时间段的结束下标+1（NumberUtil.range为左闭右开）
    const endIndex = this.divideTimes[divideTimeIndex].divideTime + 1;
    // 生成连续的下标数组（NumberUtil自定义工具，左闭右开）
    return NumberUtil.range([startIndex, endIndex]);
  }

  // 星期几简写资源数组
  private weekDayShort: Array<ResourceStr> = [
    $r('[basic].string.monday_short'),
    $r('[basic].string.tuesday_short'),
    $r('[basic].string.wednesday_short'),
    $r('[basic].string.thursday_short'),
    $r('[basic].string.friday_short'),
    $r('[basic].string.saturday_short'),
    $r('[basic].string.sunday_short'),
  ];
}