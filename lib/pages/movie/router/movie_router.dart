import 'package:fluro/fluro.dart';
import 'package:fluro/src/router.dart';
import 'package:flutter_movie/pages/movie/movie_detail_page.dart';
import 'package:flutter_movie/router/router_init.dart';

class MovieRouter implements IRouterProvider {
  static String movieDetail = '/movieDetail';
  @override
  void initRouter(Router router) {
    router.define(movieDetail, handler: Handler(handlerFunc: (_, params) {
      String movieId = params['movieId']?.first;
      return MovieDetailPage(movieId: movieId,);
    }));
  }

}