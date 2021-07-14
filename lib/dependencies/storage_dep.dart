import 'dart:convert';

import 'package:fontina/dependencies/fontgen_info_dep.dart';
import 'package:fontina/dependencies/fonts_dep.dart';
import "package:get/get.dart";
import 'package:localstorage/localstorage.dart';

class StorageController extends GetxController {
  List favorites = [];
  final LocalStorage storage = LocalStorage('storage');

  void initStorage() async {
    await storage.ready;
    if (storage.getItem('fav') != []) {
      favorites = storage.getItem('fav') ?? [];
    }
  }

  bool checkFont(FontgenFonts font) {
    for (var fav in favorites) {
      if (fav["family"] == font.family && fav["url"] == font.url) {
        return true;
      }
    }
    return false;
  }

  void saveToStorage() {
    storage.setItem('fav', favorites);
    print("DATA: " + storage.getItem('fav').toString());
  }

  void addFavorite(FontgenFonts font) {
    favorites.add({"family": font.family, "url": font.url});
    saveToStorage();
  }

  void removeFavorite(FontgenFonts font) {
    for (var fav in favorites) {
      if (fav["family"] == font.family && fav["url"] == font.url) {
        favorites.remove(fav);
        break;
      }
    }
    saveToStorage();
  }

  dynamic myEncode(dynamic item) {
    if (item is DateTime) {
      return item.toIso8601String();
    }
    return item;
  }

  Future<bool> saveFonts() async {
    print('Caching fonts...');
    await storage.setItem(
        'version', Get.find<FontgenInfoController>().fontgenInfo.value.version);
    List<Map<String, dynamic>> data = [];
    Get.find<FontgenFontsController>().fonts.forEach((element) {
      data.add(element.toJson());
    });
    await storage.setItem('fonts.json', jsonEncode(data, toEncodable: myEncode));
    return true;
  }
}
