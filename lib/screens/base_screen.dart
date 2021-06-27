import 'package:flutter/material.dart';
import 'package:fontina/components/side_menu.dart';
import 'package:fontina/dependencies/side_navigation_dep.dart';
import 'package:get/get.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: SideMenu()),
          Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 39.0, horizontal: 40.0),
                child: Obx(() => AnimatedSwitcher(
                      duration: Duration(milliseconds: 170),
                      reverseDuration: Duration(milliseconds: 70),
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
      )),
    );
  }
}
