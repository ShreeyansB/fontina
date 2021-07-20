import 'package:flutter/material.dart';
import 'package:fontina/components/apicard_details.dart';
import 'package:fontina/components/font_family_grid.dart';
import 'package:fontina/components/fonts_info_chart.dart';
import 'package:fontina/components/fonts_table.dart';
import 'package:fontina/util/responsive.dart';
import 'package:fontina/util/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({Key? key}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Future<bool> loadDetails() async {
    return Future.delayed(Duration(milliseconds: 900), () {
      return true;
    });
  }

  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Details",
                style: GoogleFonts.spaceGrotesk(
                    color: MyTheme.primaryColorLight,
                    fontSize: 40,
                    fontWeight: FontWeight.w500)),
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
                            scale: 0.82,
                          ),
                          tablet: APIInfoCard(
                            scale: 1,
                          ),
                          desktop: APIInfoCard(
                            scale: 1,
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      FutureBuilder(
                          future: loadDetails(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Responsive(
                                desktop: FontFamilyGrid(crossAxisCount: 4),
                                tablet: FontFamilyGrid(crossAxisCount: 3),
                                mobile: FontFamilyGrid(crossAxisCount: 2),
                              );
                            }
                            return Container(
                              width: double.infinity,
                              height: 300,
                              child: Center(
                                  child: SizedBox(
                                width: 60,
                                height: 60,
                                child: CircularProgressIndicator(
                                  strokeWidth: 4.0,
                                ),
                              )),
                            );
                          }),
                      if (!Responsive.isDesktop(context))
                        SizedBox(
                          height: MyTheme.defaultPadding,
                        ),
                      if (!Responsive.isDesktop(context))
                        FutureBuilder(
                          future: loadDetails(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return FontsInfoChart();
                            }
                            return Container(
                              width: double.infinity,
                              height: 300,
                              child: Center(
                                  child: SizedBox(
                                width: 60,
                                height: 60,
                                child: CircularProgressIndicator(
                                  strokeWidth: 4.0,
                                ),
                              )),
                            );
                          },
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      FutureBuilder(
                        future: loadDetails(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return FontsTable();
                          }
                          return Container(
                            width: double.infinity,
                            height: 300,
                            child: Center(
                                child: SizedBox(
                              width: 60,
                              height: 60,
                              child: CircularProgressIndicator(
                                strokeWidth: 4.0,
                              ),
                            )),
                          );
                        },
                      ),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
                if (Responsive.isDesktop(context))
                  SizedBox(
                    width: 20,
                  ),
                if (Responsive.isDesktop(context))
                  Expanded(
                      flex: 2,
                      child: FutureBuilder(
                        future: loadDetails(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return FontsInfoChart();
                          }
                          return Container(
                            width: double.infinity,
                            height: 300,
                            child: Center(
                                child: SizedBox(
                              width: 60,
                              height: 60,
                              child: CircularProgressIndicator(
                                strokeWidth: 4.0,
                              ),
                            )),
                          );
                        },
                      )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
