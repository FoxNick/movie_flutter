class ArrayUtil {
  ///判断数组是否为空
  static bool isEmpty(List list) {
    return (list?.length ?? 0) == 0;
  }
}