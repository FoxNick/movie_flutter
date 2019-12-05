import 'dart:convert';
import 'dart:core' as prefix0;
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter_movie/eventbus/bean/logout_event.dart';
import 'package:flutter_movie/eventbus/easy_event_bus.dart';
import 'package:flutter_movie/net/codes.dart';
import 'package:flutter_movie/net/entity_factory.dart';
import 'package:flutter_movie/utils/log_utils.dart';
import 'package:quiver/strings.dart';

import 'base_entity.dart';
import 'error_handle.dart';
import 'intercept.dart';

/// @weilu https://github.com/simplezhli
class DioUtils {
  static final DioUtils _singleton = DioUtils._internal();

  static DioUtils get instance => DioUtils();

  factory DioUtils() {
    return _singleton;
  }

  static Dio _dio;

  Dio getDio() {
    return _dio;
  }

  DioUtils._internal() {
    var options = BaseOptions(
      connectTimeout: 8000,
      receiveTimeout: 15000,
      responseType: ResponseType.plain,
      validateStatus: (status) {
        // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
        return true;
      },
//      baseUrl: "https://api.github.com/",//不使用base_url方式，不灵活
//      contentType: ContentType('application', 'x-www-form-urlencoded', charset: 'utf-8'),
    );
    _dio = Dio(options);

    /// 统一添加身份验证请求头
    _dio.interceptors.add(AuthInterceptor());

    /// 刷新Token
    _dio.interceptors.add(TokenInterceptor());

    /// 打印Log
    _dio.interceptors.add(LoggingInterceptor());

    /// 适配数据
    _dio.interceptors.add(AdapterInterceptor());

    ///处理代理
    _dio.interceptors.add(ProxyInterceptor(_dio));

  }

  // 数据返回格式统一，统一处理异常
  Future<BaseEntity<T>> _request<T>(String method, String url,
      {Map<String, dynamic> data,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      Options options,
      bool isFromLog = false}) async {
    if (queryParameters == null) {
      queryParameters = Map<String, String>();
    }

    var response = await _dio.request(url,
        data: data,
        queryParameters: queryParameters,
        options: _checkOptions(method, options),
        cancelToken: cancelToken);
    int _code;
    String _msg;
    T _data;
    BaseEntity<T> entity;

    if (response == null) {
      entity = BaseEntity(ExceptionHandle.unknown_error, "网络请求返回对象为空", null);
      return entity;
    }

    //判断返回的状态码
    if (response.statusCode == ExceptionHandle.success) {////网络请求成功
      try {
        Map<String, dynamic> _map = json.decode((response.data ?? '').toString());
        _code = _map["code"];
        _msg = _map["message"];
        if (_map.containsKey("res") && _map["res"] != null) {
          if (T.toString() == "String") {
            _data = _map["res"].toString() as T;
          } else {
            _data = EntityFactory.generateOBJ(_map["res"]);
          }
        }
        entity = BaseEntity(_code, _msg, _data);
      } catch (e, trace) {
        print("解析网络返回的数据异常：" + e.toString());
        print('堆栈信息如下：' + "\n" + trace.toString());
        entity = BaseEntity(ExceptionHandle.parse_error, "数据解析错误", _data);
      }
      return entity;

    } else {//网络请求返回的code不是200
      entity = BaseEntity(response.statusCode, "网络请求错误", _data);
    }
    return entity;
  }


  Options _checkOptions(method, options) {
    if (options == null) {
      options = new Options();
    }
    options.method = method;
    return options;
  }

  Future request<T>(Method method, String url,
      {Function(T t) onSuccess,
      Function(int code, String mag) onError,
      Map<String, dynamic> params,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      Options options,
      bool isFromLog = false}) async {
    String m = _getRequestMethod(method);
    return await _request<T>(m, url,
            data: params,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            isFromLog: isFromLog)
        .then((BaseEntity<T> result) {
          //处理业务code
      if (result.code == Codes.SUCCESS) {
        if (onSuccess != null) {
          onSuccess(result.data);
        }
      } else if (result.code == Codes.LOGOUT) {
        _handleLoginOut();
      } else {
      _onError(result.code, result.message, onError);
      }
    }, onError: (e, _) {
      _cancelLogPrint(e, url);
      Error error = ExceptionHandle.handleException(e);
      _onError(error.code, error.msg, onError);
    });
  }


  _cancelLogPrint(dynamic e, String url) {
    if (e is DioError && CancelToken.isCancel(e)) {
      Log.i("取消请求接口： $url");
    }
  }


  _onError(int code, String msg, Function(int code, String mag) onError) {
    Log.e("接口请求异常： code: $code, mag: $msg");
    if (onError != null) {
      onError(code, msg);
    }
  }

  ///处理退出登录
  _handleLoginOut() {
    EasyEventBus.eventBus?.fire(LogoutEvent(true));
  }

  String _getRequestMethod(Method method) {
    String m;
    switch (method) {
      case Method.get:
        m = "GET";
        break;
      case Method.post:
        m = "POST";
        break;
      case Method.put:
        m = "PUT";
        break;
      case Method.patch:
        m = "PATCH";
        break;
      case Method.delete:
        m = "DELETE";
        break;
    }
    return m;
  }
}

enum Method {
  get,
  post,
  put,
  patch,
  delete,
}
