import 'package:flutter/material.dart';
import 'package:fontina/components/font_details_card.dart';
import 'package:fontina/dependencies/fonts_dep.dart';
import 'package:fontina/util/responsive.dart';
import 'package:fontina/util/theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FontDetailsScreen extends StatelessWidget {
  const FontDetailsScreen({Key? key, required this.font}) : super(key: key);

  final FontgenFonts font;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back_ios_rounded),
                iconSize: 30,
                color: MyTheme.primaryColorLight,
              ),
        ),
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(font.family,
              style: GoogleFonts.spaceGrotesk().copyWith(
                  fontSize: 27,
                  color: MyTheme.primaryColorLight,
                  fontWeight: FontWeight.w700),
                  ),
        ),
                elevation: 1,
                backgroundColor: context.theme.scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FontDetailsCard(font: font),
            ],
          ),
        ),
      ),
    ));
  }
}
