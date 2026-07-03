import { Prompt, router } from "@kit.ArkUI"
import { preferences } from "@kit.ArkData";
import { emitter } from "@kit.BasicServicesKit";


@Entry
@Component
export default struct EditeUserInfoPage{

  @State psd1:string  = ''


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
  @Builder Divide1() {
    ListItem(){
      Divider().strokeWidth(1).color('#f2f3f5')
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
          Text("编辑个人信息").fontSize(18).fontWeight(500).fontSize(18).margin({ bottom:10 })
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
              Text(`姓名：`)
                .fontWeight(500)
                .fontSize(18)
                .margin({left:10})
              Text(`*`)
                .fontColor(Color.Red)
                .fontWeight(500)
                .fontSize(18)
                .margin({left:0})
              TextInput({ text: this.psd1 ,placeholder: '请输入姓名' })
                .width(250)
                .height(45)
                .borderRadius(5)
                .margin({top:10,left:10,bottom:10,right:10})
                .onChange((value: string) => {
                  this.psd1 = value
                })
            }
            .justifyContent(FlexAlign.Start)
            .width('100%')
            .margin({top:10,bottom:5})

            this.Divide1()

            Row(){
              Text(`性别：`)
                .fontWeight(500)
                .fontSize(18)
                .margin({left:10})
              Text(`*`)
                .fontColor(Color.Red)
                .fontWeight(500)
                .fontSize(18)
                .margin({left:0,right:5})

              Text(`男`)
                .fontWeight(500)
                .fontSize(18)
                .margin({left:10})

              Toggle({ type: ToggleType.Checkbox, isOn: false })
                .size({ width: 20, height: 20 })
                .selectedColor('#00aaea')
                .onChange((isOn: boolean) => {

                })

              Text(`女`)
                .fontWeight(500)
                .fontSize(18)
                .margin({left:10})

              Toggle({ type: ToggleType.Checkbox, isOn: false })
                .size({ width: 20, height: 20 })
                .selectedColor('#00aaea')
                .onChange((isOn: boolean) => {

                })
            }
            .justifyContent(FlexAlign.Start)
            .width('100%')
            .margin({top:22.5,bottom:17.5})

            this.Divide1()

            Row(){
              Text(`手机：`)
                .fontWeight(500)
                .fontSize(18)
                .margin({left:10})
              Text(`*`)
                .fontColor(Color.Red)
                .fontWeight(500)
                .fontSize(18)
                .margin({left:0})
              TextInput({ text: '',placeholder: '请输入手机' })
                .width(250)
                .height(45)
                .borderRadius(5)
                .margin({top:10,left:10,bottom:10,right:10})

            }
            .justifyContent(FlexAlign.Start)
            .width('100%')
            .margin({top:10,bottom:5})

            this.Divide1()

            Row(){
              Text(`邮箱：`)
                .fontWeight(500)
                .fontSize(18)
                .margin({left:10})
              Text(`*`)
                .fontColor(Color.Red)
                .fontWeight(500)
                .fontSize(18)
                .margin({left:0})
              TextInput({ text: '',placeholder: '请输入邮箱' })
                .width(250)
                .height(45)
                .borderRadius(5)
                .margin({top:10,left:10,bottom:10,right:10})

            }
            .justifyContent(FlexAlign.Start)
            .width('100%')
            .margin({top:10,bottom:5})
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
          if (this.psd1.length>0) {
            this.dataPreferences?.putSync('Name',this.psd1)
            this.dataPreferences?.flush()
            emitter.emit('InfoModifySucces')
            router.back()
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