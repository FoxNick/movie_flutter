

class Conf{
  static const bool _inProduction = const bool.fromEnvironment("dart.vm.product");

  ///确定是否是调试模式
  static bool isDebug() {
    return _inProduction != true;
  }
}
