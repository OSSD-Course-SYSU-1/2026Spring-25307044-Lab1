import { Prompt, router } from '@kit.ArkUI'
import { preferences } from '@kit.ArkData'
import { emitter } from '@kit.BasicServicesKit'

/**
 * 登录页面
 */
@Component
export default struct LoginPage {
  @State phone: string = ''
  @State password: string = ''
  @Link isLogin: boolean
  dataPreferences: preferences.Preferences | null = null;

  aboutToAppear(): void {
    let options: preferences.Options = { name: 'myStore' };
    this.dataPreferences = preferences.getPreferencesSync(getContext(), options);
    let lastAccount:string = this.dataPreferences?.getSync('lastAccount','') as string;
    let lastPsd:string = this.dataPreferences?.getSync('lastPsd','') as string;
    if (lastAccount.length > 0 && lastPsd.length > 0)  {
      this.phone = lastAccount
      this.password = lastPsd
    }

    emitter.on('logout',()=>{
      this.isLogin = false
    })
  }

  build() {
    Column() {
      // 标题部分
      Row() {
        Image($r("app.media.apIcon")).width(80)
          .borderRadius(10)
      }
      .margin({ top: 120, bottom: 60 })

      // 输入框区域
      Column() {
        TextInput({text: this.phone, placeholder: '请输入邮箱/手机号' })
          .width('80%')
          .height(50)
          .margin({ bottom: 20 })
          .borderRadius(8)

          .fontColor(Color.Black)
          .backgroundColor("#f2f3f5")
          .borderWidth(1)
          .borderWidth(Color.White)
          .padding(8)
          .type(InputType.Number)
          .onChange(value => this.phone = value)

        TextInput({text: this.password, placeholder: '请输入密码' })
          .width('80%')
          .height(50)
          // .placeholderColor(Color.Gray)
          .margin({ bottom: 30 })
          .borderRadius(8)
          .fontColor(Color.Black)
          .backgroundColor(Color.White)
          .backgroundColor("#f2f3f5")
          .borderWidth(1)
          .borderWidth(Color.White)
          .padding(8)
          .type(InputType.Password)
          .onChange(value => this.password = value)
      }

      Blank()

      Row(){
        // 登录按钮
        Button('登录', { type: ButtonType.Capsule })
          .width('40%')
          .height(50)
          .backgroundColor('#00aaea')
          .margin({ bottom: 20 })
          .onClick(()=>{
            let ps:string = this.dataPreferences?.getSync(this.phone,'') as string;
            if(ps.length>0){
              //登录成功修改首页登录状态
              if (ps == this.password) {
                this.isLogin = true
                Prompt.showToast({ message:"登录成功"})
                this.dataPreferences?.putSync('lastAccount',this.phone)
                this.dataPreferences?.putSync('lastPsd',this.password)
                this.dataPreferences?.flush()
                this.isLogin = true
              }else {
                Prompt.showToast({
                  message:"密码错误"
                })
              }
            }
            else {
              Prompt.showToast({
                message:"账号未注册"
              })
            }
          })

        Button('注册', { type: ButtonType.Capsule })
          .width('40%')
          .height(50)
          .fontColor('#00aaea')
          .backgroundColor(Color.White)
          .borderWidth(1)
          .borderColor('#00aaea')
          .margin({ bottom: 20 })
          .onClick(() => {
            // 处理注册跳转
            router.pushUrl({url:'pages/RegisterPage'})
          })
      }
      .justifyContent(FlexAlign.SpaceAround)
      .width('100%')



    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ffff')
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
    .backgroundImage($r("app.media.AppBg"))
    .backgroundImageSize({width:'100%',height:'100%'})
    .expandSafeArea([SafeAreaType.SYSTEM],[SafeAreaEdge.TOP,SafeAreaEdge.BOTTOM])
  }
}