import 'package:flutter/material.dart';
import 'package:fontina/dependencies/fonts_dep.dart';
import 'package:fontina/util/responsive.dart';
import 'package:fontina/util/theme.dart';
import 'package:get/get.dart';

class FontFamilyGrid extends StatelessWidget {
  FontFamilyGrid({Key? key, required this.crossAxisCount}) : super(key: key);
  final int crossAxisCount;
  final _fontgenFontsController = Get.find<FontgenFontsController>();

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Responsive.isMobile(context)
            ? (_size.width > 620 ? 3 : crossAxisCount)
            : (Responsive.isDesktop(context)
                ? (_size.width > 1360 ? crossAxisCount : 3)
                : crossAxisCount),
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
        childAspectRatio: 1.2,
      ),
      itemCount: _fontgenFontsController.types.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return FontFamilyInfoCard(
          index: index,
        );
      },
    );
  }
}

class FontFamilyInfoCard extends StatelessWidget {
  FontFamilyInfoCard({required this.index});

  final int index;

  final _fontgenFontsController = Get.find<FontgenFontsController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MyTheme.cardPadding,
      decoration: BoxDecoration(
        borderRadius: MyTheme.borderRadius,
        color: _fontgenFontsController.colors[index].withOpacity(0.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(MyTheme.defaultPadding / 5),
            height: 41.0,
            decoration: BoxDecoration(
              color: HSLColor.fromColor(_fontgenFontsController.colors[index])
                  .withLightness(0.73)
                  .toColor(),
              borderRadius: MyTheme.borderRadius / 1.5,
            ),
            child: Image.asset(
              _fontgenFontsController
                  .getImgSrc(_fontgenFontsController.types[index]),
              color: HSLColor.fromColor(_fontgenFontsController.colors[index])
                  .withLightness(0.85)
                  .toColor(),
            ),
          ),
          Text(
            _fontgenFontsController.types[index],
            style: MyTheme.cardKey,
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: ProgressLine(
                fontgenFontsController: _fontgenFontsController, index: index),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _fontgenFontsController.numOfFamilyFiles[index].toString() +
                    " files out of",
                style: MyTheme.cardKey,
                textScaleFactor: 0.75,
              ),
              Opacity(
                  opacity: 0.6,
                  child: Text(
                    _fontgenFontsController.numOfFamilyFiles
                        .reduce((a, b) => a + b)
                        .toString(),
                    style: MyTheme.cardKey.copyWith(),
                    textScaleFactor: 0.75,
                  ))
            ],
          )
        ],
      ),
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    required FontgenFontsController fontgenFontsController,
    required this.index,
  })  : _fontgenFontsController = fontgenFontsController,
        super(key: key);

  final FontgenFontsController _fontgenFontsController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 5,
          decoration: BoxDecoration(
              color: _fontgenFontsController.colors[index].withOpacity(0.3),
              borderRadius: MyTheme.borderRadius),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              height: 5,
              width: constraints.maxWidth *
                  _fontgenFontsController.numOfFamilyFiles[index] /
                  _fontgenFontsController.numOfFamilyFiles
                      .reduce((a, b) => a + b),
              decoration: BoxDecoration(
                  color: _fontgenFontsController.colors[index],
                  borderRadius: MyTheme.borderRadius),
            );
          },
        )
      ],
    );
  }
}
