import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fontina/components/fonts_info_chart.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

FontgenFonts fontgenFontsFromJson(String str) =>
    FontgenFonts.fromJson(json.decode(str));

class FontgenFonts {
  FontgenFonts({
    required this.isPaid,
    required this.family,
    required this.url,
    required this.foundry,
    required this.showcaseImg,
    required this.weights,
    required this.type,
    required this.dateAdded,
    required this.info,
  });

  bool isPaid;
  String family;
  String url;
  String foundry;
  int showcaseImg;
  List<String> weights;
  String type;
  DateTime dateAdded;
  String info;

  factory FontgenFonts.fromJson(Map<String, dynamic> json) {
    return FontgenFonts(
        isPaid: json["isPaid"],
        family: json["family"],
        url: json["url"],
        foundry: json["foundry"],
        showcaseImg: json["showcaseImg"],
        weights: List<String>.from(json["weights"].map((x) => x)),
        type: json["type"],
        dateAdded: DateTime.parse(json["dateAdded"]),
        info: json["info"] ?? "");
  }
}

class FontgenFontsController extends GetxController {
  RxList<FontgenFonts> fonts = RxList<FontgenFonts>.empty(growable: true);
  var url = Uri.parse("https://fontgen-sb.herokuapp.com/list-fonts");
  List<String> types = [];
  List<Color> colors = [
    Color(0xffa6dc8c),
    Color(0xff908cdc),
    Color(0xffdca58c),
    Color(0xff8cc6dc),
    Color(0xffdcd48c),
    Color(0xffdc8cd3),
    Color(0xffdc8c93),
    Color(0xff81ceb8),
  ];
  List<int> numOfFamilyFiles = [];

  Map<String, Color> colorMap = {
    "other": Color(0xffef7a7a),
  };

  Future<bool> getFonts() async {
    try {
      var response = await http.get(url);
      print("Fontgen Info: " + response.statusCode.toString());
      if (response.statusCode == 200) {
        List json = jsonDecode(response.body);
        json.forEach((element) {
          fonts.add(FontgenFonts.fromJson(element));
        });
        fonts.forEach((element) {
          if (!types.contains(element.type)) {
            types.add(element.type);
          }
        });
        types.forEach((element) {
          numOfFamilyFiles.add(0);
        });
        fonts.forEach((font) {
          for (var i = 0; i < types.length; i++) {
            if (font.type == types[i]) {
              numOfFamilyFiles[i] += font.weights.length;
            }
          }
        });
        colorMap = Map.fromIterable(
          types,
          key: (item) => item,
          value: (item) => colors[types.indexOf(item)],
        );
        return true;
      } else {
        return false;
      }
    } catch (e, stacktrace) {
      print('Exception: ' + e.toString());
      print('Stacktrace: ' + stacktrace.toString());
      return false;
    }
  }

  List<PieChartSectionData> getPieChartSections() {
    List<PieChartSectionData> data = [];
    List<int> numOfFonts = [];
    types.forEach((element) {
      numOfFonts.add(0);
    });
    fonts.forEach((font) {
      types.forEach((type) {
        if (font.type == type) {
          numOfFonts[types.indexOf(type)]++;
        }
      });
    });
    for (int i = 0; i < types.length; i++) {
      data.add(
        PieChartSectionData(
          color: colors[i],
          value: numOfFonts[i].toDouble(),
          title: types[0],
          showTitle: false,
          radius: 20.0,
        ),
      );
    }
    return data;
  }

  List<Widget> getPieChartIndicator() {
    List<Widget> widgets = [];

    List<int> numOfFonts = [];
    types.forEach((element) {
      numOfFonts.add(0);
    });
    fonts.forEach((font) {
      types.forEach((type) {
        if (font.type == type) {
          numOfFonts[types.indexOf(type)]++;
        }
      });
    });

    for (var i = 0; i < types.length; i++) {
      widgets.add(ChartIndicator(
          color: colors[i],
          imgSrc: getImgSrc(types[i]),
          title: types[i],
          amount: numOfFonts[i].toString()));
    }
    return widgets;
  }

  String getImgSrc(data) {
    if (data == "Serif") {
      return "assets/svg/serif_ico.png";
    } else if (data == "Sans Serif") {
      return "assets/svg/sans_serif_ico.png";
    } else if (data == "Handwriting") {
      return "assets/svg/hand_ico.png";
    } else if (data == "Monospace") {
      return "assets/svg/mono_icon.png";
    } else if (data == "Slab Serif") {
      return "assets/svg/slab_serif_ico.png";
    } else if (data == "Display") {
      return "assets/svg/display_ico.png";
    } else {
      return "assets/svg/other_ico.png";
    }
  }
}
