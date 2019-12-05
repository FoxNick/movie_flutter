
class EntityFactory {
  ///将json解析为OBJ
  static T generateOBJ<T>(json) {
    if (T.toString() == "SignInModelRes") {
//      return SignInModelRes.fromJson(json) as T;
    }
    return null;
  }
}
