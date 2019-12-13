import 'package:flutter/material.dart';
import 'package:flutter_movie/res/colors.dart';
import 'package:flutter_movie/utils/adapt_ui.dart';
import 'package:flutter_movie/utils/page_util.dart';
import 'package:quiver/strings.dart' as s;
///
/// 自定义的Titlebar
/// 特点：
/// 1.可以传入自定义的控件，比较灵活
/// 2.可以据标题栏的背景色自动修改状态栏的颜色
///
/// 注意：这自定义的titlebar没有实现sliver协议，也就不会有那一堆滚动效果
///
/// 注意：flutter中几乎不能直接操作状态栏区域的效果，要想自由定制效果，貌似只有通过Scaffold的appbar间接操作（原理等以后有时间查一下）
///
class TitleBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget middle;
  final Widget left;
  final Widget right;
  final String titleText;
  final TitleBarStyle titleBarStyle;

  TitleBar({this.middle,
    this.left,
    this.right,
    this.titleText,
    this.titleBarStyle,});

  @override
  State<StatefulWidget> createState() {
    return _TitleBarState();
  }

  @override
  Size get preferredSize => Size.fromHeight(40);
}

class _TitleBarState extends State<TitleBar> {
  TitleBarStyle _titleBarStyle;
  Widget leftWidget;
  Widget middleWidget;

  @override
  void initState() {
    if (widget.titleBarStyle == null) {
      _titleBarStyle = TitleBarStyle.normal;
    } else {
      _titleBarStyle = widget.titleBarStyle;
    }
    initDefault();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    SizedBox defaultWidget = SizedBox();
    return Material(
      color: _titleBarStyle.bg,
      child: SafeArea(
        child: SizedBox(
          height: _titleBarStyle.height,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: _titleBarStyle.isShowLeft &&
                            leftWidget != null ? leftWidget : defaultWidget,
                        alignment: Alignment.centerLeft,
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Center(
                        child: _titleBarStyle.isShowMiddle &&
                            middleWidget != null
                            ? middleWidget
                            : defaultWidget,
                      ),
                      flex: 3,
                    ),
                    Expanded(
                      child: Center(
                        child: _titleBarStyle.isShowRight
                            ? widget.right
                            : defaultWidget,
                      ),
                      flex: 1,
                    )
                  ],
                ),
              ),
              _titleBarStyle.isShowDivider
                  ? Divider(color: _titleBarStyle.dividerColor, height: 1,)
                  : defaultWidget //分割线
            ],
          ),
        ),
      ),
    );
  }


  ///初始化默认的标题栏控件
  void initDefault() {
    if (_titleBarStyle.isShowLeft && widget.left == null) {
      leftWidget = PageUtil.getBackWidget(context);
    }


    if(widget.middle != null) {
      middleWidget = widget.middle;
    } else if(s.isNotEmpty(widget.titleText)) {
      middleWidget = PageUtil.getMiddleTitle(widget.titleText);
    } else {
      middleWidget = SizedBox();
    }
  }
}

///标题栏的样式配置
///据style可以灵活的控制titlebar
class TitleBarStyle {
  final Color bg; //背景
  final double height; //高度
  final Color dividerColor; //分割线的颜色
  final bool isShowLeft;
  final bool isShowMiddle;
  final bool isShowRight;
  final bool isShowDivider;

  TitleBarStyle({this.bg = Colours.white,
    this.height = 40.0,
    this.dividerColor = Colours.border_color,
    this.isShowLeft = true,
    this.isShowMiddle = true,
    this.isShowRight = true,
    this.isShowDivider = true});

  ///一般的样式
  static final normal = TitleBarStyle(
      bg: Colours.white, height: UIAdaptor.h(91), dividerColor: Colours.border_color);

  //课表页的标题栏样式
  static final scheduleTabStyle =
  TitleBarStyle(bg: Colours.white, height: 0, isShowDivider: false);
}
