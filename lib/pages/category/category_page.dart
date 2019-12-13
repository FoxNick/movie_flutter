import 'package:flutter/material.dart';
import 'package:flutter_movie/pages/home/home.dart';
import 'package:flutter_movie/pages/movie/movie_page.dart';
import 'package:flutter_movie/res/colors.dart';
import 'package:flutter_movie/utils/adapt_ui.dart';

import '../demo_page.dart';

///分类页面
class CategoryTabPage extends StatefulWidget {
  @override
  _CategoryTabPageState createState() => _CategoryTabPageState();
}

class _CategoryTabPageState extends State<CategoryTabPage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<TabItem> _tabData;
  List<Widget> _pages = List()..add(MoviePage())..add(DemoPage())..add(DemoPage())..add(DemoPage());

  ///构造tab的数据
  _initTabData() {
    _tabData = List()
      ..add(TabItem(null, null, "电影"))
      ..add(TabItem(null, null, "电视剧"))
      ..add(TabItem(null, null, "综艺"))
      ..add(TabItem(null, null, "动漫"));
  }

  @override
  void initState() {
    super.initState();
    _initTabData();

    _tabController = TabController(initialIndex: 0, length: _tabData.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            MovieTabBar(_tabController, _tabData),
            Expanded(
              child: TabBarView(children: _pages, controller: _tabController,),
            )
          ],
        ),
      ),
    );
  }
}

class MovieTabBar extends StatefulWidget {
  final TabController tabController;
  final List<TabItem> tabData;

  MovieTabBar(this.tabController, this.tabData);

  @override
  _MovieTabBarState createState() => _MovieTabBarState();
}

class _MovieTabBarState extends State<MovieTabBar> {
  int _selIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBar(
        tabs: _tabs(),
        controller: widget.tabController,
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

  List<Widget> _tabs() {
    List<Widget> _tabs = List();
    for (int i = 0; i < widget.tabData.length; i++) {
      _tabs.add(Container(
        padding: EdgeInsets.only(top: UIAdaptor.h(10), bottom: UIAdaptor.h(5)),
        child: Text(
          widget.tabData[i].title,
          style: TextStyle(color: _selIndex == i ? Colours.text_normal : Colours.text_gray_6, fontSize: 15),
        ),
      ));
    }
    return _tabs;
  }
}
