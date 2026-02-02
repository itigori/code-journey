
/**
 * 用于避免短时间内重复点击的工具类
 */
export class AvoidRepeatClick {
  private static readonly CLICK_INTERVAL: number = 800 // 800ms 内不允许重复点击
  private static lastClickTime: number = 0

  /**
   * 检查是否为重复点击
   * @returns true if it's a repeat click, false otherwise.
   */
  public static isRepeatClick(): boolean {
    const currentTime = Date.now()
    if (currentTime - AvoidRepeatClick.lastClickTime < AvoidRepeatClick.CLICK_INTERVAL) {
      return true
    }
    AvoidRepeatClick.lastClickTime = currentTime
    return false
  }

  /**
   * 执行一个不会重复点击的动作
   * @param action 要执行的函数
   */
  public static avoidRepeatClick(action: Function): void {
    if (!AvoidRepeatClick.isRepeatClick()) {
      action()
    }
  }
}
