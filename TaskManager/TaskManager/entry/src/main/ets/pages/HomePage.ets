import { router } from "@kit.ArkUI"
import Task from "../entity/Task"
import DbUtil from "../util/DbUtil"
import { emitter } from "@kit.BasicServicesKit"


@Entry
@Component
export default struct HomePage{

  @State type:number = 0
  @State taskList:Task[] = []

  aboutToAppear(): void {
    this.loadAllTask(0)
    emitter.on("RefreshTaskList",(eventData)=>{
      let data = eventData.data
      if (data) {
        let task:Task = JSON.parse(data["data"])
        let index:number = data["index"]
        if (index>-1 && index < this.taskList.length) {
          this.taskList.splice(index,1,task)
        }else {
          this.taskList.push(task)
        }
      }
    })
  }

  build() {
    Column(){
      Row(){
        Text("添加")
          .fontColor("#00aaea")
          .fontWeight(700).fontSize(14).margin({ left:0 })
          .onClick(()=>{
            this.loadAllTask(0)
            router.pushUrl({url:'pages/AddTaskPage'})
          })
        Blank()
        Text("任务").fontWeight(500).fontSize(18).margin({ bottom:10 })
        Blank()
        Text("查看")
          .fontColor("#00aaea")
          .fontWeight(700).fontSize(14).margin({ left:0 })
          .bindMenu(this.MyMenu)

      }
      .width("100%")
      .padding({ top:10,bottom:5,right:15,left:15 })
      .backgroundColor("#fff")
      .justifyContent(FlexAlign.Center)
      Divider().color("#f2f3f5").strokeWidth(1)

      if (this.taskList.length == 0){
        Text("暂无任务").fontColor("#00aaea").fontWeight(700).fontSize(22).margin({ top:100 })
      }else {
        List(){
          ForEach(this.taskList,(item:Task,index:number)=>{
            ListItem(){
              TaskListItem({
                task:item,
                callBack:(type)=>{
                  this.clickItemButton(type,item,index)
                }
              })
            }
          })
        }
        .margin({
          bottom:50
        })
      }
    }
  }

  @Builder
  MyMenu(){
    Menu() {
      MenuItem({
        content: "查看全部",
      })
        .onClick(()=>{
          this.loadAllTask(0)
        })
      MenuItem({
        content: "状态",
        builder: ():void=>this.SubMenu0()
      })
      MenuItem({
        content: "时间",
        builder: ():void=>this.SubMenu1()
      })
      MenuItem({
        content: "优先级",
        builder: ():void=>this.SubMenu2()
      })
      MenuItem({
        content: "标签",
        builder: ():void=>this.SubMenu3()
      })
    }
  }

  @Builder
  SubMenu0() {
    Menu() {
      MenuItem({ content: "进行中" })
        .onClick(()=>{
          this.loadAllTask(1)
        })
      MenuItem({ content: "已完成" })
        .onClick(()=>{
          this.loadAllTask(2)
        })
      MenuItem({ content: "未完成" })
        .onClick(()=>{
          this.loadAllTask(3)
        })
    }
  }

  @Builder
  SubMenu1() {
    Menu() {
      MenuItem({ content: "今日任务" })
        .onClick(()=>{
          this.loadAllTask(4)
        })
      MenuItem({ content: "本周任务" })
        .onClick(()=>{
          this.loadAllTask(5)
        })
      MenuItem({ content: "全部任务" })
        .onClick(()=>{
          this.loadAllTask(6)
        })
    }
  }

  @Builder
  SubMenu2() {
    Menu() {
      MenuItem({ content: "高" })
        .onClick(()=>{
          this.loadAllTask(7)
        })
      MenuItem({ content: "中" })
        .onClick(()=>{
          this.loadAllTask(8)
        })
      MenuItem({ content: "低" })
        .onClick(()=>{
          this.loadAllTask(9)
        })
    }
  }


  @Builder
  SubMenu3() {
    Menu() {
      MenuItem({ content: "工作" })
        .onClick(()=>{
          this.loadAllTask(10)
        })
      MenuItem({ content: "学习" })
        .onClick(()=>{
          this.loadAllTask(11)
        })
      MenuItem({ content: "生活" })
        .onClick(()=>{
          this.loadAllTask(12)
        })
    }
  }

  /////////////////////////////////////////////

  loadAllTask(type:number){
    let l:Task[] = []
    DbUtil.queryAll().then((list)=>{
      l.push(...list)
      this.taskList.splice(0)
      switch (type) {
        case 0:
          this.taskList.push(...l)
          break;

      //---------------
        case 1:
          l.forEach((item)=>{
            if (item.state == 0) {
              this.taskList.push(item)
            }
          })
          break;
        case 2:
          l.forEach((item)=>{
            if (item.state == 1) {
              this.taskList.push(item)
            }
          })
          break;
        case 3:
          l.forEach((item)=>{
            if (item.state == 2) {
              this.taskList.push(item)
            }
          })
          break;
          //---------------
        case 4:
          l.forEach((item)=>{
            if (isTimestampToday(item.endtime)) {
              this.taskList.push(item)
            }
          })
          break;
        case 5:
          l.forEach((item)=>{
            if (isTimestampWithinWeek(item.endtime)) {
              this.taskList.push(item)
            }
          })
          break;
        case 6:
          this.taskList.push(...l)
          break;
      //---------------
        case 7:
          l.forEach((item)=>{
            if (item.property == 0) {
              this.taskList.push(item)
            }
          })
          break;
        case 8:
          l.forEach((item)=>{
            if (item.property == 1) {
              this.taskList.push(item)
            }
          })
          break;
        case 9:
          l.forEach((item)=>{
            if (item.property == 2) {
              this.taskList.push(item)
            }
          })
          break;
      //---------------

        case 10:
          l.forEach((item)=>{
            if (item.category == 0) {
              this.taskList.push(item)
            }
          })
          break;
        case 11:
          l.forEach((item)=>{
            if (item.category == 1) {
              this.taskList.push(item)
            }
          })
          break;
        case 12:
          l.forEach((item)=>{
            if (item.category == 2) {
              this.taskList.push(item)
            }
          })
          break;
        default:
          break;
      }
    })
  }

