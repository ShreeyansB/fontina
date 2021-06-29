import 'package:flutter/material.dart';
import 'package:fontina/components/apicard_details.dart';
import 'package:fontina/components/font_family_grid.dart';
import 'package:fontina/components/fonts_info_chart.dart';
import 'package:fontina/util/responsive.dart';
import 'package:fontina/util/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Text("Details",
                    style: GoogleFonts.spaceGrotesk(
                        color: MyTheme.primaryColorLight,
                        fontSize: 40,
                        fontWeight: FontWeight.w500)),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Responsive(
                          mobile: APIInfoCard(
                            scale: 0.8,
                          ),
                          tablet: APIInfoCard(
                            scale: 0.8,
                          ),
                          desktop: APIInfoCard(
                            scale: 1,
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Responsive(
                        desktop: FontFamilyGrid(crossAxisCount: 4),
                        tablet: FontFamilyGrid(crossAxisCount: 3),
                        mobile: FontFamilyGrid(crossAxisCount: 2),
                      ),
                    ],
                  ),
                ),
                if (Responsive.isDesktop(context))
                  SizedBox(
                    width: 20,
                  ),
                if (Responsive.isDesktop(context))
                  Expanded(flex: 2, child: FontsInfoChart()),
              ],
            ),
            if (!Responsive.isDesktop(context))
              SizedBox(
                height: MyTheme.defaultPadding,
              ),
            if (!Responsive.isDesktop(context)) FontsInfoChart(),
          ],
        ),
      ),
    );
  }
}
