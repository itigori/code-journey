import text from '@ohos.graphics.text';
import { defaultAppTheme, getThemeMainColor } from './AppTheme';

@Component
export struct component {
    //调用主题
    @State myTheme: CustomTheme = defaultAppTheme

    build() {
        Column() {
            WithTheme({ theme : this.myTheme }) {
                Text('根据系统token值变色，此为一级标题，自动变色')

                Column() {

                }
                .width(30)
                .aspectRatio(1)
                .backgroundColor(getThemeMainColor(this.myTheme))
            }
        }
    }
}