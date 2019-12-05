
import 'package:common_utils/common_utils.dart';
import 'package:flustars/flustars.dart';

class Log{
  
  static bool debuggable = true;
  static const String DEFAULT_TAG = 'movie_log';
  
  static d(String msg, {tag: DEFAULT_TAG}) {
    if (debuggable){
      LogUtil.v(msg, tag: tag);
    }
  }
  
  static w(String msg, {tag: DEFAULT_TAG}) {
    if (debuggable){
      LogUtil.v(msg, tag: tag);
    }
  }
  
  static i(String msg, {tag: DEFAULT_TAG}) {
    if (debuggable){
      LogUtil.v(msg, tag: tag);
    }
  }
  
  static e(String msg, {tag: DEFAULT_TAG}) {
    if (debuggable){
      LogUtil.e(msg, tag: tag);
    }
  }
  
  static json(String msg, {tag: DEFAULT_TAG}) {
    if (debuggable){
      LogUtil.v(msg, tag: tag);
    }
  }
}