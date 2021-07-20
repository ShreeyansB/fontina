import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fontina/components/gen_color_pickers.dart';
import 'package:fontina/components/image_viewer.dart';
import 'package:fontina/dependencies/fonts_dep.dart';
import 'package:fontina/dependencies/gen_dep.dart';
import 'package:fontina/util/responsive.dart';
import 'package:fontina/util/theme.dart';
import 'package:get/get.dart';
import 'package:image_pixels/image_pixels.dart';

class ParaGen extends StatefulWidget {
  const ParaGen({Key? key}) : super(key: key);

  @override
  _ParaGenState createState() => _ParaGenState();
}

class _ParaGenState extends State<ParaGen> {
  var generateController = Get.find<GenerateController>();

  Future selectFontsHeadDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black26,
      builder: (context) {
        return AlertDialog(
          elevation: 1,
          insetPadding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
              borderRadius: MyTheme.borderRadius,
              side: BorderSide(color: Colors.black12, width: 1)),
          actionsPadding: MyTheme.cardPadding,
          title: Text(
            "Font Selector",
            style: MyTheme.cardKey,
          ),
          content: SingleChildScrollView(
              physics: BouncingScrollPhysics(), child: FontSelectorHead()),
          actions: [
            OutlinedButton(
                onPressed: () {
                  Get.back(result: [null, null]);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "CANCEL",
                    style: MyTheme.cardKey.copyWith(fontSize: 15),
                  ),
                )),
            SizedBox(
              width: 20,
            ),
            OutlinedButton(
                onPressed: () {
                  Get.back(result: [
                    generateController.alertFontHead.value,
                    generateController.alertWeightHead.value
                  ]);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "SELECT",
                    style: MyTheme.cardKey.copyWith(fontSize: 15),
                  ),
                ))
          ],
        );
      },
    );
  }

  Future selectFontsSubDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black26,
      builder: (context) {
        return AlertDialog(
          elevation: 1,
          insetPadding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
              borderRadius: MyTheme.borderRadius,
              side: BorderSide(color: Colors.black12, width: 1)),
          actionsPadding: MyTheme.cardPadding,
          title: Text(
            "Font Selector",
            style: MyTheme.cardKey,
          ),
          content: SingleChildScrollView(
              physics: BouncingScrollPhysics(), child: FontSelectorSub()),
          actions: [
            OutlinedButton(
                onPressed: () {
                  Get.back(result: [null, null]);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "CANCEL",
                    style: MyTheme.cardKey.copyWith(fontSize: 15),
                  ),
                )),
            SizedBox(
              width: 20,
            ),
            OutlinedButton(
                onPressed: () {
                  Get.back(result: [
                    generateController.alertFontSub.value,
                    generateController.alertWeightSub.value
                  ]);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "SELECT",
                    style: MyTheme.cardKey.copyWith(fontSize: 15),
                  ),
                ))
          ],
        );
      },
    );
  }

  ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _controller,
      physics: BouncingScrollPhysics(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Pick Heading Font:  ",
              style: MyTheme.headingSec,
            ),
            SizedBox(
              height: 20,
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: MyTheme.borderRadius,
                      side: BorderSide(color: Colors.black12, width: 1))),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Obx(
                  () => Text(
                    "${generateController.paraFontHead} [${generateController.paraWeightHead}]",
                    style: MyTheme.cardKey.copyWith(letterSpacing: 0.8),
                  ),
                ),
              ),
              onPressed: () async {
                var result = await selectFontsHeadDialog(context);
                generateController.paraFontHead.value =
                    result[0] ?? generateController.paraFontHead.value;
                generateController.paraWeightHead.value =
                    result[1] ?? generateController.paraWeightHead.value;
              },
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Pick Content Font:  ",
              style: MyTheme.headingSec,
            ),
            SizedBox(
              height: 20,
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: MyTheme.borderRadius,
                      side: BorderSide(color: Colors.black12, width: 1))),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Obx(
                  () => Text(
                    "${generateController.paraFontSub.value} [${generateController.paraWeightSub.value}]",
                    style: MyTheme.cardKey.copyWith(letterSpacing: 0.8),
                  ),
                ),
              ),
              onPressed: () async {
                var result = await selectFontsSubDialog(context);
                generateController.paraFontSub.value =
                    result[0] ?? generateController.paraFontSub.value;
                generateController.paraWeightSub.value =
                    result[1] ?? generateController.paraWeightSub.value;
              },
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Pick BG and FG Colors:  ",
              style: MyTheme.headingSec,
            ),
            SizedBox(
              height: 20,
            ),
            ParaColorPicker(),
            SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () {
                generateController.paraURL = generateController.apiURL +
                    "?f1=${generateController.paraFontHead}&w1=${generateController.paraWeightHead}&f2=${generateController.paraFontSub}&w2=${generateController.paraWeightSub}&bg=${generateController.colorToString(generateController.paraBGColor.value)}&fg=${generateController.colorToString(generateController.paraFGColor.value)}";
                generateController.update();
                _controller.animateTo(_controller.position.maxScrollExtent,
                    duration: Duration(milliseconds: 800),
                    curve: Curves.easeIn);
              },
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.black12),
                  backgroundColor:
                      MaterialStateProperty.all(MyTheme.primaryColorLight),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: MyTheme.borderRadius))),
              child: Padding(
                padding: MyTheme.cardPadding / 1.5,
                child: Text(
                  "Generate",
                  style: MyTheme.cardKey.copyWith(
                      color: MyTheme.bgColorLight, letterSpacing: 0.8),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Result : ",
              style: MyTheme.headingSec,
            ),
            SizedBox(
              height: 20,
            ),
            GetBuilder<GenerateController>(
              builder: (controller) {
                if (controller.paraURL == "") {
                  return Container(
                    height: 50,
                  );
                } else {
                  return GestureDetector(
                    onTap: () => Get.to(
                        () => ImageViewer(imgURL: generateController.paraURL)),
                    child: Container(
                      height: Responsive.isMobile(context) ? 300 : 450,
                      width: Responsive.isMobile(context) ? 500 : 700,
                      child: CachedNetworkImage(
                        imageUrl: generateController.paraURL,
                        imageBuilder: (context, imageProvider) => ClipRRect(
                          borderRadius: MyTheme.borderRadius,
                          child: ImagePixels.container(
                            imageProvider: imageProvider,
                            colorAlignment: Alignment.topLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: MyTheme.borderRadius,
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                        placeholder: (context, url) => SizedBox(
                            height: 50,
                            child: Center(child: CircularProgressIndicator())),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 100)
          ],
        ),
      ),
    );
  }
}

class FontSelectorHead extends StatefulWidget {
  const FontSelectorHead({Key? key}) : super(key: key);

  @override
  _FontSelectorHeadState createState() => _FontSelectorHeadState();
}

class _FontSelectorHeadState extends State<FontSelectorHead> {
  Future<bool> loadDetails() async {
    return Future.delayed(Duration(milliseconds: 1000), () {
      return true;
    });
  }

  var fontIndex = 0.obs;
  var weightIndex = 0.obs;

  var fontsController = Get.find<FontgenFontsController>();
  var generateController = Get.find<GenerateController>();
  List<FontgenFonts> loadedFonts = [];

  @override
  void initState() {
    loadedFonts = fontsController.fonts;
    loadedFonts.sort((a, b) => a.family.compareTo(b.family));
    fontIndex.value = loadedFonts
        .indexWhere((f) => f.family == generateController.paraFontHead.value);
    generateController.alertFontHead.value = loadedFonts[0].family;
    generateController.alertWeightHead.value = loadedFonts[0].weights[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.isMobile(context)
          ? MediaQuery.of(context).size.width / 1.3
          : MediaQuery.of(context).size.width / 2.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Select Font Family",
            style: MyTheme.headingSec,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 360,
            decoration: BoxDecoration(
              borderRadius: MyTheme.borderRadius,
              border: Border.all(color: Colors.black12, width: 1.0),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: fontsController.fonts.length,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  fontIndex.value = index;
                  generateController.alertFontHead.value =
                      loadedFonts[index].family;
                  generateController.alertWeightHead.value =
                      loadedFonts[index].weights[0];
                },
                child: Obx(() => Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: fontIndex.value == index
                            ? Colors.black.withOpacity(0.05)
                            : Colors.transparent,
                        border: Border(
                          bottom: BorderSide(color: Colors.black12, width: 1),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 13),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(
                                      MyTheme.defaultPadding / 5),
                                  decoration: BoxDecoration(
                                    color: HSLColor.fromColor(fontsController
                                            .colorMap[loadedFonts[index].type]!)
                                        .withLightness(0.73)
                                        .toColor(),
                                    borderRadius: MyTheme.borderRadius / 1.5,
                                  ),
                                  child: Image.asset(
                                    fontsController
                                        .getImgSrc(loadedFonts[index].type),
                                    color: HSLColor.fromColor(fontsController
                                            .colorMap[loadedFonts[index].type]!)
                                        .withLightness(0.85)
                                        .toColor(),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  loadedFonts[index].family,
                                  style: MyTheme.cardKey,
                                ),
                              ],
                            ),
                            Text(loadedFonts[index].weights.length.toString(),
                                style: MyTheme.cardKey.copyWith(
                                    color: loadedFonts[index].isPaid
                                        ? Color(0xff9b475d)
                                        : Color(0xff447c69)))
                          ],
                        ),
                      ),
                    )),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Select Font Weight",
            style: MyTheme.headingSec,
          ),
          SizedBox(
            height: 20,
          ),
          ClipRRect(
            borderRadius: MyTheme.borderRadius,
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                borderRadius: MyTheme.borderRadius,
                border: Border.all(color: Colors.black12, width: 1.0),
              ),
              child: Obx(() => ListView.builder(
                    itemCount: loadedFonts[fontIndex.value].weights.length,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          weightIndex.value = index;
                          generateController.alertWeightHead.value =
                              loadedFonts[fontIndex.value].weights[index];
                        },
                        child: Obx(() => Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: weightIndex.value == index
                                    ? Colors.black.withOpacity(0.05)
                                    : Colors.transparent,
                                border: Border(
                                  right: BorderSide(
                                      color: Colors.black12, width: 1),
                                ),
                              ),
                              child: Text(
                                loadedFonts[fontIndex.value].weights[index],
                                style: MyTheme.cardKey,
                              ),
                            )),
                      );
                    },
                  )),
            ),
          )
        ],
      ),
    );
  }
}

