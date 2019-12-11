import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter_movie/net/dio_utils.dart';
import 'package:flutter_movie/utils/conf.dart';
import 'package:flutter_movie/utils/constant.dart';
import 'package:flutter_movie/utils/log_utils.dart';
import 'package:sprintf/sprintf.dart';
import 'package:quiver/strings.dart';

import 'error_handle.dart';

class AuthInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options) {
    //添加身份信息
    return super.onRequest(options);
  }
}

///处理token相关
class TokenInterceptor extends Interceptor {
  @override
  onResponse(Response response) async {
    return super.onResponse(response);
  }
}

///请求日志
class LoggingInterceptor extends Interceptor {
  DateTime startTime;
  DateTime endTime;

  @override
  onRequest(RequestOptions options) {
    startTime = DateTime.now();
    Log.d("----------Start----------");
    if (options.queryParameters.isEmpty) {
      Log.i("RequestUrl: " + options.baseUrl + options.path);
    } else {
      Log.i("RequestUrl: " +
          options.baseUrl +
          options.path +
          "?" +
          Transformer.urlEncodeMap(options.queryParameters));
    }
    Log.d("RequestMethod: " + options.method);
    Log.d("RequestHeaders:" + options.headers.toString());
    Log.d("RequestContentType: ${options.contentType}");
    Log.d("RequestData: ${options.data.toString()}");
    return super.onRequest(options);
  }

  @override
  onResponse(Response response) {
    endTime = DateTime.now();
    int duration = endTime
        .difference(startTime)
        .inMilliseconds;
    if (response.statusCode == ExceptionHandle.success) {
      Log.d("ResponseCode: ${response.statusCode}");
    } else {
      Log.e("ResponseCode: ${response.statusCode}");
    }
    // 输出结果
    Log.json(response.data.toString());
    Log.d("----------End: $duration 毫秒----------");
    return super.onResponse(response);
  }

  @override
  onError(DioError err) {
    Log.d("----------Error-----------");
    return super.onError(err);
  }
}

///数据转换
class AdapterInterceptor extends Interceptor {
  static const String MSG = "msg";
  static const String SLASH = "\"";
  static const String MESSAGE = "message";

  static const String DEFAULT = "\"返回数据为空\"";
  static const String NOT_FOUND = "未找到查询信息";

  static const String FAILURE_FORMAT = "{\"code\":%d,\"message\":\"%s\"}";
  static const String SUCCESS_FORMAT =
      "{\"code\":1000,\"res\":%s,\"message\":\"%s\"}";

  @override
  onResponse(Response response) {
    Response r = adapterData(response);
    return super.onResponse(r);
  }

  @override
  onError(DioError err) {
    if (err.response != null) {
      adapterData(err.response);
    }
    return super.onError(err);
  }

  ///将返回的数据适配为//构造为{"code":10000,"message":"","res":""} 格式的数据
  Response adapterData(Response response) {
    String result;
    String content = response.data == null ? "" : response.data.toString();

    //网络请求成功
    if (response.statusCode == ExceptionHandle.success ||
        response.statusCode == ExceptionHandle.success_not_content) {
      if (content == null || content.isEmpty) {
        result = sprintf(SUCCESS_FORMAT, [null, "返回数据为空"]);
      } else {
        result = content; //直接使用返回的数据结构，因为返回的数据满足格式
      }
    } else {
      //构造为符合要求的数据结构
      result = sprintf(FAILURE_FORMAT,
          [response.statusCode.toString(), _getErrorMsg(response.statusCode)]);
    }
    response.data = result;
    return response;
  }

  ///
  /// 错误提示信息
  String _getErrorMsg(int code) {
    String msg = "";
    switch (code) {
      case ExceptionHandle.unauthorized:
        {
          msg = "未授权";
        }
        break;
      case ExceptionHandle.forbidden:
        {
          msg = "访问被禁止";
        }
        break;
      default:
        {
          msg = "Connection error";
        }
        break;
    }
    return msg;
  }
}

///处理代理
class ProxyInterceptor extends Interceptor {

  Dio _dio;

  ProxyInterceptor(this._dio);

  @override
  onRequest(RequestOptions options) {
//    if (Conf.isDebug() && _dio != null) {
//      String ipPort = SpUtil.getString(Constant.proxy_ip_port);
//      if (isNotEmpty(ipPort)) {
//        (_dio.httpClientAdapter as DefaultHttpClientAdapter)
//            .onHttpClientCreate =
//            (client) {
//          client.findProxy = (uri) {
//            // 用1个开关设置是否开启代理
////            String proxy = 'PROXY ' + ipPort;
////          String proxy = 'PROXY ' + "192.168.253.3:8888";//测试
//            return proxy;
//          };
//        };
//      }
//    }

    (_dio.httpClientAdapter as DefaultHttpClientAdapter)
        .onHttpClientCreate =
        (client) {
      client.findProxy = (uri) {
        // 用1个开关设置是否开启代理
          String proxy = 'PROXY ' + "172.16.128.243:8888";//测试
        return proxy;
      };
    };

    super.onRequest(options);
  }
}