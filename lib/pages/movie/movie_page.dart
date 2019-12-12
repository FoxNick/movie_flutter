import 'package:flutter/material.dart';
import 'package:flutter_movie/pages/common/base_state.dart';
import 'package:flutter_movie/pages/movie/bean/movie_resp.dart';
import 'package:flutter_movie/pages/movie/widgets/banner_widget.dart';

import 'movie_presenter.dart';

///电影页面
class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends BaseState<MoviePage>  implements IMovieView {
  MoviePresenter _presenter;
  MovieResp _movieResp;

  @override
  void initState() {
    super.initState();
    _presenter = MoviePresenter(this);
    _presenter.requestMovieData();
  }

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }

  @override
  Widget buildUI(BuildContext context) {
    return Container(
      child: BannerWidget(banners: _movieResp?.banners,),
    );
  }

  @override
  void onDataSuccess(MovieResp movieResp) {
    setState(() {
      _movieResp = movieResp;
    });
  }

  @override
  bool get wantKeepAlive => true;



}

