import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fontina/components/home_cards.dart';
import 'package:fontina/components/image_carousel.dart';
import 'package:fontina/dependencies/fonts_dep.dart';
import 'package:fontina/dependencies/side_navigation_dep.dart';
import 'package:fontina/util/responsive.dart';
import 'package:fontina/util/theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<FontgenFonts> carFonts = [];
  var fontsController = Get.find<FontgenFontsController>();
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    final random = Random();
    List<int> index = [];
    while (index.length < 3) {
      int x = random.nextInt(fontsController.fonts.length);
      if (!index.contains(x)) {
        index.add(x);
      }
    }
    index.forEach((i) {
      carFonts.add(fontsController.fonts[i]);
    });
  }

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  int getCrossCount(BuildContext context, Size size) {
    if (Responsive.isDesktop(context)) {
      if (size.width > 1200) {
        return 4;
      } else {
        return 3;
      }
    } else {
      if (size.width > 950) {
        return 3;
      } else if (size.width > 430) {
        return 2;
      } else {
        return 1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
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
                      Icons.vertical_split_sharp,
                      color: MyTheme.primaryColorLight,
                      size: 40,
                    )),
              if (Responsive.isMobile(context))
                SizedBox(
                  width: 20,
                ),
              Text("Home",
                  style: GoogleFonts.spaceGrotesk(
                      color: MyTheme.primaryColorLight,
                      fontSize: 40,
                      fontWeight: FontWeight.w500)),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          if (Responsive.isDesktop(context))
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: size.width > 1370 ? 360 : 360,
                    width: size.width > 1370 ? 700 : 500,
                    child: HomeImageCarousel(fonts: carFonts)),
                SizedBox(
                  width: 40,
                ),
                Expanded(
                    child: HeaderText(
                  fontSize: 60,
                )),
              ],
            ),
          if (!Responsive.isDesktop(context))
            HeaderText(
              fontSize: 50,
            ),
          if (!Responsive.isDesktop(context))
            SizedBox(
              height: 20,
            ),
          if (!Responsive.isDesktop(context))
            SizedBox(
              height: Responsive.isMobile(context) ? 260 : 300,
              //width: 800,
              child: HomeImageCarousel(fonts: carFonts),
            ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Categories",
            style: MyTheme.cardKey.copyWith(fontSize: 23),
          ),
          SizedBox(
            height: 20,
          ),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: getCrossCount(context, size),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 2),
            itemCount: fontsController.types.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return CategoryCard(type: fontsController.types[index]);
            },
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Recently Added",
            style: MyTheme.cardKey.copyWith(fontSize: 23),
          ),
          SizedBox(
            height: 20,
          ),

          SizedBox(height: 50,)
        ],
      ),
    ));
  }
}

class HeaderText extends StatelessWidget {
  const HeaderText({
    Key? key,
    required this.fontSize,
  }) : super(key: key);

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 5,
      text: TextSpan(
          text: "Welcome to ",
          style: GoogleFonts.fredokaOne()
              .copyWith(fontSize: fontSize, color: MyTheme.textColorSecondary),
          children: [
            TextSpan(
              text: "fontina!",
              style: GoogleFonts.fredokaOne().copyWith(
                  fontSize: fontSize, color: MyTheme.primaryColorLight),
            ),
            TextSpan(
              text: "\nA curated collection of ",
              style: GoogleFonts.fredokaOne().copyWith(
                  fontSize: fontSize, color: MyTheme.textColorSecondary),
            ),
            TextSpan(
              text: "fonts.",
              style: GoogleFonts.fredokaOne().copyWith(
                  fontSize: fontSize, color: MyTheme.primaryColorLight),
            ),
          ]),
    );
  }
}
