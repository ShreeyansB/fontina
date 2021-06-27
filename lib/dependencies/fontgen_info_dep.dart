import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class FontgenInfo {
  String name = "Fontgen";
  String author = "ShreeyansB";
  String repo = "https://github.com/ShreeyansB/fontgen";
  String version = "Not found";
  int numFonts = -1;
  List<String> types = [];
  String lastUpdated =
      dateFormat.format(DateTime.parse("2021-06-26T10:55:18.169Z"));

  static DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  void updateFromJSON(Map<String, dynamic> json) {
    name = json['name'];
    author = json['author'];
    repo = json['repo'];
    version = json['version'];
    numFonts = json['numFonts'];
    types = json['types'].cast<String>();
    lastUpdated = dateFormat.format(DateTime.parse(json['lastUpdated']));
  }
}

class FontgenInfoController extends GetxController {
  var fontgenInfo = FontgenInfo().obs;
  var url = Uri.parse("https://fontgen-sb.herokuapp.com/");
  var conn = false.obs;

  void updateAPI() async {
    try {
      var response = await http.get(url);
      print("Fontgen Info: " + response.statusCode.toString());
      if (response.statusCode == 200) {
        conn.value = true;

        var json = jsonDecode(response.body);
        fontgenInfo.value.updateFromJSON(json);
      } else {
        conn.value = false;
      }
    } catch (e) {
      conn.value = false;

      print(e);
    }
  }
}
