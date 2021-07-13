import 'package:flutter/material.dart';
import 'package:fontina/dependencies/fonts_dep.dart';
import 'package:fontina/dependencies/search_filter_dep.dart';
import 'package:fontina/dependencies/search_textfield_dep.dart';
import 'package:fontina/dependencies/storage_dep.dart';
import 'package:fontina/screens/font_details_screen.dart';
import 'package:fontina/util/responsive.dart';
import 'package:fontina/util/theme.dart';
import 'package:get/get.dart';

class FontsSearchTable extends StatefulWidget {
  const FontsSearchTable({Key? key, required this.isFav}) : super(key: key);
  final bool isFav;

  @override
  _FontsSearchTableState createState() => _FontsSearchTableState();
}

class _FontsSearchTableState extends State<FontsSearchTable> {
  @override
  Widget build(BuildContext context) {
    if (!Responsive.isMobile(context)) {
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
              "Fonts",
              style: MyTheme.headingSec,
            ),
            SizedBox(
              height: 14.0,
            ),
            SizedBox(
              width: double.infinity,
              child: SearchDataTable(
                scale: 1,
                isFav: widget.isFav,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: SearchListview(
                isFav: widget.isFav,
              ),
            ),
          ],
        ),
      );
    }
  }
}

class SearchDataTable extends StatefulWidget {
  SearchDataTable({Key? key, required this.scale, required this.isFav})
      : super(key: key);
  final double scale;
  final bool isFav;

  @override
  _SearchDataTableState createState() => _SearchDataTableState();
}

class _SearchDataTableState extends State<SearchDataTable> {
  List<DataRow> searchRows = [];
  final _fontgenFontsController = Get.find<FontgenFontsController>();
  List<FontgenFonts> loadedFonts = [];
  bool famSort = true;
  var storageController = Get.find<StorageController>();

  void checkFavs() {
    if (widget.isFav) {
      List<FontgenFonts> newFonts = [];
      for (var i = 0; i < loadedFonts.length; i++) {
        for (var j = 0; j < storageController.favorites.length; j++) {
          if (storageController.favorites[j]["family"] ==
              loadedFonts[i].family) {
            newFonts.add(loadedFonts[i]);
            break;
          }
        }
      }
      loadedFonts = newFonts;
      print(loadedFonts);
    }
  }

  void initRows() {
    if (_fontgenFontsController.fonts.isNotEmpty) {
      if (widget.isFav) {
        _fontgenFontsController.fonts.forEach((font) {
          storageController.favorites.forEach((fav) {
            if (font.family == fav["family"]) {
              loadedFonts.add(font);
            }
          });
        });
      } else {
        loadedFonts = _fontgenFontsController.fonts;
      }
      loadedFonts.sort((a, b) => a.family.compareTo(b.family));
      addRows();
    }
  }

  static bool checkWeight(FontgenFonts f, Map m) {
    for (var i = 0; i < f.weights.length; i++) {
      if (m.containsKey(f.weights[i]) && m[f.weights[i]] == true) {
        return true;
      }
    }
    return false;
  }

  static bool checkPrice(FontgenFonts f, Map m) {
    if (f.isPaid) {
      if (m["isPaid"]) {
        return true;
      } else {
        return false;
      }
    } else {
      if (m["isFree"]) {
        return true;
      } else {
        return false;
      }
    }
  }

