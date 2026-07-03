import { relationalStore, ValuesBucket } from '@kit.ArkData';
import { AsyncCallback, BusinessError } from '@kit.BasicServicesKit';
import Task from '../entity/Task';


class DbUtil {
  private STORE_CONFIG: relationalStore.StoreConfig = {
    name: "RdbTest.db",
    securityLevel: relationalStore.SecurityLevel.S1
  };

  private rdbStore?: relationalStore.RdbStore
  private TABLE_NAME = 'EMPLOYEE'
  private SQL_CREATE = `create table if not exists ${this.TABLE_NAME} (
        id integer primary key autoincrement,
        task_id text,
        user_id text,
        title text,
        content text,
        endtime integer,
        createTime integer,
        updateTime integer,
        property integer,
        category integer,
        state integer,
        extra text
      )`

  init(context: Context) {
    relationalStore.getRdbStore(context, this.STORE_CONFIG,
      (err: BusinessError, rdbStore: relationalStore.RdbStore) => {
        this.rdbStore = rdbStore
        rdbStore.executeSql(this.SQL_CREATE,
          (err) => {
            console.log(`zhu 创建数据库 err=${err}`)

          })
      })
  }

  // 新增单条
  async insert(value: Task) {
    const rowId = await this.rdbStore?.insert(this.TABLE_NAME, value)
    console.log('zhu 增 rowId=' + rowId)
    return (rowId && rowId > -1) ? Promise.resolve(rowId) : Promise.reject('insert error')
  }

  // 批量新增
  async batchInsert(values: Task[]) {
    const rowId = await this.rdbStore?.batchInsert(this.TABLE_NAME, values)
    console.log('zhu 批量增 rowId=' + rowId)
    return rowId ? Promise.resolve(rowId) : Promise.reject('batchInsert error')
  }

  // 更新
  async update(item: Task) {
    if (!item.task_id) {
      return Promise.reject('id error')
    }
    const predicates = new relationalStore.RdbPredicates(this.TABLE_NAME)
    predicates.equalTo('task_id', item.task_id)
    const rowCount = await this.rdbStore?.update(item, predicates)
    console.log('zhu 改 rowCount=' + rowCount)
    return rowCount ? Promise.resolve(rowCount) : Promise.reject('update error')
  }

  // 删除
  async delete(task_id: string) {
    const predicates = new relationalStore.RdbPredicates(this.TABLE_NAME)
    predicates.equalTo('task_id', task_id)
    const rowCount = await this.rdbStore?.delete(predicates)
    console.log('zhu 删 rowCount=' + rowCount)
    return rowCount ? Promise.resolve(rowCount) : Promise.reject('delete error')
  }

  // 批量删除
  async batchDelete(task_ids: string[]) {
    const predicates = new relationalStore.RdbPredicates(this.TABLE_NAME)
    predicates.in('task_id', task_ids)
    const rowCount = await this.rdbStore?.delete(predicates)
    console.log('zhu 批量删 rowCount=' + rowCount)
    return rowCount ? Promise.resolve(rowCount) : Promise.reject('delete error')
  }

  // 查询
  async query(task_id: string) {
    const predicates = new relationalStore.RdbPredicates(this.TABLE_NAME)
    // 添加日期倒序排列
    predicates.orderByDesc('date_added')
    // 如果有 id
    if (task_id) {
      predicates.equalTo('task_id', task_id)
    }
    const resultSet = await this.rdbStore?.query(predicates)
    const list: Task[] = []
    while (resultSet && resultSet.goToNextRow()) {
      const data: Task = {
        task_id: resultSet.getString(resultSet.getColumnIndex('task_id')),
        user_id: resultSet.getString(resultSet.getColumnIndex('user_id')),
        title: resultSet.getString(resultSet.getColumnIndex('title')),
        content: resultSet.getString(resultSet.getColumnIndex('content')),
        endtime: resultSet.getLong(resultSet.getColumnIndex('endtime')),
        createTime: resultSet.getLong(resultSet.getColumnIndex('createTime')),
        updateTime: resultSet.getLong(resultSet.getColumnIndex('updateTime')),
        property: resultSet.getLong(resultSet.getColumnIndex('property')),
        category: resultSet.getLong(resultSet.getColumnIndex('category')),
        state: resultSet.getLong(resultSet.getColumnIndex('state')),
        extra: resultSet.getString(resultSet.getColumnIndex('extra'))
      }
      // 追加到数组中
      list.push(data)
    }
    console.log('zhu 查询单个id list.length=' + list.length)
    // 释放资源
    resultSet?.close()
    return list
  }

  // 查询
  async queryAll() {
    const predicates = new relationalStore.RdbPredicates(this.TABLE_NAME)
    // 添加日期倒序排列
    //predicates.orderByDesc('date_added')
    // 如果有 id
    // if (id_) {
    //   predicates.equalTo('id_', id_)
    // }
    const resultSet = await this.rdbStore?.query(predicates)
    const list: Task[] = []
    while (resultSet && resultSet.goToNextRow()) {
      // 获取数据
      const data: Task = {
        task_id: resultSet.getString(resultSet.getColumnIndex('task_id')),
        user_id: resultSet.getString(resultSet.getColumnIndex('user_id')),
        title: resultSet.getString(resultSet.getColumnIndex('title')),
        content: resultSet.getString(resultSet.getColumnIndex('content')),
        endtime: resultSet.getLong(resultSet.getColumnIndex('endtime')),
        createTime: resultSet.getLong(resultSet.getColumnIndex('createTime')),
        updateTime: resultSet.getLong(resultSet.getColumnIndex('updateTime')),
        property: resultSet.getLong(resultSet.getColumnIndex('property')),
        category: resultSet.getLong(resultSet.getColumnIndex('category')),
        state: resultSet.getLong(resultSet.getColumnIndex('state')),
        extra: resultSet.getString(resultSet.getColumnIndex('extra'))
      }
      // 追加到数组中
      list.push(data)
    }
    console.log('zhu 查询所有 list.length=' + list.length)
    // 释放资源
    resultSet?.close()
    return list
  }
}

let util2 = new DbUtil()

export default util2 as DbUtil