import { Prompt, promptAction, router } from "@kit.ArkUI"
import { UserEntity } from "../entity/UserEntity"
import { preferences } from "@kit.ArkData"


/**
 * 注册页面
 */
@Entry
@Component
export default struct RegisterPage {
  // 使用UserEntity接收数据
  @State user: UserEntity = new UserEntity()
  @State verifyCode: string = ''
  @State countdown: number = 0
  @State buttonText: string = '获取验证码'
  dataPreferences: preferences.Preferences | null = null;
  // 显示成功弹窗
  private showSuccess(message: string) {
    promptAction.showDialog({
      title: '操作成功',
      message: message,
      buttons: [{ text: '确定', color: '#333' }],
      backgroundColor: '#E8F5E9',
    });
  }

  // 显示错误弹窗
  private showError(message: string) {
    promptAction.showDialog({
      title: '操作失败',
      message: message,
      buttons: [{ text: '确定', color: '#333'}],
      backgroundColor: '#FFEBEE',
    });
  }

  aboutToAppear(): void {
    let options: preferences.Options = { name: 'myStore' };
    this.dataPreferences = preferences.getPreferencesSync(getContext(), options);
  }

  //使用定时器实现倒计时逻辑
  //点击后触发60秒倒计时，倒计时期间按钮变为灰色不可用
  startCountdown() {
    if (this.countdown > 0) {
      return
    }

    this.countdown = 60
    this.buttonText = `${this.countdown}s后重发`
    let timer = setInterval(() => {
      this.countdown--
      if (this.countdown <= 0) {
        clearInterval(timer)
        this.buttonText = '获取验证码'
      } else {
        this.buttonText = `${this.countdown}s后重发`
      }
    }, 1000)
  }

  build() {
    Column() {
      Row() {
        Image($r("app.media.back")).width(20)
        Text("返回").padding({ left: 2 })
      }
      .width("100%")
      .padding({
        top: 10,
        bottom: 5,
        right: 5,
        left: 5
      })
      .onClick(() => {
        router.back()
      })
      // 标题
      Text('新用户注册')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 40, bottom: 40 })
      // 手机号输入
      TextInput({ placeholder: '请输邮箱/手机号' })
        .onChange(value => this.user.phone = value)
        .width('90%')
        .height(50)
        .type(InputType.Number)
        .maxLength(11)
        .margin({ bottom: 15 })

      // 密码输入
      TextInput({ placeholder: '请输入密码' })
        .width('90%')
        .height(50)
        .type(InputType.Password)//使用密码类型隐藏内容
        .maxLength(20)
        .margin({ bottom: 40 })
        .onChange(value => this.user.password = value)

      // 注册按钮  胶囊形状的注册按钮
      Button('立即注册', { type: ButtonType.Capsule })
        .width('90%')
        .height(50)
        .backgroundColor('#00aaea')
        .onClick(() => {
          // if (this.user.validatePhone() && this.user.validatePassword()) {
            if (this.user.phone.length > 0 && this.user.password.length >0) {
              this.dataPreferences?.putSync(this.user.phone,this.user.password)
              this.dataPreferences?.flush()
            Prompt.showToast({ message:"注册成功" })
            router.back()
          } else {
            // 显示错误提示
            this.showError('账号或密码不合法！');
          }
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .alignItems(HorizontalAlign.Center)
  }
}