import "package:flutter/material.dart";
import 'package:fontina/dependencies/fonts_dep.dart';
import 'package:fontina/screens/font_details_screen.dart';
import 'package:fontina/util/theme.dart';
import 'package:get/get.dart';

class FontsTable extends StatelessWidget {
  const FontsTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      padding: MyTheme.cardPadding,
      decoration: BoxDecoration(
        borderRadius: MyTheme.borderRadius,
        border: Border.all(color: Colors.black12, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Uploads",
            style: MyTheme.headingSec,
          ),
          SizedBox(
            height: 14.0,
          ),
          SizedBox(
            width: double.infinity,
            child: _size.width > 630
                ? FontsDataTable(
                    scale: 1,
                  )
                : FontsDataTable(
                    scale: 0.92,
                  ),
          ),
        ],
      ),
    );
  }
}

class FontsDataTable extends StatelessWidget {
  FontsDataTable({
    Key? key,
    required this.scale,
  }) : super(key: key);
  final double scale;

  final _fontgenFontsController = Get.find<FontgenFontsController>();

  List<DataRow> getDataRows() {
    List<DataRow> dataRows = [];
    if (_fontgenFontsController.fonts.isNotEmpty) {
      List<FontgenFonts> loadedFonts = _fontgenFontsController.fonts;
      loadedFonts.sort((a, b) => a.dateAdded.compareTo(b.dateAdded));
      loadedFonts.sort((a, b) => a.dateAdded.compareTo(b.dateAdded));
      loadedFonts = loadedFonts.reversed.toList();
      loadedFonts = loadedFonts.sublist(0, 8);
      loadedFonts.forEach((font) {
        dataRows.add(DataRow(
          cells: [
            DataCell(Row(
              children: [
                Container(
                  width: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: _fontgenFontsController.colorMap.length == 1
                        ? _fontgenFontsController.colorMap["others"]
                        : _fontgenFontsController.colorMap[font.type],
                    borderRadius: MyTheme.borderRadius,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(font.family),
              ],
            )),
            DataCell(Text(font.type)),
            DataCell(Text(font.weights.length.toString())),
            DataCell(Text(font.dateAdded
                .toString()
                .substring(0, font.dateAdded.toString().length - 5))),
          ],
          onSelectChanged: (value) {
            Get.to(
              () => FontDetailsScreen(font: font),
              transition: Transition.zoom,
              duration: Duration(milliseconds: 340),
              curve: Curves.easeOutBack,
            );
          },
        ));
      });
    }
    return dataRows;
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    if (_size.width > 560) {
      return DataTable(
        showCheckboxColumn: false,
        headingTextStyle: MyTheme.cardValue.copyWith(fontSize: 17 * scale),
        dataTextStyle:
            MyTheme.cardKey.copyWith(fontSize: 15 * scale, letterSpacing: 0.8),
        columnSpacing: 6,
        horizontalMargin: 0,
        columns: [
          DataColumn(label: Text("Font Family")),
          DataColumn(label: Text("Font Type")),
          DataColumn(label: _size.width > 630 ? Text("Weights") : Text("Wts")),
          DataColumn(label: Text("Date Added")),
        ],
        rows: getDataRows(),
      );
    } else {
      return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: DataTable(
          showCheckboxColumn: false,
          headingTextStyle: MyTheme.cardValue.copyWith(fontSize: 17 * scale),
          dataTextStyle: MyTheme.cardKey
              .copyWith(fontSize: 15 * scale, letterSpacing: 0.8),
          columnSpacing: 6,
          horizontalMargin: 0,
          columns: [
            DataColumn(label: Text("Font Family")),
            DataColumn(label: Text("Font Type")),
            DataColumn(
                label: _size.width > 630 ? Text("Weights") : Text("Wts")),
            DataColumn(label: Text("Date Added")),
          ],
          rows: getDataRows(),
        ),
      );
    }
  }
}
