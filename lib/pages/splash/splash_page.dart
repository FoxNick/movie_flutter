import 'package:flutter/material.dart';
import 'package:flutter_movie/pages/common/base_state.dart';
import 'package:flutter_movie/pages/splash/splash_presenter.dart';
import 'package:flutter_movie/res/colors.dart';
import 'package:flutter_movie/utils/image_utils.dart';
import 'package:quiver/strings.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends BaseState<SplashPage> implements ISplashView {
  SplashPagePresenter _presenter;
  String _imgUrl;

  @override
  void initState() {
    super.initState();
    _presenter = new SplashPagePresenter(this);
    _presenter.requestImg();
  }

  @override
  void onUrl(String imgUrl) {
    // TODO: implement onUrl
  }

  @override
  Widget buildUI(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colours.white,
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: isNotEmpty(_imgUrl)
              ? ImageUtil.loadNetworkImage(_imgUrl, fit: BoxFit.contain)
              : SizedBox(),
        ),
      ),
    );
  }


}
