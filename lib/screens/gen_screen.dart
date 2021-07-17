import 'package:flutter/material.dart';
import 'package:fontina/components/gen_tabs.dart';
import 'package:fontina/dependencies/side_navigation_dep.dart';
import 'package:fontina/util/responsive.dart';
import 'package:fontina/util/theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class GenScreen extends StatefulWidget {
  const GenScreen({Key? key}) : super(key: key);

  @override
  _GenScreenState createState() => _GenScreenState();
}

class _GenScreenState extends State<GenScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: DefaultTabController(
        length: 2,
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
                Text("Generate",
                    style: GoogleFonts.spaceGrotesk(
                        color: MyTheme.primaryColorLight,
                        fontSize: 40,
                        fontWeight: FontWeight.w500)),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Theme(
              data: context.theme.copyWith(
                  hoverColor: Colors.transparent,
                  splashColor: Colors.black12,
                  highlightColor: Colors.transparent),
              child: TabBar(
                tabs: [
                  Tab(
                    text: "Paragraph",
                  ),
                  Tab(
                    text: "Code",
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: TabBarView(children: [
                ParaGen(),
                Container(
                  child: Text("Not yet implemented"),
                )
              ]),
            ),
          ],
        ),
      ),
    ));
  }
}
