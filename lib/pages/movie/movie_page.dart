import 'package:flutter/material.dart';
import 'package:flutter_movie/pages/common/base_state.dart';
import 'package:flutter_movie/pages/movie/bean/movie_resp.dart';
import 'package:flutter_movie/pages/movie/widgets/banner_widget.dart';
import 'package:flutter_movie/pages/movie/widgets/movies_module_widget.dart';

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

    int bannerSize =  (_movieResp?.banners?.length ?? 0) > 0 ? 1 : 0;
    int movieModuleSize = _movieResp?.movies?.length ?? 0;
    return Container(
      child: ListView.builder(itemBuilder: (context, index) {
        Movies movies;
        if (index == 0) {
          if (bannerSize > 0) {
            return BannerWidget(banners: _movieResp?.banners);
          } else {
            movies = _movieResp.movies[0];
          }
        } else {
          if (bannerSize > 0) {
            movies = _movieResp.movies[index - 1];
          } else {
            movies = _movieResp.movies[index];
          }
        }
       return MoviesModuleWidget(movies: movies,);

      },
        itemCount: bannerSize + movieModuleSize,
      ),
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

