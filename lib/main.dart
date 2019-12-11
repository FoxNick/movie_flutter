import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/pages/splash/splash_page.dart';
import 'package:flutter_movie/pages/video/widgets/video_screen.dart';
import 'package:flutter_movie/routers/application.dart';
import 'package:flutter_movie/routers/routers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashPage(),
    );
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
