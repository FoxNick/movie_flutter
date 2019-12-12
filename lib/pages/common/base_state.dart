import 'package:flutter/material.dart';
import 'package:flutter_movie/pages/common/status_widget.dart';
import 'package:toast/toast.dart';

import 'base_view.dart';
import 'loading_widget.dart';

///
/// 封装了一些基本的常用的功能：
/// 1、状态页面，空页面、无网页面等
/// 2、加载中动画的控制
/// 3、Toast提示
abstract class BaseState<T extends StatefulWidget> extends State<T> with AutomaticKeepAliveClientMixin
    implements IView {
  int statusType = StatusType.NONE;
  bool _isShowLoading = false; //是否显示加载动画

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ///处理状态
    Widget withStatusWidget = statusType == StatusType.NONE
        ? buildUI(context)
        : StatusWidget(
            statusType,
            width: getStatusSize()?.width,
            height: getStatusSize()?.height,
            clickCallback: (statusType) {
              onStatusClick(statusType);
            },
          );
    return Scaffold(
      body: Container(
        child: _isShowLoading
            ? LoadingWidget(
                isSHow: true,
                child: withStatusWidget,
              )
            : withStatusWidget,
      ),
    );
  }

  ///实际返回UI的方法
  Widget buildUI(BuildContext context);

  ///返回状态控件的尺寸
  Size getStatusSize() {
    return Size.infinite;
  }

  ///当状态控件被点击
  onStatusClick(int statusType) {}

  @override
  showStatus(int status) {
    if (mounted && status != statusType) {
      setState(() {
        status = statusType;
      });
    }
  }

  @override
  showLoading() {
    if (!mounted) {
      return;
    }
    setState(() {
      _isShowLoading = true;
    });
  }

  ///Toast提示
  @override
  void showToast(String string) {
    if (!mounted) {
      return;
    }
    Toast.show(string, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  @override
  closeLoading() {
    if (!mounted) {
      return;
    }
    setState(() {
      _isShowLoading = false;
    });
  }

  @override
  bool get wantKeepAlive => false;
}
