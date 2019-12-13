import 'package:flutter/material.dart';
import 'package:flutter_movie/pages/common/base_state.dart';
import 'package:flutter_movie/pages/common/status_widget.dart';
import 'package:flutter_movie/pages/movie/bean/movie_detail_resp.dart';
import 'package:flutter_movie/res/colors.dart';
import 'package:flutter_movie/res/dimens.dart';
import 'package:flutter_movie/utils/adapt_ui.dart';
import 'package:quiver/strings.dart';

import 'movie_detail_presenter.dart';

class MovieDetailPage extends StatefulWidget {
  final String movieId;

  const MovieDetailPage({Key key, this.movieId}) : super(key: key);


  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends BaseState<MovieDetailPage> implements IMovieDetailView {

  MovieDetailPresenter _presenter;
  MovieDetailInfo _detailInfo;

  @override
  void initState() {
    super.initState();
    _presenter = MovieDetailPresenter(this);
    _presenter.requestMovieDetail(widget.movieId);
  }

  @override
  Widget buildUI(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: UIAdaptor.w(20), right: UIAdaptor.w(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _info(),
        ],
      ),
    );
  }

  @override
  void onDataSuccess(MovieDetailInfo movieDetailInfo) {
    if (movieDetailInfo == null && _detailInfo == null) {
      showStatus(StatusType.EMPTY);
      return;
    }
    if (movieDetailInfo != null) {
      setState(() {
        _detailInfo = movieDetailInfo;
      });
    }
  }

  Widget _info() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(_detailInfo?.name ?? '', style: TextStyle(color: Colours.text_normal, fontSize: FontSize.title),),//电影名称
            Expanded(flex: 1,child: SizedBox(),),
            Text(_detailInfo?.doubanRank?.toString() ?? '', style: TextStyle(color: Colours.color_FF9C29, fontSize: FontSize.normal),)//电影评分
          ],
        ),
        _infoItemWidget('导演：', (_detailInfo?.directors?.length ?? 0) > 0 ? _detailInfo.directors[0] : ''),
        _infoItemWidget('上映时间: ', _detailInfo?.year?.toString() ?? ''),
        _infoItemWidget('语言：', _detailInfo?.language ?? ''),
        _infoItemWidget('国家/地区：', (_detailInfo?.locations?.length ?? 0) > 0 ? _detailInfo.locations[0] : ''),
        _infoItemWidget('简介：', _detailInfo?.intro ?? '')
      ],
    );
  }

  Widget _infoItemWidget(String key, String value) {
    if (isEmpty(value)) {
      return SizedBox();
    }
    return Padding(
      padding: EdgeInsets.only(top: UIAdaptor.h(10)),
      child: Text((key ?? '') + value, style: TextStyle(color: Colours.text_gray_6, fontSize: FontSize.normal),),
    );
  }
}