class FontSelectorSub extends StatefulWidget {
  const FontSelectorSub({Key? key}) : super(key: key);

  @override
  _FontSelectorSubState createState() => _FontSelectorSubState();
}

class _FontSelectorSubState extends State<FontSelectorSub> {
  Future<bool> loadDetails() async {
    return Future.delayed(Duration(milliseconds: 1000), () {
      return true;
    });
  }

  var fontIndex = 0.obs;
  var weightIndex = 0.obs;

  var fontsController = Get.find<FontgenFontsController>();
  var generateController = Get.find<GenerateController>();
  List<FontgenFonts> loadedFonts = [];

  @override
  void initState() {
    loadedFonts = fontsController.fonts;
    loadedFonts.sort((a, b) => a.family.compareTo(b.family));
    fontIndex.value = loadedFonts
        .indexWhere((f) => f.family == generateController.paraFontSub.value);
    generateController.alertFontSub.value = loadedFonts[0].family;
    generateController.alertWeightSub.value = loadedFonts[0].weights[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.isMobile(context)
          ? MediaQuery.of(context).size.width / 1.3
          : MediaQuery.of(context).size.width / 2.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Select Font Family",
            style: MyTheme.headingSec,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 360,
            decoration: BoxDecoration(
              borderRadius: MyTheme.borderRadius,
              border: Border.all(color: Colors.black12, width: 1.0),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: fontsController.fonts.length,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  fontIndex.value = index;
                  generateController.alertFontSub.value =
                      loadedFonts[index].family;
                  generateController.alertWeightSub.value =
                      loadedFonts[index].weights[0];
                },
                child: Obx(() => Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: fontIndex.value == index
                            ? Colors.black.withOpacity(0.05)
                            : Colors.transparent,
                        border: Border(
                          bottom: BorderSide(color: Colors.black12, width: 1),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 13),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(
                                      MyTheme.defaultPadding / 5),
                                  decoration: BoxDecoration(
                                    color: HSLColor.fromColor(fontsController
                                            .colorMap[loadedFonts[index].type]!)
                                        .withLightness(0.73)
                                        .toColor(),
                                    borderRadius: MyTheme.borderRadius / 1.5,
                                  ),
                                  child: Image.asset(
                                    fontsController
                                        .getImgSrc(loadedFonts[index].type),
                                    color: HSLColor.fromColor(fontsController
                                            .colorMap[loadedFonts[index].type]!)
                                        .withLightness(0.85)
                                        .toColor(),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  loadedFonts[index].family,
                                  style: MyTheme.cardKey,
                                ),
                              ],
                            ),
                            Text(loadedFonts[index].weights.length.toString(),
                                style: MyTheme.cardKey.copyWith(
                                    color: loadedFonts[index].isPaid
                                        ? Color(0xff9b475d)
                                        : Color(0xff447c69)))
                          ],
                        ),
                      ),
                    )),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Select Font Weight",
            style: MyTheme.headingSec,
          ),
          SizedBox(
            height: 20,
          ),
          ClipRRect(
            borderRadius: MyTheme.borderRadius,
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                borderRadius: MyTheme.borderRadius,
                border: Border.all(color: Colors.black12, width: 1.0),
              ),
              child: Obx(() => ListView.builder(
                    itemCount: loadedFonts[fontIndex.value].weights.length,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          weightIndex.value = index;
                          generateController.alertWeightSub.value =
                              loadedFonts[fontIndex.value].weights[index];
                        },
                        child: Obx(() => Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: weightIndex.value == index
                                    ? Colors.black.withOpacity(0.05)
                                    : Colors.transparent,
                                border: Border(
                                  right: BorderSide(
                                      color: Colors.black12, width: 1),
                                ),
                              ),
                              child: Text(
                                loadedFonts[fontIndex.value].weights[index],
                                style: MyTheme.cardKey,
                              ),
                            )),
                      );
                    },
                  )),
            ),
          )
        ],
      ),
    );
  }
}
