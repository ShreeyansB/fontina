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

  String apiURL = "https://fontgen-sb.herokuapp.com/para";
  String paraURL = "";

  String colorToString(Color color) =>
      color.toString().split('(0xff')[1].split(')')[0];
}
