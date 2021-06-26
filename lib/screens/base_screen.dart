import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fontina/components/side_menu.dart';
import 'package:fontina/dependencies/side_navigation_dep.dart';
import 'package:fontina/util/theme.dart';
import 'package:get/get.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  SideMenuController sideMenuController = Get.put(SideMenuController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Row(
        children: [
          Expanded(child: SideMenu()),
          Expanded(
              flex: 5,
              child: Container(
                color: Colors.amber,
                padding: EdgeInsets.all(20.0),
                child: Obx(() => AnimatedSwitcher(
                      duration: Duration(milliseconds: 700),
                      switchInCurve: Curves.easeOutBack,
                      switchOutCurve: Curves.easeIn,
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(child: child, opacity: animation,);
                      },
                      child: Get.find<SideMenuController>().views[
                          Get.find<SideMenuController>().nav.index.value],
                    )),
              )),
        ],
      )),
    );
  }
}
