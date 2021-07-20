import 'package:flutter/material.dart';
import 'package:fontina/components/gen_code_tab.dart';
import 'package:fontina/components/gen_para_tab.dart';
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
      child: DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Generate",
                style: GoogleFonts.spaceGrotesk(
                    color: MyTheme.primaryColorLight,
                    fontSize: 40,
                    fontWeight: FontWeight.w500)),
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
              height: MediaQuery.of(context).size.height - 150,
              child: TabBarView(children: [
                ParaGen(),
                CodeGen(),
              ]),
            ),
          ],
        ),
      ),
    ));
  }
}
