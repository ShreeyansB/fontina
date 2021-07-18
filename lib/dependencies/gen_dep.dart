import 'package:get/get.dart';
import 'package:flutter/material.dart';

class GenerateController extends GetxController {
  var paraFontHead = "AbrilFatface".obs;
  var paraFontSub = "AbrilFatface".obs;
  var paraWeightHead = "400".obs;
  var paraWeightSub = "400".obs;

  var alertFontHead = "AbrilFatface".obs;
  var alertFontSub = "AbrilFatface".obs;
  var alertWeightHead = "400".obs;
  var alertWeightSub = "400".obs;

  var paraFGColor = Colors.pink.shade200.obs;
  var paraBGColor = Colors.purple.shade900.obs;

  var codeFont = "AbrilFatface".obs;
  var codeTheme = "agate".obs;

  String apiURL = "https://fontgen-sb.herokuapp.com/para";
  String paraURL = "";
  String cApiURL = "https://fontgen-sb.herokuapp.com/code";
  String codeURL = "";

  String colorToString(Color color) =>
      color.toString().split('(0xff')[1].split(')')[0];
}
