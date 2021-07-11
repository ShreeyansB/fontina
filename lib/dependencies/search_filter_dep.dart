import 'package:flutter/material.dart';
import 'package:fontina/dependencies/fonts_dep.dart';
import 'package:fontina/util/theme.dart';
import 'package:get/get.dart';

class SearchFilterController extends GetxController {
  Map family = {};
  Map weights = {};
  Map price = {};

  void initFilters() {
    var _fontsController = Get.find<FontgenFontsController>();
    family = {for (var item in _fontsController.types) '$item': true};
    weights = {for (var item in _fontsController.weights) '$item': true};
    price = {'isPaid': true, 'isFree': true};
    print("init");
  }
}

class MyPopupMenu extends StatefulWidget {
  const MyPopupMenu({Key? key, required this.title, required this.options})
      : super(key: key);

  final String title;
  final List<String> options;

  @override
  _MyPopupMenuState createState() => _MyPopupMenuState();
}

class _MyPopupMenuState extends State<MyPopupMenu> {
  @override
  Widget build(BuildContext context) {
    var filter;
    var filterController = Get.find<SearchFilterController>();
    if (widget.title.toLowerCase() == 'family') {
      filter = filterController.family;
    } else if (widget.title.toLowerCase() == 'weights') {
      filter = filterController.weights;
    } else if (widget.title.toLowerCase() == 'price') {
      filter = filterController.price;
    } else {
      filter = {0: true};
    }
    return PopupMenuButton(
      tooltip: "",
      offset: Offset(0, 68),
      child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: MyTheme.cardKey,
              ),
              Icon(
                Icons.arrow_drop_down,
                color: MyTheme.textColorSecondary,
              )
            ],
          ),
          padding: MyTheme.cardPadding.copyWith(left: 40) / 2,
          decoration: BoxDecoration(
            borderRadius: MyTheme.borderRadius,
            border: Border.all(color: Colors.black12, width: 1.0),
          )),
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: MyTheme.borderRadius,
          side: BorderSide(width: 1.0, color: Colors.black12)),
      itemBuilder: (context) {
        return List.generate(widget.options.length, (index) {
          return MyPopupItem(
            value: [widget.title.toLowerCase(), widget.options[index]],
            child: GetBuilder<SearchFilterController>(
              builder: (controller) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Opacity(
                        opacity: filter[widget.options[index]] ? 1 : 0.27,
                        child: Icon(Icons.done_rounded, color: MyTheme.textColorSecondary,)),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.options[index],
                      style: MyTheme.cardKey.copyWith(fontSize: 16),
                    ),
                  ],
                );
              },
            ),
          );
        });
      },
    );
  }
}

class MyPopupItem extends PopupMenuItem {
  MyPopupItem({
    Key? key,
    required Widget child,
    dynamic value,
    GetxController? controller,
  }) : super(key: key, child: child, value: value);

  late final GetxController? controller;

  @override
  _MyPopupItemState createState() => _MyPopupItemState();
}

class _MyPopupItemState extends PopupMenuItemState {
  @override
  void handleTap() {
    var filterController = Get.find<SearchFilterController>();
    Map filter;
    if (widget.value[0] == 'family') {
      filter = filterController.family;
    } else if (widget.value[0] == 'weights') {
      filter = filterController.weights;
    } else if (widget.value[0] == 'price') {
      filter = filterController.price;
    } else {
      filter = {0: true};
    }
    filter[widget.value[1]] = !filter[widget.value[1]];
    filterController.update();
  }
}
