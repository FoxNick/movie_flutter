
import 'package:flutter_movie/pages/movie/bean/movie_resp.dart';
import 'package:flutter_movie/pages/splash/bean/img_resp.dart';

class EntityFactory {
  ///将json解析为OBJ
  static T generateOBJ<T>(json) {
    if (T.toString() == "ImgResp") {
      return ImgResp.fromJson(json) as T;
    } else if (T.toString() == "MovieResp") {
      return MovieResp.fromJson(json) as T;
    }
    return null;
  }
}
