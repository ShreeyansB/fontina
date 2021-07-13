import 'package:fontina/dependencies/fonts_dep.dart';
import "package:get/get.dart";
import 'package:localstorage/localstorage.dart';

class StorageController extends GetxController {
  List favorites = [];
  final LocalStorage storage = LocalStorage('storage');
  
  void initStorage() async {
    await storage.ready;
    if(storage.getItem('fav') != []) {
      favorites = storage.getItem('fav') ?? [];
    }
  }

  bool checkFont(FontgenFonts font) {
    for (var fav in favorites) {
      if(fav["family"] == font.family && fav["url"] == font.url) {
        return true;
      }
    }
    return false;
  }

  void saveToStorage() {
    storage.setItem('fav', favorites);
    print("DATA: "+ storage.getItem('fav').toString());
  }

  void addFavorite(FontgenFonts font) {
    favorites.add({"family": font.family, "url": font.url});
    saveToStorage();
  }

  void removeFavorite(FontgenFonts font) {
    for (var fav in favorites) {
      if(fav["family"] == font.family && fav["url"] == font.url) {
        favorites.remove(fav);
      }
    }
    saveToStorage();
  }

}