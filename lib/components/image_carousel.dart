import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:fontina/components/image_viewer.dart';
import 'package:fontina/dependencies/fonts_dep.dart';
import 'package:fontina/util/theme.dart';
import 'package:get/get.dart';

class ImageCarousel extends StatelessWidget {
  const ImageCarousel({Key? key, required this.font, required this.isRow})
      : super(key: key);
  final bool isRow;
  final FontgenFonts font;

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    if (isRow) {
      return Expanded(
        child: SizedBox(
          height: 400,
          child: Swiper(
            itemCount: font.showcaseImg,
            loop: true,
            autoplay: true,
            autoplayDelay: 5000,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Get.to(() => ImageViewer(imgURL: "https://fontgen-sb.herokuapp.com/download/${font.family}-${index + 1}.png"), transition: Transition.zoom, duration: Duration(milliseconds: 340), curve: Curves.easeOutBack,),
                child: CachedNetworkImage(
                  imageUrl:
                      "https://fontgen-sb.herokuapp.com/download/${font.family}-${index + 1}.png",
                  imageBuilder: (context, imageProvider) => Container(
                    // margin: EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      borderRadius: MyTheme.borderRadius,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => SizedBox(
                      height: 100,
                      child: Center(child: CircularProgressIndicator())),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              );
            },
          ),
        ),
      );
    } else {
      return SizedBox(
        height: _size.width > 684 ? 320 : 240,
        width: 800,
        child: Swiper(
          itemCount: font.showcaseImg,
          loop: true,
          autoplay: true,
          autoplayDelay: 5000,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Get.to(() => ImageViewer(imgURL: "https://fontgen-sb.herokuapp.com/download/${font.family}-${index + 1}.png"), transition: Transition.zoom, duration: Duration(milliseconds: 340), curve: Curves.easeOutBack,),
              child: CachedNetworkImage(
                imageUrl:
                    "https://fontgen-sb.herokuapp.com/download/${font.family}-${index + 1}.png",
                imageBuilder: (context, imageProvider) => Container(
                  // margin: EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    borderRadius: MyTheme.borderRadius,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                placeholder: (context, url) => SizedBox(
                    height: 100,
                    child: Center(child: CircularProgressIndicator())),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            );
          },
        ),
      );
    }
  }
}

