import 'package:flutter/material.dart';
import 'package:flutter_movie/pages/movie/movie_page.dart';
import 'package:flutter_movie/res/colors.dart';
import 'package:flutter_movie/utils/image_utils.dart';

import '../demo_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<TabItem> _tabDatas;
  int _selIndex = 0;
  List<Widget> _tabPages = List()..add(CategoryTabPage())..add(DemoPage());

  ///构造tab的数据
  _initTabData() {
    _tabDatas = List()
      ..add(TabItem(ImageUtil.loadAssetImage("icon_sel_analysis"),
          ImageUtil.loadAssetImage("icon_unsel_analysis"), "电影"))
      ..add(TabItem(ImageUtil.loadAssetImage("icon_sel_me"),
          ImageUtil.loadAssetImage("icon_unsel_me"), "我的"));
  }

  @override
  void initState() {
    super.initState();
    _initTabData();

    _tabController =
        TabController(initialIndex: 0, length: _tabDatas.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    print("home build");
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                  child: TabBarView(
                    children: _tabPages,
                    controller: _tabController,
                  )),
              MyTabBar(_tabDatas, _tabController)
            ],
          ),
        ),
      ),
    );
  }
}

class TabItem {
  Image selIcon;
  Image unSelIcon;
  String title;

  TabItem(this.selIcon, this.unSelIcon, this.title);
}

///封装的目的是为了当点击TabBar中一项时，只刷新TabBar
class MyTabBar extends StatefulWidget {
  final List<TabItem> tabData;
  final TabController controller;

  MyTabBar(this.tabData, this.controller);

  @override
  _MyTabBarState createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> {
  int _selIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("MyTabBar build");
    return Container(
      child: TabBar(
        tabs: _tabs(),
        controller: widget.controller,
        indicator: BoxDecoration(),
        onTap: (index) {
          if (index != _selIndex) {
            setState(() {
              _selIndex = index;
            });
          }
        },
      ),
    );
  }

  ///构建tab控件
  List<Widget> _tabs() {
    List<Widget> _tabs = List();
    for (int i = 0; i < widget.tabData.length; i++) {
      _tabs.add(Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 25,
              height: 25,
              child: _selIndex == i
                  ? widget.tabData[i].selIcon
                  : widget.tabData[i].unSelIcon,
            ),
            Text(
              widget.tabData[i].title,
              style: TextStyle(
                  color:
                      _selIndex == i ? Colours.app_main : Colours.text_normal),
            )
          ],
        ),
      ));
    }
    return _tabs;
  }
}
