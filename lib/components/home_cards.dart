import 'package:flutter/material.dart';
import 'package:fontina/dependencies/fonts_dep.dart';
import 'package:fontina/dependencies/search_filter_dep.dart';
import 'package:fontina/dependencies/side_navigation_dep.dart';
import 'package:fontina/util/theme.dart';
import 'package:get/get.dart';

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
                      padding: const EdgeInsets.only(top: 20, left: 22),
                      child: Text(
                        titleMap[type],
                        style: MyTheme.cardKey.copyWith(
                            fontSize: constraints.maxHeight * 0.2,
                            fontWeight: FontWeight.w800),
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
