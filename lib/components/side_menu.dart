import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fontina/util/theme.dart';
import 'package:get/get.dart';

var selected = 0.obs;
var overflow = false.obs;

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override

  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              child: Image.asset(
                "assets/images/logo.png",
                width: 65,
              ),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
            ),
            DrawerTile(
              title: "Home",
              svgSrc: "assets/svg/home.svg",
              onPress: () => selected.value = 0,
              index: 0,
              
            ),
            DrawerTile(
              title: "Search",
              svgSrc: "assets/svg/search.svg",
              onPress: () => selected.value = 1,
              index: 1,
              
            ),
            DrawerTile(
              title: "Favorite",
              svgSrc: "assets/svg/fav.svg",
              onPress: () => selected.value = 2,
              index: 2,
              
            ),
            DrawerTile(
              title: "Generate",
              svgSrc: "assets/svg/gen.svg",
              onPress: () => selected.value = 3,
              index: 3,
              
            ),
            DrawerTile(
              title: "Details",
              svgSrc: "assets/svg/details.svg",
              onPress: () => selected.value = 4,
              index: 4,
              
            ),
            DrawerTile(
              title: "Settings",
              svgSrc: "assets/svg/settings.svg",
              onPress: () => selected.value = 5,
              index: 5,
              
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.onPress,
    required this.index,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback onPress;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          width: 150,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(
              vertical: 3,
              horizontal: 20,
            ),
            onTap: onPress,
            horizontalTitleGap: 0,
            leading: SvgPicture.asset(
              svgSrc,
              color: selected.value == index
                  ? MyTheme.primaryColorLight
                  : MyTheme.textColorLight,
              height: 23,
            ),
            title: Text(
              title,
              maxLines: 1,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: selected.value == index
                      ? MyTheme.primaryColorLight
                      : MyTheme.textColorLight,
                  fontSize: 17.0),
            ),
          ),
        ));
  }
}
