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
                      centerSpaceRadius: !Responsive.isMobile(context) ? (_size.width > 1185 ? 80 : 50) : 80,
                      startDegreeOffset: -90,
                      sections: _fontgenFontsController.getPieChartSections(),
                      pieTouchData: PieTouchData(
                        enabled: true,
                      )),
                ),
                Positioned.fill(
                  top: 62.0,
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
          )
        ],
      ),
    );
  }
}
