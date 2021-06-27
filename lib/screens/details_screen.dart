import 'package:flutter/material.dart';
import 'package:fontina/components/apicard_details.dart';
import 'package:fontina/dependencies/fontgen_info_dep.dart';
import 'package:fontina/util/responsive.dart';
import 'package:fontina/util/theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<FontgenInfoController>().updateAPI();
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
                            scale: 0.5,
                          ),
                          tablet: APIInfoCard(
                            scale: 0.8,
                          ),
                          desktop: APIInfoCard(
                            scale: 1,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                      height: 300,
                      color: Colors.grey,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
