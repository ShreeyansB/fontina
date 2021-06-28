import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class FontgenInfo {
  String name;
  String author;
  String repo;
  String version;
  int numFonts;
  List<String> types;
  String lastUpdated;

  FontgenInfo(
      {required this.name,
      required this.author,
      required this.repo,
      required this.version,
      required this.numFonts,
      required this.types,
      required this.lastUpdated});

  static DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  static FontgenInfo updateFromJSON(Map<String, dynamic> json) {
    return FontgenInfo(
        name: json['name'],
        author: json['author'],
        repo: json['repo'],
        version: json['version'],
        numFonts: json['numFonts'],
        types: json['types'].cast<String>(),
        lastUpdated: dateFormat.format(DateTime.parse(json['lastUpdated'])));
  }
}

class FontgenInfoController extends GetxController {
  var fontgenInfo = FontgenInfo(
          name: "Fontgen",
          author: "ShreeyansB",
          repo: "https://github.com/ShreeyansB/fontgen",
          version: "Not Available",
          numFonts: -1,
          types: [],
          lastUpdated: FontgenInfo.dateFormat
              .format(DateTime.parse("2021-06-26T10:55:18.169Z")))
      .obs;
  var url = Uri.parse("https://fontgen-sb.herokuapp.com/");
  var conn = false.obs;

  void updateAPI() async {
    try {
      var response = await http.get(url);
      print("Fontgen Info: " + response.statusCode.toString());
      if (response.statusCode == 200) {
        conn.value = true;

        var json = jsonDecode(response.body);
        fontgenInfo.value = FontgenInfo.updateFromJSON(json);
      } else {
        conn.value = false;
      }
    } catch (e) {
      conn.value = false;
      print(e);
    }
    update();
  }
}
