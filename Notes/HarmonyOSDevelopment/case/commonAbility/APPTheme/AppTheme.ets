import { CustomColors, CustomTheme } from '@ohos.arkui.theme'


// 默认主题
export class DefaultColors implements CustomColors {
  brand?: ResourceColor | undefined = $r('app.color.celestmoe_main_color')
  fontPrimary?: ResourceColor | undefined = $r('app.color.standard_font_color')
  fontSecondary?: ResourceColor | undefined = $r('app.color.main_grey')
  fontOnSecondary?: ResourceColor | undefined = $r('app.color.main_grey')
  fontOnPrimary?: ResourceColor | undefined = $r('app.color.standard_font_color_vice')
  iconPrimary?: ResourceColor | undefined = $r('app.color.celestmoe_main_color')
  iconSecondary?: ResourceColor | undefined = $r('app.color.celestmoe_vice_color')
}

export class DefaultTheme implements CustomTheme {
  public colors: DefaultColors = new DefaultColors()
}

export const defaultAppTheme: CustomTheme = new DefaultTheme()


// 星乐主题
export class HoshinoColors implements CustomColors {
  brand?: ResourceColor | undefined = $r('app.color.hoshino_main_color')
  fontPrimary?: ResourceColor | undefined = $r('app.color.standard_font_color')
  fontSecondary?: ResourceColor | undefined = $r('app.color.main_grey')
  fontOnSecondary?: ResourceColor | undefined = $r('app.color.main_grey')
  fontOnPrimary?: ResourceColor | undefined = $r('app.color.standard_font_color_vice')
  iconPrimary?: ResourceColor | undefined = $r('app.color.hoshino_main_color')
  iconSecondary?: ResourceColor | undefined = $r('app.color.hoshino_vice_color')
}

export class HoshinoTheme implements CustomTheme {
  public colors: HoshinoColors = new HoshinoColors()
}

export const hoshinoAppTheme: CustomTheme = new HoshinoTheme()


export function getThemeMainColor(key: CustomTheme): Resource {
  if (key === defaultAppTheme) {
    return $r('app.color.celestmoe_main_color')
  }
  if (key === hoshinoAppTheme) {
    return $r('app.color.hoshino_main_color')
  }
  else {
    return $r('app.color.celestmoe_main_color')
  }
}
