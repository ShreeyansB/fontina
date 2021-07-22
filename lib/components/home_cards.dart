import 'package:flutter/material.dart';
import 'package:fontina/dependencies/fonts_dep.dart';
import 'package:fontina/dependencies/search_filter_dep.dart';
import 'package:fontina/dependencies/side_navigation_dep.dart';
import 'package:fontina/screens/font_details_screen.dart';
import 'package:fontina/util/responsive.dart';
import 'package:fontina/util/theme.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard({Key? key, required this.type}) : super(key: key);

  final String type;
  final fontsController = Get.find<FontgenFontsController>();

  final Map titleMap = {
    "Sans Serif": "Sans\nSerif",
    "Serif": "Serif",
    "Slab Serif": "Slab\nSerif",
    "Monospace": "Mono\nspace",
    "Handwriting": "Hand\nWriting",
    "Display": "Display",
  };
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<SearchFilterController>().isolateFilter(type);
        Get.find<SideMenuController>().switchScreen(1);
      },
      child: ClipRRect(
        borderRadius: MyTheme.borderRadius,
        child: Container(
          decoration: BoxDecoration(
              color: fontsController.colorMap[type]!.withOpacity(0.55),
              borderRadius: MyTheme.borderRadius),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset(
                      "assets/images/${type.replaceAll(" ", "")}_tab.png",
                      height: constraints.maxHeight * 1.1,
                      color: fontsController.colorMap[type],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Padding(
                      padding: Responsive.isMobile(context)
                          ? EdgeInsets.only(top: 10, left: 11)
                          : EdgeInsets.only(top: 20, left: 22),
                      child: Container(
                        height: constraints.maxHeight -
                            (Responsive.isMobile(context) ? 20 : 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              titleMap[type],
                              style: MyTheme.cardKey.copyWith(
                                  fontSize: constraints.maxHeight * 0.2,
                                  fontWeight: FontWeight.w800),
                            ),
                            Text(
                              "${fontsController.numOfFonts[fontsController.types.indexOf(type)]} fonts",
                              style: MyTheme.cardKey.copyWith(
                                  fontSize: constraints.maxHeight * 0.1,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class LatestFontCard extends StatelessWidget {
  LatestFontCard({Key? key, required this.font}) : super(key: key);

  final FontgenFonts font;
  final fontsController = Get.find<FontgenFontsController>();
  final DateFormat format = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12, width: 1),
        borderRadius: MyTheme.borderRadius,
      ),
      child: ClipRRect(
        borderRadius: MyTheme.borderRadius,
        child: InkWell(
          borderRadius: MyTheme.borderRadius,
          splashColor: MyTheme.primaryColorLight.withOpacity(0.15),
          hoverColor: Colors.black.withOpacity(0.02),
          highlightColor: Colors.transparent,
          onTap: () {
            Get.to(
              () => FontDetailsScreen(font: font),
              transition: Transition.zoom,
              duration: Duration(milliseconds: 340),
              curve: Curves.easeOutBack,
            );
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Positioned(
                    top: constraints.maxHeight * 0.05,
                    right: 0,
                    child: Image.asset(
                      "assets/images/${font.type.replaceAll(" ", "")}-bg.png",
                      height: constraints.maxHeight * 0.9,
                      color: Colors.black12,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Padding(
                      padding: Responsive.isMobile(context)
                          ? EdgeInsets.only(top: 10, left: 11)
                          : EdgeInsets.only(top: 20, left: 22),
                      child: Container(
                        height: constraints.maxHeight -
                            (Responsive.isMobile(context) ? 20 : 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  font.family.length > 15 ? font.family.substring(0,15) + "..." : font.family,
                                  style: MyTheme.cardKey.copyWith(
                                      fontSize: constraints.maxHeight * 0.18,
                                      fontWeight: FontWeight.w800),
                                ),
                                SizedBox(
                                  height: constraints.maxHeight * 0.02,
                                ),
                                Text(
                                  "by ${font.foundry.length > 25 ? font.foundry.substring(0,25) + "..." : font.foundry}",
                                  style: MyTheme.cardKey.copyWith(
                                      fontSize: constraints.maxHeight * 0.09,
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                            Text(
                              "Added : ${format.format(font.dateAdded)}",
                              style: MyTheme.cardKey.copyWith(
                                  fontSize: constraints.maxHeight * 0.1,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
