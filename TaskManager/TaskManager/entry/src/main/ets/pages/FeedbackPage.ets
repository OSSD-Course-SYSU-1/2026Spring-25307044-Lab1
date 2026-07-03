import { Prompt, router } from "@kit.ArkUI"


@Entry
@Component
export default struct FeedbackPage{

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
          Text("意见反馈").fontSize(18).fontWeight(500).fontSize(18).margin({ bottom:10 })
        }
        .padding({ top:10,bottom:5,right:5,left:5 })
        .backgroundColor("#fff")
        .justifyContent(FlexAlign.Center)

      }
      Stack({alignContent:Alignment.Start}){
        Image($r('app.media.guankong'))
          .width('100%')
          .height(150)
        Row(){
          Column(){
            Text("我们正在倾听...").fontSize(22).fontWeight(800).margin({top:10 ,bottom:10 })
            Text("一直在努力的路上，我们期待您的宝贵意见").fontSize(15).fontWeight(500)
          }
          .margin({left:15,right:15})
          .alignItems(HorizontalAlign.Start)
        }

      }
      this.Divider()
      this.Divider()
      List() {
        ListItem(){
          Column(){
            Row(){
              Text(`反馈标题：`)
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
            TextInput({ text: '' ,placeholder: '请输入反馈标题' })
              .height(45)
              .borderRadius(5)
              .margin({top:10,left:10,bottom:10,right:10})
          }
          .backgroundColor(Color.White)
          .margin({left:15,right:15})
          .borderRadius(15)
        }
        this.Divider()
        ListItem(){
          Column(){
            Row(){
              Text(`问题描述：`)
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
            TextArea({ text: '' ,placeholder: '说点什么吧...' })
              .height(200)
              .borderRadius(5)
              .margin({top:10,left:10,bottom:10,right:10})
          }
          .backgroundColor(Color.White)
          .margin({left:15,right:15})
          .borderRadius(15)
        }
      }
      .width('100%')

      Blank()
      Button('提交', { type: ButtonType.Capsule })
        .width('90%')
        .height(45)
        .backgroundColor('#00aaea')
        .margin({ top: 20 })
        .onClick(()=>{
          Prompt.showToast({ message:"反馈成功" })
          router.back()
        })
    }
    .height('100%')
    .width('100%')
    .backgroundColor("#f3f4f5")
  }

}