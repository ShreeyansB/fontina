import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:fontina/dependencies/gen_dep.dart';
import 'package:fontina/util/responsive.dart';
import 'package:fontina/util/theme.dart';
import 'package:get/get.dart';

class ParaColorPicker extends StatefulWidget {
  const ParaColorPicker({Key? key}) : super(key: key);

  @override
  _ParaColorPickerState createState() => _ParaColorPickerState();
}

class _ParaColorPickerState extends State<ParaColorPicker> {
  var generateController = Get.find<GenerateController>();

  Future showColorPicker(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return MyColorPicker();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "FG Color :  ",
                style: MyTheme.cardKey,
              ),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () async {
                  var result = await showColorPicker(context);
                  generateController.paraFGColor.value =
                      result ?? generateController.paraFGColor.value;
                  print(generateController.paraFGColor);
                },
                child: Obx(() => ColorIndicator(
                      height: 34,
                      width: 34,
                      borderRadius: 8,
                      hasBorder: true,
                      borderColor: Colors.black12,
                      color: generateController.paraFGColor.value,
                    )),
              )
            ],
          ),
          Row(
            children: [
              Text(
                "BG Color :  ",
                style: MyTheme.cardKey,
              ),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () async {
                  var result = await showColorPicker(context);
                  generateController.paraBGColor.value =
                      result ?? generateController.paraBGColor.value;
                  print(generateController.paraBGColor);
                },
                child: Obx(() => ColorIndicator(
                      height: 34,
                      width: 34,
                      borderRadius: 8,
                      hasBorder: true,
                      borderColor: Colors.black12,
                      color: generateController.paraBGColor.value,
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}

class MyColorPicker extends StatefulWidget {
  const MyColorPicker({Key? key}) : super(key: key);

  @override
  _MyColorPickerState createState() => _MyColorPickerState();
}

class _MyColorPickerState extends State<MyColorPicker> {
  Color color = Colors.red;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AlertDialog(
      elevation: 1,
      insetPadding: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
          borderRadius: MyTheme.borderRadius,
          side: BorderSide(color: Colors.black12, width: 1)),
      actionsPadding: MyTheme.cardPadding,
      title: Text(
        "Color Picker",
        style: MyTheme.cardKey,
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
              Get.back(result: color);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "SELECT",
                style: MyTheme.cardKey.copyWith(fontSize: 15),
              ),
            ))
      ],
      content: Container(
        width:
            Responsive.isMobile(context) ? size.width / 1.3 : size.width / 2.3,
        height: size.height / 1.3,
        child: ColorPicker(
          color: color,
          spacing: 10,
          runSpacing: 10,
          wheelDiameter: 300,
          wheelWidth: 24,
          columnSpacing: 40,
          showMaterialName: true,
          showColorName: true,
          showColorCode: true,
          pickersEnabled: const <ColorPickerType, bool>{
            ColorPickerType.both: false,
            ColorPickerType.primary: true,
            ColorPickerType.accent: true,
            ColorPickerType.bw: false,
            ColorPickerType.custom: false,
            ColorPickerType.wheel: true,
          },
          width: 50,
          height: 50,
          borderRadius: 10,
          onColorChanged: (value) {
            setState(() {
              color = value;
            });
          },
        ),
      ),
    );
  }
}
