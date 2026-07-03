import { emitter } from "@kit.BasicServicesKit";

@Entry
@Component
export default struct PersonPage {


  @State loading: boolean = false;
  @State deviceState :string = ''
  @State currentValue :number = 0
  @State list:string[] = []

  aboutToAppear(): void {
    this.loadLog()
    emitter.on("TabChange",()=>{
     this.loadLog()
    })
  }

  loadLog(){
    this.list = ['1','2']
  }


  build() {
    Column(){
      Row(){
        Text("任务").fontSize(18).fontWeight(500).fontSize(18).margin({ bottom:10 })
      }
      .width("100%")
      .padding({ top:10,bottom:5,right:5,left:5 })
      .backgroundColor("#fff")
      .justifyContent(FlexAlign.Center)
      Divider().color("#f2f3f5").strokeWidth(1)

      if (this.list.length > 0){
        List(){
          ForEach(this.list,(item:string,index:number)=>{
            ListItem(){
              Column(){
                Text("操作时间："+item.split("==")[1])
                  .fontSize(14)
                  .margin({ left:15,top:10,bottom:10 })
                  .fontColor(Color.Gray)
                Text("日志内容:")
                  .fontSize(18)
                  .margin({ left:15,bottom:10 })
                  .fontColor("#00aaea")
                Text(item.split("==")[0])
                  .fontSize(18)
                  .margin({left:15, bottom:10 })
                Divider().strokeWidth(1).color("#f2f3f5")
              }
              .backgroundColor("#fff")
              .alignItems(HorizontalAlign.Start)
            }
          })
        }
        .margin({bottom:48})
      }else {
        Text("暂无日志").fontWeight(500).fontSize(18).margin({ top:50 })
      }
    }
  }
}



