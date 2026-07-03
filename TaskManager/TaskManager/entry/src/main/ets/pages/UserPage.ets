import { router } from "@kit.ArkUI";
import { emitter } from "@kit.BasicServicesKit";
import { preferences } from "@kit.ArkData";

/**
 * 我的 页面
 */
@Entry
@Component
export default struct UserPage{

  @State name:string = '任务大师'

  aboutToAppear(): void {
    let options: preferences.Options = { name: 'myStore' };
    let dataPreferences = preferences.getPreferencesSync(getContext(), options);
    emitter.on('InfoModifySucces',()=>{
      let lastAccount:string = dataPreferences?.getSync('Name','') as string;
      this.name = lastAccount
    })
  }



  build() {
    Column() {
      Row(){
        Text("个人信息").fontWeight(500).fontSize(18).margin({ bottom:10 })
      }
      .width("100%")
      .padding({ top:10,bottom:5,right:5,left:5 })
      .backgroundColor("#fff")
      .justifyContent(FlexAlign.Center)
      Stack({alignContent:Alignment.Start}){
        Image($r('app.media.guankong_beijing'))
          .width('100%')
          .height(150)
       Row(){
         Image($r('app.media.person_selected'))
           .width(70)
           .height(70)
           .borderRadius(35)
           .backgroundColor(Color.White)
           .margin({left:15,right:15})
         Column(){
           Text(this.name).fontSize(22).fontWeight(800).margin({top:10 ,bottom:10 })
           Text("任务大师，畅享美好生活").fontSize(15).fontWeight(500)
         }
         .alignItems(HorizontalAlign.Start)
       }

      }

      List() {
        this.Divider()
        ListItem(){
          Column(){
            Row(){
              Text(`个人信息`)
                .fontWeight(500)
                .fontSize(18)
                .margin({left:10})
              Blank()
             Image($r('app.media.right'))
               .width(20)
               .height(20)
               .margin({right:10})
            }
            .justifyContent(FlexAlign.Center)
            .width('100%')
            .margin({top:15,bottom:15})
            .onClick(()=>{
              router.pushUrl({url:'pages/EditeUserInfoPage'})
            })
            this.Divide1()

            Row(){
              Text(`修改密码`)
                .fontWeight(500)
                .fontSize(18)
                .margin({left:10})
              Blank()
              Image($r('app.media.right'))
                .width(20)
                .height(20)
                .margin({right:10})
            }
            .justifyContent(FlexAlign.Center)
            .width('100%')
            .margin({top:15,bottom:15})
            .onClick(()=>{
              router.pushUrl({url:'pages/ModifyPsdPage'})
            })
            this.Divide1()

            Row(){
              Text(`关于我们`)
                .fontWeight(500)
                .fontSize(18)
                .margin({left:10})
              Blank()
              Image($r('app.media.right'))
                .width(20)
                .height(20)
                .margin({right:10})
            }
            .justifyContent(FlexAlign.Center)
            .width('100%')
            .margin({top:15,bottom:15})
            .onClick(()=>{
              AlertDialog.show(
                {
                  title: '关于我们',
                  message: '开发者：xxxx \n联系方式：188888888888',
                  autoCancel: true,
                  alignment: DialogAlignment.Center,
                  offset: { dx: 0, dy: -20 },
                  gridCount: 3,
                  confirm: {
                    value: '确定',
                    action: () => {
                      console.info('Button-clicking callback')
                    }
                  }
                }
              )
            })
            this.Divide1()

            Row(){
              Text(`意见反馈`)
                .fontWeight(500)
                .fontSize(18)
                .margin({left:10})
              Blank()
              Image($r('app.media.right'))
                .width(20)
                .height(20)
                .margin({right:10})
            }
            .justifyContent(FlexAlign.Center)
            .width('100%')
            .margin({top:15,bottom:15})
            .onClick(()=>{
              router.pushUrl({url:'pages/FeedbackPage'})
            })
            this.Divide1()
          }
          .backgroundColor(Color.White)
          .margin({left:15,right:15})
          .borderRadius(15)
        }
      }
      .width('100%')

      Button('退出登录', { type: ButtonType.Capsule })
        .width('90%')
        .height(45)
        .backgroundColor('#00aaea')
        .margin({ top: 20 })
        .onClick(()=>{
          emitter.emit('logout')
        })

    }
    .height('100%')
    .width('100%')
    .backgroundColor("#f3f4f5")
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
}