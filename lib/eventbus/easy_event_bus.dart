import 'package:event_bus/event_bus.dart';

///
/// 这里有时间可以封装，方便以后替换库
///
class EasyEventBus{
  static EventBus eventBus = EventBus();//事件总线，不使用单例的方式是因为可能提供分组
}