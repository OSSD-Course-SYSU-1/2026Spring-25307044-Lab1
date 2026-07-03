

import { ValuesBucket } from "@kit.ArkData"


export default interface Task extends ValuesBucket {
  //任务id
  task_id: string
  //用户id
  user_id: string
  //标题
  title: string
  //内容
  content: string
  //截止时间
  endtime: number
  //创建时间
  createTime: number
  //修改时间
  updateTime: number
  //优先级
  property: number
  //分类
  category: number
  //状态
  state: number
  //扩展字段
  extra:string
}