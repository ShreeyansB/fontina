import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fontina/dependencies/fontgen_info_dep.dart';
import 'package:fontina/dependencies/fonts_dep.dart';
import 'package:fontina/dependencies/search_filter_dep.dart';
import 'package:fontina/dependencies/search_textfield_dep.dart';
import 'package:fontina/dependencies/storage_dep.dart';
import 'package:fontina/screens/base_screen.dart';
import 'package:get/get.dart';
import 'package:fontina/util/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dependencies/side_navigation_dep.dart';
import 'package:universal_html/html.dart';
import 'dart:io' as Plat show Platform;

void main() {
  Get.put(SideMenuController());
  Get.put(FontgenInfoController());
  Get.put(FontgenFontsController());
  Get.put(SearchTextfieldController());
  Get.put(SearchFilterController());
  Get.put(StorageController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<FontgenInfoController>().updateAPI();
    Get.find<StorageController>().initStorage();
    final loader = document.getElementsByClassName("lds-ring");
    if (loader.isNotEmpty) {
      loader.first.remove();
    }
    if (!kIsWeb) {
      if (Plat.Platform.isAndroid || Plat.Platform.isIOS) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Colors.white,
            statusBarBrightness: Brightness.light,
            systemNavigationBarIconBrightness: Brightness.light));
      }
    }
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
            Theme.of(context)
                .textTheme
                .apply(bodyColor: MyTheme.textColorLight),
          ),
          tooltipTheme: TooltipThemeData(
              decoration: BoxDecoration(
            color: Colors.transparent,
          ))),
      home: BaseScreen(),
    );
  }
}
