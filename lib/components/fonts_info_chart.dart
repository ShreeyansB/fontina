import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fontina/dependencies/fontgen_info_dep.dart';
import 'package:fontina/dependencies/fonts_dep.dart';
import 'package:fontina/util/responsive.dart';
import 'package:fontina/util/theme.dart';
import 'package:get/get.dart';

class FontsInfoChart extends StatelessWidget {
  final scale;
  FontsInfoChart({
    Key? key,
    this.scale,
  }) : super(key: key);
  final FontgenFontsController _fontgenFontsController =
      Get.find<FontgenFontsController>();
  final FontgenInfoController _fontgenInfoController =
      Get.find<FontgenInfoController>();

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      padding: MyTheme.cardPadding,
      decoration: BoxDecoration(
        borderRadius: MyTheme.borderRadius,
        border: Border.all(color: Colors.black12, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Font Proportion",
            textScaleFactor: this.scale,
            style: MyTheme.headingSec,
          ),
          SizedBox(
            height: 20.0,
          ),
          SizedBox(
            height: 200,
            child: Stack(
              children: [
                PieChart(
                  PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: Responsive.isDesktop(context)
                          ? (_size.width > 1185 ? 80 : 50)
                          : 80,
                      startDegreeOffset: -90,
                      sections: _fontgenFontsController.getPieChartSections(),
                      pieTouchData: PieTouchData(
                        enabled: true,
                      )),
                ),
                Positioned.fill(
                  top: 64.0,
                  child: Obx(
                    () => Column(
                      children: [
                        Text(
                          _fontgenInfoController.fontgenInfo.value.numFonts
                              .toString(),
                          style: MyTheme.largeNumber,
                        ),
                        Text(
                          "fonts",
                          style: MyTheme.cardKey,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Column(
            children: _fontgenFontsController.getPieChartIndicator(),
          )
        ],
      ),
    );
  }
}

class ChartIndicator extends StatelessWidget {
  ChartIndicator(
      {Key? key,
      required this.color,
      required this.imgSrc,
      required this.title,
      required this.amount})
      : super(key: key);

  final Color color;
  final String imgSrc;
  final String title;
  final String amount;

  final FontgenFontsController _fontgenFontsController =
      Get.find<FontgenFontsController>();

  @override
  Widget build(BuildContext context) {
    double _scale = Responsive.isDesktop(context)
        ? (MediaQuery.of(context).size.width > 1255 ? 1 : 0.7)
        : 1;
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      width: double.infinity,
      padding: MyTheme.cardPadding / 1.5,
      decoration: BoxDecoration(
        borderRadius: MyTheme.borderRadius,
        border: Border.all(color: Colors.black12, width: 1.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 30 * _scale,
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: MyTheme.borderRadius / 1.5,
                  color: color.withOpacity(0.4),
                ),
                child: Image.asset(
                  _fontgenFontsController.getImgSrc(title),
                  color: HSLColor.fromColor(color).withLightness(0.6).toColor(),
                  height: 3.0,
                ),
              ),
              SizedBox(
                width: 17.0,
              ),
              Text(
                title,
                style: MyTheme.cardKey,
                textScaleFactor: _scale,
              ),
            ],
          ),
          Text(
            amount.toString(),
            style: MyTheme.cardValue,
            textScaleFactor: _scale,
          )
        ],
      ),
    );
  }
}
