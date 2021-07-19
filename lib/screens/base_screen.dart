import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fontina/components/side_menu.dart';
import 'package:fontina/dependencies/fontgen_info_dep.dart';
import 'package:fontina/dependencies/fonts_dep.dart';
import 'package:fontina/dependencies/side_navigation_dep.dart';
import 'package:fontina/util/responsive.dart';
import 'package:fontina/util/theme.dart';
import 'package:get/get.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  void initState() {
    Get.find<FontgenInfoController>().updateAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Get.find<SideMenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
          child: FutureBuilder(
        future: Get.find<FontgenFontsController>().getFonts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == false) {
              return Center(
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
                          SystemChannels.platform
                              .invokeMethod('SystemNavigator.pop');
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
              );
            }
            return Row(
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
            );
          }
          return Center(
              child: SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(
              strokeWidth: 5.0,
            ),
          ));
        },
      )),
    );
  }
}
