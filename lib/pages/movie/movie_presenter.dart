
import 'package:flutter_movie/net/dio_utils.dart';
import 'package:flutter_movie/net/server.dart';
import 'package:flutter_movie/pages/common/base_view.dart';
import 'package:flutter_movie/pages/common/status_widget.dart';
import 'package:flutter_movie/pages/splash/bean/img_resp.dart';

import 'bean/movie_resp.dart';

abstract class IMovieView extends IView {
  void onDataSuccess(MovieResp movieResp);
}

class MoviePresenter {
  IMovieView _view;
  MovieResp _movieResp;

  MoviePresenter(this._view);

  requestMovieData() {
    _view.showLoading();
    DioUtils.instance.request<MovieResp>(
        Method.get, Server.HOST + Urls.MOVIE_HOME,
        onSuccess: (resp) {
          _view.closeLoading();
          _view.showStatus(StatusType.NONE);
          _view.showToast("数据请求成功");
          _view.onDataSuccess(resp);

        },
      onError: (code, msg){
        _view.closeLoading();
        _view.showToast("数据请求失败");
        if (_movieResp == null) {
          _view.showStatus(StatusType.NET_ERROR);
        }

      }
    );
  }

}