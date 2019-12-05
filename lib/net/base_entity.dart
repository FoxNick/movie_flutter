
///接口请求返回的实体
class BaseEntity<T>{

  int code;//正常解析，那么这里的code就是业务返回的code；否则，这里的code就是ExceptionHandle里面定义的code
  String message;//提示信息
  T data;//数据
  
  BaseEntity(this.code, this.message, this.data);
}