  clickItemButton(type:number,task:Task,index:number){
    switch (type) {
      case 1:
        DbUtil.delete(task.task_id)
        this.taskList.splice(index,1)
        break;
      case 2:
        router.pushUrl({
          url:'pages/AddTaskPage',
          params:{
            data:JSON.stringify(task),
            index:index
          }
        })
        break;
      case 3:
        task.state = 1
        DbUtil.update(task)
        this.taskList.splice(index,1,task)
        break;
      case 4:
        task.state = 2
        DbUtil.update(task)
        this.taskList.splice(index,1,task)
        break;
      default:
        break;
    }
  }
}




@Component
export  struct TaskListItem{
  @Prop task:Task
  callBack?:(type:number)=>void
  build() {
    Column(){
      Row(){
        Image(this.task.state == 0?$r('app.media.jinxingzhong'):this.task.state == 1?$r('app.media.wancheng'):$r('app.media.weiwancheng'))
          .width(70)
          .height(70)
          .margin(10)
        Column(){
          Text(this.task.title)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .maxLines(1)
            .fontWeight(500)
            .fontSize(18)
            .margin({ left:10,top:10,bottom:5 ,right:100})
          Text(this.task.content.trim())
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .fontColor("#666666")
            .fontWeight(500)
            .fontSize(14)
            // .backgroundColor(Color.Yellow)
            .margin({ left:10,top:5,bottom:5,right:100 })
          Text("截止日期："+(new Date(this.task.endtime).toLocaleString()))
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .fontColor("#666666")
            .fontWeight(500)
            .fontSize(14)
            // .backgroundColor(Color.Blue)
            .margin({ left:10,top:5,bottom:5 })
          Row(){
            Text("优先级："+(this.task.property == 0?"高":this.task.property == 1?"中":"低"))
              .fontColor("#f5a623")
              .fontWeight(500)
              .fontSize(14)
              .margin({ left:10,top:5,bottom:5 })
            Text("类型："+(this.task.category == 0?"工作":this.task.category == 1?"学习":"生活"))
              .fontColor("#bd10e0")
              .fontWeight(500)
              .fontSize(14)
              .margin({ left:10,top:5,bottom:5 })
            Text("状态："+ (this.task.state == 0?"进行中":this.task.state == 1?"已完成":"未完成"))
              .fontColor(this.task.state == 0?"#00aaea":this.task.state == 1?"#7ed321":"#ff0000")
              .fontWeight(500)
              .fontSize(14)
              .margin({ left:10,top:5,bottom:5 })
          }
          Row(){
            Button('删除', { type: ButtonType.Normal })
              .borderRadius(5)
              .width(60)
              .height(30)
              .backgroundColor('#00aaea')
              .margin({  right:5,bottom: 10 })
              .onClick(()=>{
                if (this.callBack) {
                  this.callBack(1)
                }
              })
            if (this.task.state == 0){
              Button('编辑', { type: ButtonType.Normal })
                .borderRadius(5)
                .width(60)
                .height(30)
                .backgroundColor('#00aaea')
                .margin({ right:5,bottom: 10 })
                .onClick(()=>{
                  if (this.callBack) {
                    this.callBack(2)
                  }
                })
              Button('完成', { type: ButtonType.Normal })
                .borderRadius(5)
                .width(60)
                .height(30)
                .backgroundColor('#7ed321')
                .margin({  right:5,bottom: 10 })
                .onClick(()=>{
                  if (this.callBack) {
                    this.callBack(3)
                  }
                })
              Button('延期', { type: ButtonType.Normal })
                .borderRadius(5)
                .width(60)
                .height(30)
                .backgroundColor('#ff0000')
                .margin({ bottom: 10 })
                .onClick(()=>{
                  if (this.callBack) {
                    this.callBack(4)
                  }
                })
            }
          }
        }
        .alignItems(HorizontalAlign.Start)
      }
      .width("100%")
      Divider().color("#f2f3f5").strokeWidth(1)
    }
    .backgroundColor(Color.White)
  }
}

function isTimestampToday(timestamp: number): boolean {
  // 获取当前日期和传入时间戳对应的日期
  const today = new Date();
  const dateToCheck = new Date(timestamp);

  // 比较年、月、日是否相同
  return (
    dateToCheck.getFullYear() === today.getFullYear() &&
      dateToCheck.getMonth() === today.getMonth() &&
      dateToCheck.getDate() === today.getDate()
  );
}

function isTimestampWithinWeek(timestamp: number): boolean {
  const now = Date.now();
  const oneWeekInMs = 7 * 24 * 60 * 60 * 1000; // 7天的毫秒数

  // 检查时间戳是否在现在到7天前之间
  return timestamp >= now - oneWeekInMs && timestamp <= now;
}

//#00aaea
//#ff0000
//#7ed321