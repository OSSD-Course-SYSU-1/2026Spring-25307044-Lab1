import TabsView from "../components/TabsView"
import DbUtil from "../util/DbUtil"
import LoginPage from "./LoginPage"


@Entry
@Component
struct Index {

  @State isLogin:boolean = false
  @State showLaunchPage: boolean = true
  @State cutDown: string = '跳过(5s)'

  private intervalId:number = -1

  aboutToAppear(): void {

    let time =4
    this.intervalId = setInterval(()=>{
      this.cutDown = `跳过(${time}s)`
      time -= 1
      if (time <= 0) {
        this.showLaunchPage = false
        clearInterval(this.intervalId)
      }
    },1000)

  }

  build() {
    Column(){
      if (this.isLogin==false){
        LoginPage({isLogin:this.isLogin})
      }else {
        TabsView()
      }
    }
    .width("100%")
    .height("100%")
    .backgroundColor("#f3f4f5")
    .bindContentCover(
      this.showLaunchPage,
      this.LaunchPageBuilder(),
      {
        modalTransition: ModalTransition.ALPHA,
        backgroundColor: '#373737',
        onDisappear: () => {},
        onWillDismiss: (action: DismissContentCoverAction) => {

        }
      }
    )
  }

  @Builder
  LaunchPageBuilder(){
    Column(){
      Stack({alignContent:Alignment.Top}){
        Image($r('app.media.launch'))
          .height('100%')
          .expandSafeArea([SafeAreaType.SYSTEM, SafeAreaType.CUTOUT])

        Text(this.cutDown)
          .textAlign(TextAlign.Center)
          .fontColor(Color.White)
          .width(100)
          .height(30)
          .backgroundColor('#00aaea')
          .borderRadius(15)
          .margin({top:50,left:250})
          .onClick(()=>{
            this.showLaunchPage = false
          })
      }
      .width('100%')
      .height('100%')
    }
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
    // .expandSafeArea([SafeAreaType.SYSTEM, SafeAreaType.CUTOUT])
  }
}
