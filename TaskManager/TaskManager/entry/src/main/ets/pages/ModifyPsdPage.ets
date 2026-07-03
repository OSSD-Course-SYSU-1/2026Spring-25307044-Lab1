import { Prompt, router } from "@kit.ArkUI"
import { preferences } from "@kit.ArkData";
import { emitter } from "@kit.BasicServicesKit";


@Entry
@Component
export default struct ModifyPsdPage{

  @State psd1:string  = ''
  @State psd2:string  = ''

  dataPreferences: preferences.Preferences | null = null;
  aboutToAppear(): void {
    let options: preferences.Options = { name: 'myStore' };
    this.dataPreferences = preferences.getPreferencesSync(getContext(), options);

  }

  @Builder Divider() {
    ListItem(){
      Divider().strokeWidth(10).color('#f2f3f5')
    }
  }

  build() {
    Column() {
      Stack(){
        Row() {
          Image($r("app.media.back")).width(20)
          Text("返回").padding({ left: 2 })
        }
        .width("100%")
        .backgroundColor(Color.White)
        .padding({ top: 15, bottom: 15, right: 5, left: 5 })
        .onClick(() => {
          router.back()
        })
        Row(){
          Text("修改密码").fontSize(18).fontWeight(500).fontSize(18).margin({ bottom:10 })
        }
        .padding({ top:10,bottom:5,right:5,left:5 })
        .backgroundColor("#fff")
        .justifyContent(FlexAlign.Center)
      }

      this.Divider()
      List() {
        ListItem(){
          Column(){
            Row(){
              Text(`新密码：`)
                .fontWeight(500)
                .fontSize(18)
                .margin({left:10})
              Text(`*`)
                .fontColor(Color.Red)
                .fontWeight(500)
                .fontSize(18)
                .margin({left:0})
            }
            .justifyContent(FlexAlign.Start)
            .width('100%')
            .margin({top:10,bottom:5})
            TextInput({ text: this.psd1 ,placeholder: '请输入新密码' })
              .height(45)
              .borderRadius(5)
              .margin({top:10,left:10,bottom:10,right:10})
              .onChange((value: string) => {
                this.psd1 = value
              })

            TextInput({ text:  this.psd2 ,placeholder: '请再次输入新密码' })
              .height(45)
              .borderRadius(5)
              .margin({top:10,left:10,bottom:10,right:10})
              .onChange((value: string) => {
                this.psd2 = value
              })
          }
          .backgroundColor(Color.White)
          .margin({left:15,right:15})
          .borderRadius(15)
        }
      }
      .width('100%')

      Blank()
      Button('确认', { type: ButtonType.Capsule })
        .width('90%')
        .height(45)
        .backgroundColor('#00aaea')
        .margin({ top: 20 })
        .onClick(()=>{
          if (this.psd1.length > 0 && this.psd2.length > 0) {
            if (this.psd1 == this.psd2) {
              let lastAccount:string = this.dataPreferences?.getSync('lastAccount','') as string;
              this.dataPreferences?.putSync(lastAccount,this.psd1)
              this.dataPreferences?.putSync('lastPsd',this.psd1)
              this.dataPreferences?.flush()
              Prompt.showToast({ message:"修改成功" })
              router.back()
            }else {
              Prompt.showToast({ message:"两次输入密码不一致" })
            }
          }else {
            Prompt.showToast({ message:"新密码不能为空" })
          }
        })
    }
    .height('100%')
    .width('100%')
    .backgroundColor("#f3f4f5")
  }

}