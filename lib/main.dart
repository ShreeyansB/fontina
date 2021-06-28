import 'package:flutter/material.dart';
import 'package:fontina/dependencies/fontgen_info_dep.dart';
import 'package:fontina/dependencies/fonts_dep.dart';
import 'package:fontina/screens/base_screen.dart';
import 'package:get/get.dart';
import 'package:fontina/util/theme.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dependencies/side_navigation_dep.dart';

void main() {
  Get.put(SideMenuController());
  Get.put(FontgenInfoController());
  Get.put(FontgenFontsController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<FontgenInfoController>().updateAPI();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'fontina',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: MyTheme.bgColorLight,
        primaryColor: MyTheme.primaryColorLight,
        accentColor: MyTheme.primaryColorLight,
        canvasColor: MyTheme.bgColorLight,
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.pink, accentColor: Colors.pink),
        textTheme: GoogleFonts.karlaTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: MyTheme.textColorLight),
        ),
      ),
      home: BaseScreen(),
    );
  }
}
