import 'package:flutter/material.dart';
import 'package:flutter_movie/pages/movie/bean/movie_resp.dart';
import 'package:flutter_movie/res/colors.dart';
import 'package:flutter_movie/utils/adapt_ui.dart';
import 'package:flutter_movie/utils/image_utils.dart';
import 'package:quiver/strings.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class BannerWidget extends StatefulWidget {
  final List<BannerItem> banners;

  const BannerWidget({Key key, this.banners}) : super(key: key);

  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int len = widget.banners?.length ?? 0;
    print('BannerWidget build' + len.toString());
    return len == 0
        ? SizedBox()
        : Container(
            width: double.infinity,
            padding: EdgeInsets.all(UIAdaptor.w(20)),
            color: Colours.color_F3F5F7,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: AspectRatio(
                aspectRatio: 2.45,
                child: Swiper(
                  loop: len > 1,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if(isEmpty(widget.banners[index]?.url)) {
                          return;
                        }
                      },
                      child: Container(
                        color: Colours.list_bg_color,
                        child: ImageUtil.loadNetworkImage(widget.banners[index]?.cover),
                      ),
                    );
                  },
                  autoplay: len > 1,
                  itemCount: widget.banners == null ? 0 : widget.banners.length,
                  pagination: BannerSwiperPlugin(),
                ),
              ),
            ),
          );
  }
}

//自定义分页指示器
class BannerSwiperPlugin extends SwiperPlugin {
  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    List<Widget> indicators = [];
    if (config.itemCount > 1) {
      for (int i = 0; i < config.itemCount; i++) {
        indicators.add(i == config.activeIndex
            ? Padding(
                padding: EdgeInsets.fromLTRB(
                    0,
                    0,
                    i == config.itemCount - 1 ? 0 : 8,
                    0),
                child: SizedBox(
                  width: 24,
                  height: 10,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colours.color_26B7FF,
                        shape: BoxShape.rectangle),
                  ),
                ),
              ) //选中的指示器
            : Padding(
                padding: EdgeInsets.fromLTRB(
                    0,
                    0,
                    i == config.itemCount - 1 ? 0 : 8,
                    0),
                child: SizedBox(
                  width: 10,
                  height: 10,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colours.white, shape: BoxShape.circle),
                  ),
                ),
              ));
      }
    }

    return indicators.length > 0
        ? Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 24),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: indicators,
              ),
            ),
          )
        : SizedBox();
  }
}
