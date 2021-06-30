import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fontina/dependencies/fontgen_info_dep.dart';
import 'package:fontina/util/theme.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class APIInfoCard extends StatelessWidget {
  final double scale;
  APIInfoCard({Key? key, required this.scale}) : super(key: key);

  void _launchURL(_url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  final _fontgenInfoController = Get.find<FontgenInfoController>();

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: MyTheme.borderRadius,
        border: Border.all(color: Colors.black12, width: 1.0),
      ),
      child: InkWell(
        borderRadius: MyTheme.borderRadius,
        splashColor: MyTheme.primaryColorLight.withOpacity(0.15),
        hoverColor: Colors.black.withOpacity(0.02),
        highlightColor: Colors.transparent,
        onTap: () {
          _fontgenInfoController.updateAPI();
        },
        child: Padding(
          padding: MyTheme.cardPadding,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _fontgenInfoController.fontgenInfo.value.name + " API",
                    textScaleFactor: this.scale,
                    style: MyTheme.headingSec,
                  ),
                  SizedBox(
                    height: 14.0,
                  ),
                  Row(
                    children: [
                      Text("Version:  ",
                          textScaleFactor: this.scale, style: MyTheme.cardKey),
                      Obx(() => Text(
                          _fontgenInfoController.fontgenInfo.value.version,
                          textScaleFactor: this.scale,
                          style: MyTheme.cardValue)),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Text("Author:  ",
                          textScaleFactor: this.scale, style: MyTheme.cardKey),
                      Obx(
                        () => Text(
                            _fontgenInfoController.fontgenInfo.value.author,
                            textScaleFactor: this.scale,
                            style: MyTheme.cardValue),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Text("Repo:  ",
                          textScaleFactor: this.scale, style: MyTheme.cardKey),
                      RichText(
                        textScaleFactor: this.scale,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                            text: _size.width > 490
                                ? _fontgenInfoController.fontgenInfo.value.repo
                                : "Github/fontina",
                            style: MyTheme.cardValue,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                _launchURL(_fontgenInfoController
                                    .fontgenInfo.value.repo);
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
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: this.scale,
                          style: MyTheme.cardKey),
                      Obx(() => Text(
                          _fontgenInfoController.fontgenInfo.value.lastUpdated,
                          textScaleFactor: this.scale,
                          style: MyTheme.cardValue)),
                    ],
                  ),
                ],
              ),
              Positioned(
                top: 0.0,
                right: 0.0,
                child: Obx(
                  () => Image.asset(
                    _fontgenInfoController.conn.value == true
                        ? "assets/images/internet-on.png"
                        : "assets/images/internet-off.png",
                    height: _size.width > 535 ? 70.0 * scale : 70.0 * scale / 1,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
