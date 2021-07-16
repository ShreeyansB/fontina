import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fontina/dependencies/side_navigation_dep.dart';
import 'package:fontina/util/responsive.dart';
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
      elevation: 2.4,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: 30.0),
          child: Column(
            children: [
              Container(
                margin: Responsive.isTablet(context) ? EdgeInsets.only(top: 20) : EdgeInsets.all(0),
                width: Responsive.isTablet(context) ? 105 : 170,
                child: Responsive.isTablet(context) ? Image.asset(
                  "assets/images/logo_small.png",
                ) : Image.asset(
                  "assets/images/logo_full.png",
                ),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
              ),
              DrawerTile(
                title: "Home",
                svgSrc: "assets/svg/home.svg",
                onPress: () {
                  Get.find<SideMenuController>().switchScreen(0);
                  if (Responsive.isMobile(context)) {
                    Get.back();
                  }
                },
                index: 0,
              ),
              DrawerTile(
                title: "Search",
                svgSrc: "assets/svg/search.svg",
                onPress: () {
                  Get.find<SideMenuController>().switchScreen(1);
                  if (Responsive.isMobile(context)) {
                    Get.back();
                  }
                },
                index: 1,
              ),
              DrawerTile(
                title: "Favorite",
                svgSrc: "assets/svg/fav.svg",
                onPress: () {
                  Get.find<SideMenuController>().switchScreen(2);
                  if (Responsive.isMobile(context)) {
                    Get.back();
                  }
                },
                index: 2,
              ),
              DrawerTile(
                title: "Generate",
                svgSrc: "assets/svg/gen.svg",
                height: 24,
                onPress: () {
                  Get.find<SideMenuController>().switchScreen(3);
                  if (Responsive.isMobile(context)) {
                    Get.back();
                  }
                },
                index: 3,
              ),
              DrawerTile(
                title: "Details",
                svgSrc: "assets/svg/details.svg",
                height: 22,
                onPress: () {
                  Get.find<SideMenuController>().switchScreen(4);
                  if (Responsive.isMobile(context)) {
                    Get.back();
                  }
                },
                index: 4,
              ),
              DrawerTile(
                title: "Settings",
                svgSrc: "assets/svg/settings.svg",
                height: 25,
                onPress: () {
                  Get.find<SideMenuController>().switchScreen(5);
                  if (Responsive.isMobile(context)) {
                    Get.back();
                  }
                },
                index: 5,
              ),
            ],
          ),
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
    this.height = 23
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback onPress;
  final int index;
  final double? height;

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context) || Responsive.isMobile(context)) {
      return Container(
          width: 150,
          child: Obx(() => ListTile(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 20,
                ),
                onTap: onPress,
                horizontalTitleGap: 0,
                leading: SvgPicture.asset(
                  svgSrc,
                  color: Get.find<SideMenuController>().nav.index.value == index
                      ? MyTheme.primaryColorLight
                      : MyTheme.textColorLight,
                  height: height,
                ),
                title: Text(
                  title,
                  maxLines: 1,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Get.find<SideMenuController>().nav.index.value ==
                              index
                          ? MyTheme.primaryColorLight
                          : MyTheme.textColorLight,
                      fontSize: 17.0),
                ),
              )));
    } else {
      return Container(
          width: 150,
          child: Obx(() => ListTile(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 20,
                ),
                onTap: onPress,
                horizontalTitleGap: 0,
                title: SvgPicture.asset(
                  svgSrc,
                  color: Get.find<SideMenuController>().nav.index.value == index
                      ? MyTheme.primaryColorLight
                      : MyTheme.textColorLight,
                  height: height,
                ),
              )));
    }
  }
}

// ListTile(
//             contentPadding: EdgeInsets.symmetric(
//               vertical: 3,
//               horizontal: 20,
//             ),
//             onTap: onPress,
//             horizontalTitleGap: 0,
//             leading: SvgPicture.asset(
//               svgSrc,
//               color: selected.value == index
//                   ? MyTheme.primaryColorLight
//                   : MyTheme.textColorLight,
//               height: 23,
//             ),
//             title: Text(
//               title,
//               maxLines: 1,
//               style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   color: selected.value == index
//                       ? MyTheme.primaryColorLight
//                       : MyTheme.textColorLight,
//                   fontSize: 17.0),
//             ),
//           ),