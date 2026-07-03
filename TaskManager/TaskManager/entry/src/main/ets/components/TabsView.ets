import HomePage from "../pages/HomePage"
import PersonPage from "../pages/PersonPage"
import UserPage from "../pages/UserPage"
import { emitter } from "@kit.BasicServicesKit"

@Component
export default struct TabsView{

  @State currentIndex:number = 0

  // 自定义tabs
  @Builder tabBuilder(title:string,targetIndex:number,selectedImg:Resource,Img:Resource){
    Column(){
      Image(this.currentIndex === targetIndex ? selectedImg : Img)
        .size({ width:28,height:28 })
      Text(title)
        .fontSize(14).
      fontColor(this.currentIndex === targetIndex ? '#00aaea' : "#dfdfdf")
    }
    .width("100%")
    .height(60)
    .justifyContent(FlexAlign.Center)
  }
  private tabBarController: TabsController = new TabsController()


  build() {
    Column(){
      Tabs({ barPosition:BarPosition.End,controller:this.tabBarController }){
        TabContent(){
          Column(){
            HomePage()
          }
          .width("100%").height("100%").backgroundColor("#f3f4f5")
        }.tabBar(this.tabBuilder("任务",0,$r("app.media.home_selected"),$r("app.media.home_default")))

        TabContent(){
          Column(){
            UserPage()
          }
          .width("100%").height("100%").backgroundColor("#f3f4f5")
        }.tabBar(this.tabBuilder("我的",1,$r("app.media.mine_selected"),$r("app.media.mine_default")))
      }
      .backgroundColor("#fff")
      .scrollable(false)
      .onChange((index:number) =>{
        this.currentIndex = index
      })
    }
    .width("100%")
    .height("100%")
    .backgroundColor("#f3f4f5")
    .alignItems(HorizontalAlign.Center)
  }
}