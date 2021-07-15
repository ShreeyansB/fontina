import 'package:flutter/material.dart';
import 'package:fontina/screens/details_screen.dart';
import 'package:fontina/screens/fav_screen.dart';
import 'package:fontina/screens/gen_screen.dart';
import 'package:fontina/screens/home_screen.dart';
import 'package:fontina/screens/search_screen.dart';
import 'package:fontina/screens/settings_screen.dart';
import 'package:get/get.dart';

class SideMenuNavigation {
  var index = 3.obs;
}

class SideMenuController extends GetxController {
  SideMenuNavigation nav = SideMenuNavigation();
  List<Widget> views = [
    HomeScreen(),
    SearchScreen(),
    FavScreen(),
    GenScreen(),
    DetailsScreen(),
    SettingsScreen()
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void switchScreen(int i) {
    nav.index.value = i;
  }

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }
}
