import UIAbility from "@ohos.app.ability.UIAbility";
import { display, window } from '@kit.ArkUI';

export default class EntryAbility extends UIAbility {
  private windowObj?: window.Window
  private curBp: string = ''

  // 根据当前窗口尺寸更新断点
  private updateBreakPoint(windowWidth: number): void{
    // 将长度的单位由px换算为vp
    // 此处可以直接用let windowWidthVp = windowWidth / display.getDefaultDisplaySync().densityPixels，不必进行try/catch
    try {
      let windowWidthVp = windowWidth / display.getDefaultDisplaySync().densityPixels
      let newBp: string = ''
      if (windowWidthVp < 320) {
       newBp = 'xs'
      } else if (windowWidthVp < 600) {
       newBp = 'sm'
      } else if (windowWidthVp < 840) {
       newBp = 'md'
      } else {
        newBp = 'lg'
      }
      if (this.curBp !== newBp) {
       this.curBp = newBp
       // 使用状态变量记录当前断点值
       AppStorage.setOrCreate('currentBreakPoint', this.curBp)
    }
    } catch (error) {
      console.error('windowWidthVp is break')
    }
  }

    async onWindowStageCreate(windowStage: window.WindowStage): Promise<void> {
    // let windowClass: window.Window
    windowStage.getMainWindow().then((windowObj) => {
      this.windowObj = windowObj
      // windowClass.setWindowLayoutFullScreen(true);
      // 获取应用启动时的窗口尺寸
      this.updateBreakPoint(windowObj.getWindowProperties().windowRect.width)
      // 注册回调函数，监听窗口尺寸变化
      windowObj.on('windowSizeChange', (windowSize)=>{
        this.updateBreakPoint(windowSize.width)
      })
    })
  }
}

