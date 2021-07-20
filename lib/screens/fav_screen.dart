import 'package:flutter/material.dart';
import 'package:fontina/components/fonts_search.dart';
import 'package:fontina/dependencies/search_textfield_dep.dart';
import 'package:fontina/util/responsive.dart';
import 'package:fontina/util/theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_debounce_it/just_debounce_it.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  Future<bool> loadSearchTable() async {
    return Future.delayed(Duration(milliseconds: 1200), () {
      return true;
    });
  }

  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Favorites",
                style: GoogleFonts.spaceGrotesk(
                    color: MyTheme.primaryColorLight,
                    fontSize: 40,
                    fontWeight: FontWeight.w500)),
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
            FutureBuilder(
              future: loadSearchTable(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return FontsSearchTable(
                    isFav: true,
                  );
                }
                return Container(
                  width: double.infinity,
                  height: 300,
                  child: Center(
                      child: SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(
                      color: Colors.black12,
                      strokeWidth: 2,
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
