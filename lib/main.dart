import 'dart:ui';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_movie/pages/home/home.dart';
import 'package:flutter_movie/pages/video/widgets/video_screen.dart';
import 'package:flutter_movie/router/global_router.dart';
import 'package:flutter_movie/router/routers.dart';
import 'package:flutter_movie/utils/adapt_ui.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    _setStatusBar();
    //初始化ui适配器
    UIAdaptor.init(MediaQueryData.fromWindow(window));

    return MaterialApp(
//      home: SplashPage(),
      home: Home(),
    );
  }

  ///设置状态栏
  _setStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF000000),
      systemNavigationBarDividerColor: null,
      statusBarColor: Colors.transparent,//装天栏背景透明
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
  }

  MyApp() {
    _initRouter();
  }
}

//初始化路由
_initRouter() {
  final router = Router();
  Routes.configureRoutes(router);
  GlobalRouter.router = router;
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text('打开播放器'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return VideoScreen(
                  url:
                      'http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4',
                );
              }));
            },
          ),
        ),
      ),
    );
  }
}
