import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:fontina/dependencies/fonts_dep.dart';
import 'package:fontina/util/theme.dart';

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
          height: 320,
          child: Swiper(
            itemCount: font.showcaseImg,
            loop: true,
            autoplay: true,
            autoplayDelay: 5000,
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl:
                    "http://fontgen-sb.herokuapp.com/download/${font.family}-${index + 1}.png",
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
            return CachedNetworkImage(
              imageUrl:
                  "http://fontgen-sb.herokuapp.com/download/${font.family}-${index + 1}.png",
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
            );
          },
        ),
      );
    }
  }
}


// Container(
//           color: Colors.black26,
//           child: CarouselSlider(
//             items: List.generate(
//               font.showcaseImg,
//               (index) => CachedNetworkImage(
//                 imageUrl:
//                     "http://fontgen-sb.herokuapp.com/download/${font.family}-${index + 1}.png",
//                 imageBuilder: (context, imageProvider) => Container(
//                   margin: EdgeInsets.symmetric(horizontal: 25),
//                   decoration: BoxDecoration(
//                     borderRadius: MyTheme.borderRadius,
//                     image: DecorationImage(
//                       image: imageProvider,
//                       fit: BoxFit.fitWidth,
//                     ),
//                   ),
//                 ),
//                 placeholder: (context, url) => SizedBox(
//                     height: 100,
//                     child: Center(child: CircularProgressIndicator())),
//                 errorWidget: (context, url, error) => Icon(Icons.error),
//               ),
//             ),
//             options: CarouselOptions(
//               height: 400,
              
//               enableInfiniteScroll: false,
//             ),
//           ),
//         )