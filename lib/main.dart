import 'package:flutter/material.dart';
import 'package:fontina/screens/home_screen.dart';
import 'package:get/get.dart';
import 'package:fontina/util/theme.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'fontina',
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: MyTheme.bgColorLight,
          primaryColor: MyTheme.primaryColorLight,
          accentColor: MyTheme.primaryColorLight,
          canvasColor: MyTheme.bgColorLight,
          textTheme: GoogleFonts.karlaTextTheme(Theme.of(context)
              .textTheme
              .apply(bodyColor: MyTheme.textColorLight))),
              home: HomeScreen(),
    );
  }
}