  void addRows() {
    searchRows = [];
    var filterController = Get.find<SearchFilterController>();

    loadedFonts.forEach((font) {
      if (Get.find<SearchTextfieldController>().controller.value.text.isEmpty ||
          font.family.toLowerCase().contains(
              Get.find<SearchTextfieldController>()
                  .controller
                  .value
                  .text
                  .toLowerCase())) {
        if (filterController.family[font.type] &&
            checkWeight(font, filterController.weights) &&
            checkPrice(font, filterController.price)) {
          searchRows.add(DataRow(
            cells: [
              DataCell(
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(MyTheme.defaultPadding / 5),
                      height: 41.0 * widget.scale,
                      decoration: BoxDecoration(
                        color: HSLColor.fromColor(
                                _fontgenFontsController.colorMap[font.type]!)
                            .withLightness(0.73)
                            .toColor(),
                        borderRadius: MyTheme.borderRadius / 1.5,
                      ),
                      child: Image.asset(
                        _fontgenFontsController.getImgSrc(font.type),
                        color: HSLColor.fromColor(
                                _fontgenFontsController.colorMap[font.type]!)
                            .withLightness(0.85)
                            .toColor(),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      font.family,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              DataCell(Text(font.type, overflow: TextOverflow.ellipsis)),
              DataCell(Text(font.weights.length.toString())),
              DataCell(
                Text(
                  font.isPaid ? "No" : "Yes",
                  style: TextStyle(
                      color:
                          font.isPaid ? Color(0xff9b475d) : Color(0xff447c69)),
                ),
              ),
            ],
            onSelectChanged: (value) {
              Get.to(
                () => FontDetailsScreen(font: font),
                transition: Transition.zoom,
                duration: Duration(milliseconds: 340),
                curve: Curves.easeOutBack,
              )!
                  .then((value) {
                setState(() {
                  checkFavs();
                });
              });
            },
          ));
        }
      }
    });
  }

  void sortByFamily(bool asc) {
    if (asc) {
      loadedFonts.sort((a, b) => a.family.compareTo(b.family));
    } else {
      loadedFonts.sort((a, b) => a.family.compareTo(b.family));
      loadedFonts = loadedFonts.reversed.toList();
    }
    setState(() {
      addRows();
      famSort = !famSort;
    });
  }

  void sortByType() {
    loadedFonts.sort((a, b) => a.type.compareTo(b.type));
    setState(() {
      addRows();
    });
  }

  void sortByPay() {
    loadedFonts.sort((a, b) => boolSort(a, b));
    setState(() {
      addRows();
    });
  }

  int boolSort(FontgenFonts a, FontgenFonts b) {
    bool x = a.isPaid;
    bool y = b.isPaid;
    if (x != y) {
      if (x) {
        return -1;
      } else {
        return 1;
      }
    } else {
      return a.family.compareTo(b.family);
    }
  }

  @override
  void initState() {
    super.initState();
    initRows();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchFilterController>(
      builder: (controller) {
        return GetBuilder<SearchTextfieldController>(
          builder: (controller) {
            addRows();
            return DataTable(
              showCheckboxColumn: false,
              headingTextStyle:
                  MyTheme.cardValue.copyWith(fontSize: 20 * widget.scale),
              dataTextStyle: MyTheme.cardKey
                  .copyWith(fontSize: 17 * widget.scale, letterSpacing: 0.8),
              horizontalMargin: 0,
              dataRowHeight: 65.0,
              sortAscending: famSort,
              sortColumnIndex: 0,
              columns: [
                DataColumn(
                  label: Text("Font Family"),
                  onSort: (columnIndex, ascending) {
                    sortByFamily(ascending);
                  },
                ),
                DataColumn(
                  label: Text("Type"),
                  onSort: (columnIndex, ascending) {
                    sortByType();
                  },
                ),
                DataColumn(label: Text("Weights"), numeric: true),
                DataColumn(
                  label: Text("Free"),
                  onSort: (columnIndex, ascending) {
                    sortByPay();
                  },
                ),
              ],
              rows: searchRows,
            );
          },
        );
      },
    );
  }
}

class SearchListview extends StatefulWidget {
  const SearchListview({Key? key, required this.isFav}) : super(key: key);
  final bool isFav;

  @override
  _SearchListviewState createState() => _SearchListviewState();
}

class _SearchListviewState extends State<SearchListview> {
  final _fontgenFontsController = Get.find<FontgenFontsController>();
  List<FontgenFonts> loadedFonts = [];
  var storageController = Get.find<StorageController>();

  @override
  void initState() {
    super.initState();
    if (widget.isFav) {
      _fontgenFontsController.fonts.forEach((font) {
        storageController.favorites.forEach((fav) {
          if (font.family == fav["family"]) {
            loadedFonts.add(font);
          }
        });
      });
    } else {
      loadedFonts = _fontgenFontsController.fonts;
    }
    loadedFonts.sort((a, b) => a.family.compareTo(b.family));
  }

  static bool checkWeight(FontgenFonts f, Map m) {
    for (var i = 0; i < f.weights.length; i++) {
      if (m.containsKey(f.weights[i]) && m[f.weights[i]] == true) {
        return true;
      }
    }
    return false;
  }

  static bool checkPrice(FontgenFonts f, Map m) {
    if (f.isPaid) {
      if (m["isPaid"]) {
        return true;
      } else {
        return false;
      }
    } else {
      if (m["isFree"]) {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SearchTextfieldController ctrlr = Get.find<SearchTextfieldController>();
    var filterController = Get.find<SearchFilterController>();
    return Container(
      child: GetBuilder<SearchFilterController>(
        builder: (controller) =>
            GetBuilder<SearchTextfieldController>(builder: (controller) {
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: loadedFonts.length,
            itemBuilder: (context, index) {
              if (ctrlr.controller.text.isEmpty ||
                  loadedFonts[index]
                      .family
                      .toLowerCase()
                      .contains(ctrlr.controller.text.toLowerCase())) {
                if (filterController.family[loadedFonts[index].type] &&
                    checkWeight(loadedFonts[index], filterController.weights) &&
                    checkPrice(loadedFonts[index], filterController.price)) {
                  return ListTile(
                    contentPadding:
                        EdgeInsets.only(right: 20, top: 7, bottom: 12),
                    minLeadingWidth: 40,
                    leading: Container(
                      padding: EdgeInsets.all(MyTheme.defaultPadding / 5),
                      height: 37.0,
                      decoration: BoxDecoration(
                        color: HSLColor.fromColor(_fontgenFontsController
                                .colorMap[loadedFonts[index].type]!)
                            .withLightness(0.73)
                            .toColor(),
                        borderRadius: MyTheme.borderRadius / 1.5,
                      ),
                      child: Image.asset(
                        _fontgenFontsController
                            .getImgSrc(loadedFonts[index].type),
                        color: HSLColor.fromColor(_fontgenFontsController
                                .colorMap[loadedFonts[index].type]!)
                            .withLightness(0.85)
                            .toColor(),
                      ),
                    ),
                    title: Padding(
                      padding: EdgeInsets.only(bottom: 6),
                      child: Text(
                        loadedFonts[index].family,
                        style: MyTheme.cardKey,
                      ),
                    ),
                    subtitle: Text(
                      loadedFonts[index].type,
                      style: MyTheme.cardKey.copyWith(
                          fontSize: 15,
                          color: MyTheme.textColorLight.withOpacity(0.6)),
                    ),
                    trailing: Text(loadedFonts[index].weights.length.toString(),
                        style: MyTheme.cardKey.copyWith(
                            color: loadedFonts[index].isPaid
                                ? Color(0xff9b475d)
                                : Color(0xff447c69))),
                    onTap: () {
                      Get.to(
                        () => FontDetailsScreen(font: loadedFonts[index]),
                        transition: Transition.zoom,
                        duration: Duration(milliseconds: 340),
                        curve: Curves.easeOutBack,
                      );
                    },
                  );
                } else {
                  return Container();
                }
              } else {
                return Container();
              }
            },
          );
        }),
      ),
    );
  }
}
