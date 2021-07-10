import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fontina/components/fonts_search.dart';
import 'package:fontina/dependencies/fonts_dep.dart';
import 'package:fontina/dependencies/search_filter_dep.dart';
import 'package:fontina/dependencies/search_textfield_dep.dart';
import 'package:fontina/dependencies/side_navigation_dep.dart';
import 'package:fontina/screens/font_details_screen.dart';
import 'package:fontina/util/responsive.dart';
import 'package:fontina/util/theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_debounce_it/just_debounce_it.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<bool> loadSearchTable() async {
    return Future.delayed(Duration(milliseconds: 2000), () {
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    var _fontsController = Get.find<FontgenFontsController>();
    // Get.to(() => FontDetailsScreen(font: _fontsController.fonts[14]));
    return SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (Responsive.isMobile(context))
                  IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        Get.find<SideMenuController>().controlMenu();
                      },
                      icon: Icon(
                        Icons.menu,
                        color: MyTheme.primaryColorLight,
                        size: 40,
                      )),
                if (Responsive.isMobile(context))
                  SizedBox(
                    width: 20,
                  ),
                Text("Search",
                    style: GoogleFonts.spaceGrotesk(
                        color: MyTheme.primaryColorLight,
                        fontSize: 40,
                        fontWeight: FontWeight.w500)),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: Responsive.isDesktop(context)
                  ? _size.width / 2.4
                  : double.infinity,
              padding: MyTheme.cardPadding / 1.5,
              decoration: BoxDecoration(
                borderRadius: MyTheme.borderRadius,
                border: Border.all(color: Colors.black12, width: 1.0),
              ),
              child: TextField(
                controller: Get.find<SearchTextfieldController>().controller,
                onChanged: (value) {
                  Debounce.milliseconds(600, () {
                    Get.find<SearchTextfieldController>().update();
                  });
                },
                style: MyTheme.cardKey.copyWith(fontSize: 20),
                autocorrect: false,
                cursorColor: MyTheme.primaryColorLight,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Enter font name",
                  hintStyle: MyTheme.cardKey
                      .copyWith(fontSize: 20, color: Colors.black26),
                  prefixIcon: Icon(
                    Icons.search,
                    color: MyTheme.primaryColorLight,
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Wrap(
              direction: Axis.horizontal,
              runSpacing: 20,
              children: [
                MyPopupMenu(title: 'Family', options: _fontsController.types),
                SizedBox(width: 20,),
                MyPopupMenu(title: 'Weights', options: _fontsController.weights),
                SizedBox(width: 20,),
                MyPopupMenu(title: 'Price', options: ["isPaid", "isFree"]),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            FutureBuilder(
              future: loadSearchTable(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return FontsSearchTable();
                }
                return Container(
                  width: double.infinity,
                  height: 300,
                  child: Center(
                      child: SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(
                      strokeWidth: 4.0,
                    ),
                  )),
                );
              },
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
