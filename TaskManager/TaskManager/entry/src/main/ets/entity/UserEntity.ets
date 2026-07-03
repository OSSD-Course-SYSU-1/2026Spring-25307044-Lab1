export class UserEntity{
  id?:number;
  username?:string;
  password:string = '';
  phone:string = '';
  avatar?:string;
  nickname?:string;
  sex?:string;
  birthday?:string;
  address?:string;

  // 可选的校验方法
  validatePhone(): boolean {
    return /^1[3-9]\d{9}$/.test(this.phone);
  }

  validatePassword(): boolean {
    return this.password.length >= 6;
  }
}