import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fontina/components/font_details_card.dart';
import 'package:fontina/components/image_carousel.dart';
import 'package:fontina/components/image_viewer.dart';
import 'package:fontina/dependencies/fonts_dep.dart';
import 'package:fontina/util/responsive.dart';
import 'package:fontina/util/theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_pixels/image_pixels.dart';

class FontDetailsScreen extends StatelessWidget {
  const FontDetailsScreen({Key? key, required this.font}) : super(key: key);

  final FontgenFonts font;

  Future<bool> loadDetails() async {
    return Future.delayed(Duration(milliseconds: 1000), () {
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(
        "https://fontgen-sb.herokuapp.com/para?f1=${font.family}&f2=${font.family}");
    var _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyTheme.bgColorLight,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios_rounded),
            iconSize: 30,
            color: MyTheme.primaryColorLight,
          ),
        ),
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            font.family,
            style: GoogleFonts.spaceGrotesk().copyWith(
                fontSize: 27,
                color: MyTheme.primaryColorLight,
                fontWeight: FontWeight.w700),
          ),
        ),
        elevation: 1,
        backgroundColor: context.theme.scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_size.width > 1345)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FontDetailsCard(font: font),
                            if (font.info != "") SizedBox(height: 20),
                            if (font.info != "") FontInfoTextCard(font: font),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ImageCarousel(
                          font: font,
                          isRow: true,
                        ),
                      ],
                    ),
                  if (_size.width <= 1345) FontDetailsCard(font: font),
                  if (font.info != "" && _size.width <= 1345)
                    SizedBox(height: 20),
                  if (font.info != "" && _size.width <= 1345)
                    FontInfoTextCard(font: font),
                  if (_size.width <= 1345) SizedBox(height: 20),
                  if (_size.width <= 1345)
                    ImageCarousel(
                      font: font,
                      isRow: false,
                    ),
                  SizedBox(height: 20),
                  FutureBuilder(
                      future: loadDetails(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                              padding: MyTheme.cardPadding,
                              decoration: BoxDecoration(
                                borderRadius: MyTheme.borderRadius,
                                border: Border.all(
                                    color: Colors.black12, width: 1.0),
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Paragraph",
                                        style: MyTheme.headingSec),
                                    SizedBox(height: 14),
                                    Wrap(
                                        runSpacing: 20,
                                        spacing: 20,
                                        children: [
                                          GenImage(
                                            font: font,
                                            isDark: false,
                                          ),
                                          GenImage(
                                            font: font,
                                            isDark: true,
                                          )
                                        ])
                                  ]));
                        }
                        return Container(
                          height: 100,
                          width: 100,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }),
                  SizedBox(height: 20),
                  FutureBuilder(
                      future: loadDetails(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                              padding: MyTheme.cardPadding,
                              decoration: BoxDecoration(
                                borderRadius: MyTheme.borderRadius,
                                border: Border.all(
                                    color: Colors.black12, width: 1.0),
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Code", style: MyTheme.headingSec),
                                    SizedBox(height: 14),
                                    Wrap(
                                        runSpacing: 20,
                                        spacing: 20,
                                        children: [
                                          GenImageCode(
                                            font: font,
                                            isDark: true,
                                          ),
                                          GenImageCode(
                                            font: font,
                                            isDark: false,
                                          )
                                        ])
                                  ]));
                        }
                        return Container(
                          height: 100,
                          width: 100,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GenImage extends StatelessWidget {
  const GenImage({
    Key? key,
    required this.font,
    required this.isDark,
  }) : super(key: key);

  final FontgenFonts font;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: 500,
      child: GestureDetector(
        onTap: () {
          Get.to(
            () => ImageViewerPara(
                imgURL:
                    "https://fontgen-sb.herokuapp.com/para?f1=${font.family}&f2=${font.family}",
                name: font.family,
                isDark: isDark),
            transition: Transition.zoom,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeOutBack,
          );
        },
        child: Hero(
          tag: "photo",
          child: CachedNetworkImage(
            imageUrl:
                "https://fontgen-sb.herokuapp.com/para?f1=${font.family}&f2=${font.family}",
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                  borderRadius: MyTheme.borderRadius,
                  color: isDark ? Color(0xff260F26) : Colors.tealAccent),
              child: Container(
                height: size.width > 590 ? 380 : 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fitHeight,
                      colorFilter: ColorFilter.mode(
                          isDark ? Color(0xffFDCFF3) : Color(0xff413D5D),
                          BlendMode.srcATop)),
                ),
              ),
            ),
            placeholder: (context, url) => SizedBox(
                height: 100, child: Center(child: CircularProgressIndicator())),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}

class GenImageCode extends StatelessWidget {
  const GenImageCode({
    Key? key,
    required this.font,
    required this.isDark,
  }) : super(key: key);

  final FontgenFonts font;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: 470,
      child: GestureDetector(
        onTap: () {
          Get.to(
            () => ImageViewerCode(
              imgURL:
                  "https://fontgen-sb.herokuapp.com/code?font=${font.family}&theme=${isDark ? "an-old-hope" : "base16/gruvbox-light-medium"}",
              name: font.family,
            ),
            transition: Transition.zoom,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeOutBack,
          );
        },
        child: Hero(
          tag: "photo",
          child: CachedNetworkImage(
            imageUrl:
                "https://fontgen-sb.herokuapp.com/code?font=${font.family}&theme=${isDark ? "an-old-hope" : "base16/gruvbox-light-medium"}",
            imageBuilder: (context, imageProvider) => ClipRRect(
              borderRadius: MyTheme.borderRadius,
              child: ImagePixels.container(
                imageProvider: imageProvider,
                colorAlignment: Alignment.topLeft,
                child: Container(
                  height: size.width > 590 ? 380 : 230,
                  decoration: BoxDecoration(
                    borderRadius: MyTheme.borderRadius,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ),
            placeholder: (context, url) => SizedBox(
                height: 100, child: Center(child: CircularProgressIndicator())),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}

class FontInfoTextCard extends StatelessWidget {
  const FontInfoTextCard({
    Key? key,
    required this.font,
  }) : super(key: key);

  final FontgenFonts font;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 620,
      padding: MyTheme.cardPadding,
      decoration: BoxDecoration(
        borderRadius: MyTheme.borderRadius,
        border: Border.all(color: Colors.black12, width: 1.0),
      ),
      child: Text(
        "INFO :  " + font.info,
        style: MyTheme.cardKey,
      ),
    );
  }
}
