import { router } from "@kit.ArkUI"
import Task from "../entity/Task";
import DbUtil from "../util/DbUtil";
import Toast from "../util/Toast";
import { emitter } from "@kit.BasicServicesKit";


@Entry
@Component
export default struct AddTaskPage{

  @State pageName:string = "添加任务"

  @State title:string = ""
  @State endDate:Date = new Date('2025-06-15');
  @State level:string = "高"
  @State level_index:number = 0
  @State tag:string = "工作"
  @State tag_index:number = 0
  @State content:string = ""
  private params:Record<string,string> = router.getParams() as Record<string,string>
  private task?:Task
  private index:number = -1
  aboutToAppear(): void {
    if (this.params) {
      this.pageName = "修改任务"
      this.task = JSON.parse(this.params["data"])
      this.index = parseInt(this.params["index"])

      this.title = this.task?.title ?? ""
      this.endDate = new Date(this.task?.endtime ?? "")

      this.level_index = this.task?.property ?? 0
      if ( this.level_index == 0) {
        this.level =  "高"
      }else if( this.level_index == 1){
        this.level =  "中"
      }else {
        this.level =  "低"
      }
      this.tag_index = this.task?.category ?? 0
      if ( this.tag_index == 0) {
        this.tag =  "工作"
      }else if( this.level_index == 1){
        this.tag =  "学习"
      }else {
        this.tag =  "生活"
      }
      this.content = this.task?.content ?? ""
    }
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
          Text(this.pageName).fontSize(18).fontWeight(500).fontSize(18).margin({ bottom:10 })
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
              Text(`任务标题：`)
                .fontWeight(500)
                .fontSize(18)
                .margin({left:10})
              Text(`*`)
                .fontColor(Color.Red)
                .fontWeight(500)
                .fontSize(18)
                .margin({left:0})
              TextInput({ text:$$this.title ,placeholder: '请输入任务标题' })
                .width(220)
                .height(45)
                .borderRadius(5)
                .margin({top:10,left:10,bottom:10,right:10})

            }
            .justifyContent(FlexAlign.Start)
            .width('100%')
            .margin({top:10,bottom:5})

            this.Divide1()

            Row(){
              Text(`截止时间：`)
                .fontWeight(500)
                .fontSize(18)
                .margin({left:10})
              Text(`*`)
                .fontColor(Color.Red)
                .fontWeight(500)
                .fontSize(18)
                .margin({left:0,right:5})

              CalendarPicker({ hintRadius: 10, selected:new Date()})
                .edgeAlign(CalendarAlign.END)
                .textStyle({ color: "#ff182431", font: { size: 20, weight: FontWeight.Normal } })
                .width(220)
                .height(45)
                .borderRadius(5)
                .margin({top:10,left:10,bottom:10,right:10})
                .onChange((value) => {
                  this.endDate = value
                })
            }
            .justifyContent(FlexAlign.Start)
            .width('100%')


            this.Divide1()

            Row(){
              Text(`任务等级：`)
                .fontWeight(500)
                .fontSize(18)
                .margin({left:10})
              Text(`*`)
                .fontColor(Color.Red)
                .fontWeight(500)
                .fontSize(18)
                .margin({left:0})
              Select([
                { value: '高'},
                { value: '中'},
                { value: '低'}
              ])
                .selected($$this.level_index)
                .value($$this.level)
                .width(220)
                .height(45)
                .borderRadius(5)
                .margin({top:10,left:10,bottom:10,right:10})


            }
            .justifyContent(FlexAlign.Start)
            .width('100%')
            .margin({top:10,bottom:5})

            this.Divide1()

            Row(){
              Text(`任务标签：`)
                .fontWeight(500)
                .fontSize(18)
                .margin({left:10})
              Text(`*`)
                .fontColor(Color.Red)
                .fontWeight(500)
                .fontSize(18)
                .margin({left:0})
              Select([
                { value: '工作'},
                { value: '学习'},
                { value: '生活'}
              ])
                .selected($$this.tag_index)
                .value($$this.tag)
                .width(220)
                .height(45)
                .borderRadius(5)
                .margin({top:10,left:10,bottom:10,right:10})

            }
            .justifyContent(FlexAlign.Start)
            .width('100%')
            .margin({top:10,bottom:5})

            this.Divide1()

            Row(){
              Text(`任务内容：`)
                .fontWeight(500)
                .fontSize(18)
                .margin({left:10,top:10})
              Text(`*`)
                .fontColor(Color.Red)
                .fontWeight(500)
                .fontSize(18)
                .margin({left:0,top:10})
              TextArea({ text: $$this.content,placeholder: '请输入任务内容' })
                .width(220)
                .height(220)
                .borderRadius(5)
                .margin({top:10,left:10,bottom:10,right:10})
            }
            .alignItems(VerticalAlign.Top)
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
          if (this.pageName == "添加任务"){
            if (this.title.length == 0) {
              Toast.show("标题不能为空")
              return
            }
            if (this.content.length == 0) {
              Toast.show("内容不能为空")
              return
            }

            let task:Task ={
              task_id:generateRandomId(),
              user_id:"1",
              title:this.title,
              content:this.content,
              endtime:this.endDate.getTime(),
              createTime:new Date().getTime(),
              updateTime:new Date().getTime(),
              property:this.level_index,
              category:this.tag_index,
              state:0,
              extra:""
            }
            DbUtil.insert(task)
            Toast.show("添加成功")
            router.back()
            let eventData:emitter.EventData = {
              data:{
                data:JSON.stringify(task),
                index:this.index
              }
            }
            emitter.emit('RefreshTaskList',eventData)
          }else {
            if (this.title.length == 0) {
              Toast.show("标题不能为空")
              return
            }
            if (this.content.length == 0) {
              Toast.show("内容不能为空")
              return
            }
            let task:Task ={
              task_id:this.task?.task_id ?? "",
              user_id:this.task?.task_id ?? "",
              title:this.title,
              content:this.content,
              endtime:this.endDate.getTime(),
              createTime:new Date().getTime(),
              updateTime:new Date().getTime(),
              property:this.level_index,
              category:this.tag_index,
              state:this.task?.state ?? 0,
              extra:""
            }
            DbUtil.update(task)
            Toast.show("更新成功")
            router.back()
            let eventData:emitter.EventData = {
              data:{
                data:JSON.stringify(task),
                index:this.index
              }
            }
            emitter.emit('RefreshTaskList',eventData)
          }
        })
    }
    .height('100%')
    .width('100%')
    .backgroundColor("#f3f4f5")
  }
}

function generateRandomId(): string {
  const timestamp = new Date().getTime();
  const random = Math.floor(Math.random() * 1000000);
  return `${timestamp}_${random}`;
}