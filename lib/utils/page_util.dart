import 'package:flutter/material.dart';
import 'package:flutter_movie/res/colors.dart';
import 'package:flutter_movie/res/dimens.dart';

class PageUtil {

  ///打开页面
  static void openPage(Widget widget, BuildContext context) {
    if (widget == null) {
      return;
    }

    Navigator.push(context, new MaterialPageRoute(builder: (context){
      return widget;
    }));
  }


  ///创建标题栏中间的文字组件
  static Widget getMiddleTitle(String title, {Color textColor = Colors.black}) {
    return Text(
      title,
      style: TextStyle(
          color: textColor,
          fontSize: 17,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );

  }

  ///创建返回Widget
  static Widget getBackWidget(BuildContext context){
    return GestureDetector(
      child: Container(
        child: Icon(Icons.arrow_back, color: Colours.text_gray_6, size: FontSize.title,),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }


}