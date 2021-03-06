import 'package:flutter/material.dart';
import 'package:fontina/screens/details_screen.dart';
import 'package:fontina/screens/fav_screen.dart';
import 'package:fontina/screens/gen_screen.dart';
import 'package:fontina/screens/home_screen.dart';
import 'package:fontina/screens/search_screen.dart';
import 'package:get/get.dart';

class SideMenuNavigation {
  var index = 0.obs;
}

class SideMenuController extends GetxController {
  SideMenuNavigation nav = SideMenuNavigation();
  List<Widget> views = [
    HomeScreen(),
    SearchScreen(),
    FavScreen(),
    GenScreen(),
    DetailsScreen(),
  ];

  var isFontLoaded = false.obs;


  void switchScreen(int i) {
    nav.index.value = i;
  }

}
