import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_movie/res/colors.dart';

class ImageUtil {
  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  /// 加载本地资源图片
  static Widget loadAssetImage(String name,
      {double width, double height, BoxFit fit}) {
    return Image.asset(
      getImgPath(name),
      height: height,
      width: width,
      fit: fit,
    );
  }

  /// 加载网络图片
  static Widget loadNetworkImage(String imageUrl,
      {String placeholder = "icon_loading",
      String error = "icon_load_fail",
      double width,
      double height,
      BoxFit fit: BoxFit.cover}) {
    return CachedNetworkImage(
      imageUrl: imageUrl == null ? "" : imageUrl,
      placeholder: (context, url) {
        return Container(
          color: Colours.color_eeeeee,
          child: Center(
            child: loadAssetImage(placeholder),
          ),
        );
      },
      errorWidget: (context, url, e) {
        return Container(
          color: Colours.color_eeeeee,
          child: Center(
            child: loadAssetImage(error),
          ),
        );
      },
      width: width,
      height: height,
      fit: fit,
    );
  }

  ///加载圆形带边框头像
  static Widget getCircleAvatar(String imageUrl, double width, double height,
      {String placeholder = "icon_loading",
      String error = "icon_load_fail",
      BoxFit fit: BoxFit.cover,
      bool isLocal = false}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Colours.border_color,
          shape: BoxShape.circle,
          border: Border.all(color: Colours.bg_color, width: 0.5)),
      child: ClipOval(
        child: isLocal
            ? loadAssetImage(imageUrl, width: width, height: height, fit: fit)
            : loadNetworkImage(imageUrl,
                width: width,
                height: height,
                placeholder: placeholder,
                error: error,
                fit: fit),
      ),
    );
  }
}
