import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static const Color primaryColorLight = Color(0xffC14e80);
  static const Color bgColorLight = Color(0xfffffefe);
  static const Color textColorLight = Color(0xff474054);
  static const Color textColorSecondary = Color(0xff6d6380);

  static BorderRadius borderRadius = BorderRadius.circular(12.0);
  static EdgeInsets cardPadding =
      EdgeInsets.symmetric(horizontal: 25.0, vertical: 22.0);
  static const double defaultPadding = 25.0;

  static TextStyle headingSec = TextStyle(
      fontSize: 17.0,
      fontWeight: FontWeight.w500,
      color: MyTheme.textColorSecondary);

  static TextStyle cardKey = TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: MyTheme.textColorSecondary);
  static TextStyle cardValue = GoogleFonts.spaceGrotesk(
      fontSize: 18.0,
      fontWeight: FontWeight.w700,
      color: MyTheme.textColorLight);

  static TextStyle largeNumber = GoogleFonts.spaceGrotesk(
      fontSize: 40.0,
      fontWeight: FontWeight.w800,
      color: MyTheme.textColorSecondary);

}
