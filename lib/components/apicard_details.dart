import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fontina/dependencies/fontgen_info_dep.dart';
import 'package:fontina/util/theme.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class APIInfoCard extends StatelessWidget {
  final double scale;
  const APIInfoCard({Key? key, required this.scale}) : super(key: key);

  void _launchURL(_url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: MyTheme.borderRadius,
        border: Border.all(color: Colors.black12, width: 1.0),
      ),
      child: Obx(() => Padding(
            padding: MyTheme.cardPadding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Get.find<FontgenInfoController>().fontgenInfo.value.name +
                          " API",
                      textScaleFactor: this.scale,
                      style: MyTheme.headingSec,
                    ),
                    SizedBox(
                      height: 14.0,
                    ),
                    Row(
                      children: [
                        Text("Version:  ",
                            textScaleFactor: this.scale,
                            style: MyTheme.cardKey),
                        Text(
                            Get.find<FontgenInfoController>()
                                .fontgenInfo
                                .value
                                .version,
                            textScaleFactor: this.scale,
                            style: MyTheme.cardValue),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        Text("Author:  ",
                            textScaleFactor: this.scale,
                            style: MyTheme.cardKey),
                        Text(
                            Get.find<FontgenInfoController>()
                                .fontgenInfo
                                .value
                                .author,
                            textScaleFactor: this.scale,
                            style: MyTheme.cardValue),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        Text("Repo:  ",
                            textScaleFactor: this.scale,
                            style: MyTheme.cardKey),
                        RichText(
                          textScaleFactor: this.scale,
                          text: TextSpan(
                              text: Get.find<FontgenInfoController>()
                                  .fontgenInfo
                                  .value
                                  .repo,
                              style: MyTheme.cardValue,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  _launchURL(Get.find<FontgenInfoController>()
                                      .fontgenInfo
                                      .value
                                      .repo);
                                }),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        Text("Last Updated:  ",
                            textScaleFactor: this.scale,
                            style: MyTheme.cardKey),
                        Text(
                            Get.find<FontgenInfoController>()
                                .fontgenInfo
                                .value
                                .lastUpdated,
                            textScaleFactor: this.scale,
                            style: MyTheme.cardValue),
                      ],
                    ),
                  ],
                ),
                Obx(
                  () => Image.asset(
                    Get.find<FontgenInfoController>().conn.value == true
                        ? "assets/images/internet-on.png"
                        : "assets/images/internet-off.png",
                    height: 70.0,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
