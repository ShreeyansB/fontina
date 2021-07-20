import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fontina/components/side_menu.dart';
import 'package:fontina/dependencies/fontgen_info_dep.dart';
import 'package:fontina/dependencies/side_navigation_dep.dart';
import 'package:fontina/util/responsive.dart';
import 'package:fontina/util/theme.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  DateTime? currentBackPressTime;

  @override
  void initState() {
    Get.find<FontgenInfoController>().updateAPI();
    super.initState();
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.snackbar("Do you want to exit?", "Press back again to exit");
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.bgColorLight,
      drawer: SideMenu(),
      bottomNavigationBar: Responsive.isMobile(context) ? SalomonBar() : null,
      body: WillPopScope(
        onWillPop: onWillPop,
        child: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!Responsive.isMobile(context)) Expanded(child: SideMenu()),
              Expanded(
                  flex: 5,
                  child: Container(
                    padding: Responsive.isMobile(context)
                        ? EdgeInsets.only(top: 18, left: 18, right: 18)
                        : EdgeInsets.only(top: 37, left: 37, right: 37),
                    child: Obx(() => AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          reverseDuration: Duration(milliseconds: 150),
                          switchInCurve: Curves.easeOutBack,
                          switchOutCurve: Curves.easeIn,
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return ScaleTransition(
                              child: child,
                              scale: animation,
                            );
                          },
                          child: Get.find<SideMenuController>().views[
                              Get.find<SideMenuController>().nav.index.value],
                        )),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class SalomonBar extends StatelessWidget {
  const SalomonBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (Get.find<SideMenuController>().isFontLoaded.value)
        return Container(
          decoration: BoxDecoration(
              color: MyTheme.bgColorLight,
              border: Border(top: BorderSide(color: Colors.black12, width: 1))),
          child: Obx(
            () => SalomonBottomBar(
              currentIndex: Get.find<SideMenuController>().nav.index.value,
              onTap: (i) => Get.find<SideMenuController>().switchScreen(i),
              unselectedItemColor: MyTheme.textColorSecondary,
              selectedItemColor: MyTheme.primaryColorLight,
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 18),
              items: [
                SalomonBottomBarItem(
                  icon: SvgPicture.asset(
                    "assets/svg/home.svg",
                    color: Get.find<SideMenuController>().nav.index.value == 0
                        ? MyTheme.primaryColorLight
                        : MyTheme.textColorLight,
                  ),
                  title: Text(
                    "Home",
                    style: TextStyle(fontSize: 16, letterSpacing: 0.8),
                  ),
                ),
                SalomonBottomBarItem(
                  icon: SvgPicture.asset(
                    "assets/svg/search.svg",
                    color: Get.find<SideMenuController>().nav.index.value == 1
                        ? MyTheme.primaryColorLight
                        : MyTheme.textColorLight,
                  ),
                  title: Text(
                    "Search",
                    style: TextStyle(fontSize: 16, letterSpacing: 0.8),
                  ),
                ),
                SalomonBottomBarItem(
                  icon: SvgPicture.asset(
                    "assets/svg/fav.svg",
                    color: Get.find<SideMenuController>().nav.index.value == 2
                        ? MyTheme.primaryColorLight
                        : MyTheme.textColorLight,
                  ),
                  title: Text(
                    "Favourite",
                    style: TextStyle(fontSize: 16, letterSpacing: 0.8),
                  ),
                ),
                SalomonBottomBarItem(
                  icon: SvgPicture.asset(
                    "assets/svg/gen.svg",
                    color: Get.find<SideMenuController>().nav.index.value == 3
                        ? MyTheme.primaryColorLight
                        : MyTheme.textColorLight,
                  ),
                  title: Text(
                    "Generate",
                    style: TextStyle(fontSize: 16, letterSpacing: 0.8),
                  ),
                ),
                SalomonBottomBarItem(
                  icon: SvgPicture.asset(
                    "assets/svg/details.svg",
                    color: Get.find<SideMenuController>().nav.index.value == 4
                        ? MyTheme.primaryColorLight
                        : MyTheme.textColorLight,
                  ),
                  title: Text(
                    "Details",
                    style: TextStyle(fontSize: 16, letterSpacing: 0.8),
                  ),
                ),
              ],
            ),
          ),
        );
      else
        return SizedBox();
    });
  }
}

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyTheme.bgColorLight,
        body: Center(
          child: Container(
            padding: EdgeInsets.all(50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.portable_wifi_off_rounded,
                  color: MyTheme.primaryColorLight,
                  size: 50,
                ),
                SizedBox(
                  height: 18,
                ),
                Text(
                  "Could not find cached data.\nInternet connection is needed to fetch data.\nPlease connect to the internet to use this app so that the data can be cached.",
                  style: MyTheme.cardKey,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 25,
                ),
                OutlinedButton(
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      "EXIT",
                      style: MyTheme.cardKey.copyWith(
                          fontSize: 17, color: MyTheme.primaryColorLight),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
