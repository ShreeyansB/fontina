import 'package:flutter/material.dart';
import 'package:fontina/dependencies/fonts_dep.dart';
import 'package:fontina/util/theme.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class FontDetailsCard extends StatelessWidget {
  FontDetailsCard({Key? key, required this.font}) : super(key: key);

  final FontgenFonts font;

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  Color colorLightness(Color color, double value) {
    return HSLColor.fromColor(color).withLightness(value).toColor();
  }

  @override
  Widget build(BuildContext context) {
    DateFormat myFormat = DateFormat("d-M-y");
    var fontsController = Get.find<FontgenFontsController>();
    var size = MediaQuery.of(context).size;
    return Container(
      width: 600,
      decoration: BoxDecoration(
        borderRadius: MyTheme.borderRadius,
        color: (fontsController.colorMap[font.type] != null)
            ? fontsController.colorMap[font.type]!.withOpacity(0.35)
            : Colors.pink.shade200,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 11,
            right: 0,
            child: Image.asset(
              "assets/images/${font.type.replaceAll(' ', '')}-bg.png",
              height: 250,
              color: (fontsController.colorMap[font.type] != null)
                  ? colorLightness(fontsController.colorMap[font.type]!, 0.73)
                  : Colors.pink,
            ),
          ),
          Padding(
            padding: MyTheme.cardPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Font Details",
                  style: MyTheme.headingSec,
                ),
                SizedBox(
                  height: 14,
                ),
                Row(
                  children: [
                    Text(
                      "Family :  ",
                      style: MyTheme.cardKey,
                    ),
                    Text(
                      font.family,
                      style: MyTheme.cardValue,
                    ),
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    Text(
                      "Foundry :  ",
                      style: MyTheme.cardKey,
                    ),
                    Text(
                      font.foundry,
                      style: MyTheme.cardValue,
                    ),
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    Text(
                      "Type :  ",
                      style: MyTheme.cardKey,
                    ),
                    Text(
                      font.type,
                      style: MyTheme.cardValue,
                    ),
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    Text(
                      "URL :  ",
                      style: MyTheme.cardKey,
                    ),
                    GestureDetector(
                      onTap: () => _launchURL(font.url),
                      child: Text(
                        size.width > 700 ? font.url : "Link",
                        style: MyTheme.cardValue,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    Text(
                      "Date Added :  ",
                      style: MyTheme.cardKey,
                    ),
                    Text(
                      size.width > 480
                          ? font.dateAdded.toString()
                          : myFormat.format(font.dateAdded),
                      style: MyTheme.cardValue,
                    ),
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    Text(
                      "Price :  ",
                      style: MyTheme.cardKey,
                      textScaleFactor: 1.05,
                    ),
                    Text(
                      font.isPaid ? "Paid" : "Free",
                      style: MyTheme.cardValue.copyWith(
                        color:
                            font.isPaid ? Color(0xff9b475d) : Color(0xff447c69),
                      ),
                      textScaleFactor: 1.02,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Wrap(
                  direction: Axis.horizontal,
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(
                      font.weights.length,
                      (int index) => Container(
                            decoration: BoxDecoration(
                                borderRadius: MyTheme.borderRadius / 1.4,
                                color: (fontsController.colorMap[font.type] !=
                                        null)
                                    ? colorLightness(
                                        fontsController.colorMap[font.type]!,
                                        0.62)
                                    : Colors.pink),
                            padding: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 8),
                            child: Text(
                              font.weights[index],
                              style: MyTheme.cardValue.copyWith(
                                  fontSize: 15,
                                  color: (fontsController.colorMap[font.type] !=
                                          null)
                                      ? colorLightness(
                                          fontsController.colorMap[font.type]!,
                                          0.9)
                                      : Colors.pink.shade200),
                            ),
                          )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
