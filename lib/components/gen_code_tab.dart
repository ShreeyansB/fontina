import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fontina/components/image_viewer.dart';
import 'package:fontina/dependencies/fonts_dep.dart';
import 'package:fontina/dependencies/gen_dep.dart';
import 'package:fontina/util/responsive.dart';
import 'package:fontina/util/theme.dart';
import 'package:get/get.dart';
import 'package:image_pixels/image_pixels.dart';

class CodeGen extends StatefulWidget {
  const CodeGen({Key? key}) : super(key: key);

  @override
  _CodeGenState createState() => _CodeGenState();
}

class _CodeGenState extends State<CodeGen> {
  var generateController = Get.find<GenerateController>();
  ScrollController _controller = ScrollController();

  Future showFontsDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return FontPickerDialog();
      },
    );
  }

  Future showThemesDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return ThemePickerDialog();
      },
    );
  }

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
              "Pick Font:  ",
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
                    "${generateController.codeFont}",
                    style: MyTheme.cardKey.copyWith(letterSpacing: 0.8),
                  ),
                ),
              ),
              onPressed: () async {
                var result = await showFontsDialog(context);
                generateController.codeFont.value =
                    result ?? generateController.codeFont.value;
              },
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Pick Code Theme:  ",
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
                    "${generateController.codeTheme.value}",
                    style: MyTheme.cardKey.copyWith(letterSpacing: 0.8),
                  ),
                ),
              ),
              onPressed: () async {
                var result = await showThemesDialog(context);
                generateController.codeTheme.value =
                    result ?? generateController.codeTheme.value;
              },
            ),
            SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () {
                generateController.codeURL = generateController.cApiURL +
                    "?font=${generateController.codeFont}&theme=${generateController.codeTheme}";
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
                if (controller.codeURL == "") {
                  return Container(
                    height: 50,
                  );
                } else {
                  return GestureDetector(
                    onTap: () =>
                        Get.to(() => ImageViewer(imgURL: generateController.codeURL)),
                    child: Container(
                      height: Responsive.isMobile(context) ? 300 : 450,
                      width: Responsive.isMobile(context) ? 500 : 700,
                      child: CachedNetworkImage(
                        imageUrl: generateController.codeURL,
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

class FontPickerDialog extends StatefulWidget {
  const FontPickerDialog({Key? key}) : super(key: key);

  @override
  FontPickerDialogState createState() => FontPickerDialogState();
}

class FontPickerDialogState extends State<FontPickerDialog> {
  List<FontgenFonts> fonts = [];
  var fontIndex = 0.obs;

  var fontsController = Get.find<FontgenFontsController>();
  var generateController = Get.find<GenerateController>();

  @override
  void initState() {
    fonts = fontsController.fonts;
    fonts.sort((a, b) => a.family.compareTo(b.family));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
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
        content: Container(
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
                  itemCount: fonts.length,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      fontIndex.value = index;
                    },
                    child: Obx(() => Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: fontIndex.value == index
                                ? Colors.black.withOpacity(0.05)
                                : Colors.transparent,
                            border: Border(
                              bottom:
                                  BorderSide(color: Colors.black12, width: 1),
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
                                        color: HSLColor.fromColor(
                                                fontsController.colorMap[
                                                    fonts[index].type]!)
                                            .withLightness(0.73)
                                            .toColor(),
                                        borderRadius:
                                            MyTheme.borderRadius / 1.5,
                                      ),
                                      child: Image.asset(
                                        fontsController
                                            .getImgSrc(fonts[index].type),
                                        color: HSLColor.fromColor(
                                                fontsController.colorMap[
                                                    fonts[index].type]!)
                                            .withLightness(0.85)
                                            .toColor(),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      fonts[index].family,
                                      style: MyTheme.cardKey,
                                    ),
                                  ],
                                ),
                                Text(fonts[index].weights.length.toString(),
                                    style: MyTheme.cardKey.copyWith(
                                        color: fonts[index].isPaid
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
            ],
          ),
        ),
        actions: [
          OutlinedButton(
              onPressed: () {
                Get.back(result: null);
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
                Get.back(result: fonts[fontIndex.value].family);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "SELECT",
                  style: MyTheme.cardKey.copyWith(fontSize: 15),
                ),
              ))
        ],
      ),
    );
  }
}

class ThemePickerDialog extends StatefulWidget {
  const ThemePickerDialog({Key? key}) : super(key: key);

  @override
  _ThemePickerDialogState createState() => _ThemePickerDialogState();
}

class _ThemePickerDialogState extends State<ThemePickerDialog> {
  List<String> themes = [];
  var themeIndex = 0.obs;

  var fontsController = Get.find<FontgenFontsController>();
  var generateController = Get.find<GenerateController>();

  @override
  void initState() {
    themes = fontsController.themes;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        elevation: 1,
        insetPadding: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
            borderRadius: MyTheme.borderRadius,
            side: BorderSide(color: Colors.black12, width: 1)),
        actionsPadding: MyTheme.cardPadding,
        title: Text(
          "Theme Selector",
          style: MyTheme.cardKey,
        ),
        content: Container(
          width: Responsive.isMobile(context)
              ? MediaQuery.of(context).size.width / 1.3
              : MediaQuery.of(context).size.width / 2.2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Select Code Theme",
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
                  itemCount: themes.length,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      themeIndex.value = index;
                    },
                    child: Obx(() => Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: themeIndex.value == index
                                ? Colors.black.withOpacity(0.05)
                                : Colors.transparent,
                            border: Border(
                              bottom:
                                  BorderSide(color: Colors.black12, width: 1),
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
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      themes[index],
                                      style: MyTheme.cardKey,
                                    ),
                                  ],
                                ),
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
            ],
          ),
        ),
        actions: [
          OutlinedButton(
              onPressed: () {
                Get.back(result: null);
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
                Get.back(result: themes[themeIndex.value]);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "SELECT",
                  style: MyTheme.cardKey.copyWith(fontSize: 15),
                ),
              ))
        ],
      ),
    );
  }
}
