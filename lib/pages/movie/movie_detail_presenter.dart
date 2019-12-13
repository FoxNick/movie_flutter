
import 'package:flutter_movie/net/dio_utils.dart';
import 'package:flutter_movie/net/server.dart';
import 'package:flutter_movie/pages/common/base_view.dart';
import 'package:flutter_movie/pages/common/status_widget.dart';
import 'package:flutter_movie/pages/movie/bean/movie_detail_resp.dart';

abstract class IMovieDetailView extends IView {
  void onDataSuccess(MovieDetailInfo movieDetailInfo);

}

class MovieDetailPresenter {
  IMovieDetailView _view;
  MovieDetailInfo _detailInfo;

  MovieDetailPresenter(this._view);


  requestMovieDetail(String movieId) {
    _view.showLoading();
    Map<String, String> params = Map();
    params['movieId'] = movieId;
    DioUtils.instance.request<MovieDetailInfo>(
        Method.get, Server.HOST + Urls.MOVIE_DETAIL,
        queryParameters: params,
        onSuccess: (resp) {
          _detailInfo = resp;
          _view.closeLoading();
          _view.showStatus(StatusType.NONE);
          _view.showToast("数据请求成功");
          _view.onDataSuccess(resp);

        },
        onError: (code, msg){
          _view.closeLoading();
          _view.showToast("数据请求失败");
          if (_detailInfo == null) {
            _view.showStatus(StatusType.NET_ERROR);
          }

        }
    );
  }


}