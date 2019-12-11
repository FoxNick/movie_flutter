import 'package:flutter_movie/net/dio_utils.dart';
import 'package:flutter_movie/net/net.dart';
import 'package:flutter_movie/net/server.dart';
import 'package:flutter_movie/pages/splash/bean/img_resp.dart';

abstract class ISplashView {
  void onUrl(String imgUrl);
}

abstract class ISplashModel {
  void requestImg();
}

///
/// DioUtils网络请求就相当于model了
///
class SplashPagePresenter {
  ISplashView _view;

  SplashPagePresenter(this._view);

  ///请求显示的图片
  requestImg() {
    DioUtils.instance.request<ImgResp>(
        Method.get, Server.HOST + Urls.SPLASH_SHOW_IMG,
        onSuccess: (resp) {
          _view.onUrl(resp?.url);
        });
  }
}
