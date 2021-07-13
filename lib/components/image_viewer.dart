import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fontina/util/responsive.dart';
import 'package:fontina/util/theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageViewer extends StatefulWidget {
  const ImageViewer({Key? key, required this.imgURL}) : super(key: key);
  final String imgURL;

  @override
  _ImageViewerState createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer>
    with SingleTickerProviderStateMixin {
  final _transformationController = TransformationController();
  TapDownDetails _doubleTapDetails = TapDownDetails();

  late AnimationController _animationController;
  late Animation<Matrix4> _animation;

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    Matrix4 _endMatrix;
    Offset _position = _doubleTapDetails.localPosition;

    if (_transformationController.value != Matrix4.identity()) {
      _endMatrix = Matrix4.identity();
    } else {
      _endMatrix = Matrix4.identity()
        ..translate(-_position.dx, -_position.dy)
        ..scale(2.0);
    }

    _animation = Matrix4Tween(
      begin: _transformationController.value,
      end: _endMatrix,
    ).animate(
      CurveTween(curve: Curves.easeOut).animate(_animationController),
    );
    _animationController.forward(from: 0);
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    )..addListener(() {
        _transformationController.value = _animation.value;
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.bgColorLight,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios_rounded),
            iconSize: 30,
            color: MyTheme.primaryColorLight,
          ),
        ),
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            widget.imgURL
                .replaceAll("https://fontgen-sb.herokuapp.com/download/", ""),
            style: GoogleFonts.spaceGrotesk().copyWith(
                fontSize: 27,
                color: MyTheme.primaryColorLight,
                fontWeight: FontWeight.w700),
          ),
        ),
        elevation: 1,
        backgroundColor: context.theme.scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: InteractiveViewer(
          transformationController: _transformationController,
          child: GestureDetector(
            onDoubleTap: _handleDoubleTap,
            onDoubleTapDown: _handleDoubleTapDown,
            child: Padding(
              padding: EdgeInsets.all(Responsive.isDesktop(context)
                  ? 150
                  : (Responsive.isTablet(context) ? 75 : 0)),
              child: CachedNetworkImage(
                imageUrl: widget.imgURL,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                placeholder: (context, url) => SizedBox(
                    height: 100,
                    child: Center(child: CircularProgressIndicator())),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ImageViewerPara extends StatefulWidget {
  const ImageViewerPara(
      {Key? key,
      required this.imgURL,
      required this.isDark,
      required this.name})
      : super(key: key);
  final String imgURL;
  final bool isDark;
  final String name;
  @override
  _ImageViewerParaState createState() => _ImageViewerParaState();
}

class _ImageViewerParaState extends State<ImageViewerPara>
    with SingleTickerProviderStateMixin {
  final _transformationController = TransformationController();
  TapDownDetails _doubleTapDetails = TapDownDetails();

  late AnimationController _animationController;
  late Animation<Matrix4> _animation;

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    Matrix4 _endMatrix;
    Offset _position = _doubleTapDetails.localPosition;

    if (_transformationController.value != Matrix4.identity()) {
      _endMatrix = Matrix4.identity();
    } else {
      _endMatrix = Matrix4.identity()
        ..translate(-_position.dx, -_position.dy)
        ..scale(2.0);
    }

    _animation = Matrix4Tween(
      begin: _transformationController.value,
      end: _endMatrix,
    ).animate(
      CurveTween(curve: Curves.easeOut).animate(_animationController),
    );
    _animationController.forward(from: 0);
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    )..addListener(() {
        _transformationController.value = _animation.value;
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.bgColorLight,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios_rounded),
            iconSize: 30,
            color: MyTheme.primaryColorLight,
          ),
        ),
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            widget.name + " Paragraph",
            style: GoogleFonts.spaceGrotesk().copyWith(
                fontSize: 27,
                color: MyTheme.primaryColorLight,
                fontWeight: FontWeight.w700),
          ),
        ),
        elevation: 1,
        backgroundColor: context.theme.scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: InteractiveViewer(
          transformationController: _transformationController,
          child: GestureDetector(
            onDoubleTap: _handleDoubleTap,
            onDoubleTapDown: _handleDoubleTapDown,
            child: Padding(
              padding: EdgeInsets.all(Responsive.isDesktop(context)
                  ? 150
                  : (Responsive.isTablet(context) ? 75 : 0)),
              child: CachedNetworkImage(
                imageUrl: widget.imgURL,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                      borderRadius: MyTheme.borderRadius,
                      color: widget.isDark
                          ? Color(0xff260F26)
                          : Colors.tealAccent),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.contain,
                          colorFilter: ColorFilter.mode(
                              widget.isDark
                                  ? Color(0xffFDCFF3)
                                  : Color(0xff413D5D),
                              BlendMode.srcATop)),
                    ),
                  ),
                ),
                placeholder: (context, url) => SizedBox(
                    height: 100,
                    child: Center(child: CircularProgressIndicator())),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ImageViewerCode extends StatefulWidget {
  const ImageViewerCode(
      {Key? key,
      required this.imgURL,
      required this.name})
      : super(key: key);
  final String imgURL;
  final String name;
  @override
  _ImageViewerCodeState createState() => _ImageViewerCodeState();
}

class _ImageViewerCodeState extends State<ImageViewerCode>
    with SingleTickerProviderStateMixin {
  final _transformationController = TransformationController();
  TapDownDetails _doubleTapDetails = TapDownDetails();

  late AnimationController _animationController;
  late Animation<Matrix4> _animation;

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    Matrix4 _endMatrix;
    Offset _position = _doubleTapDetails.localPosition;

    if (_transformationController.value != Matrix4.identity()) {
      _endMatrix = Matrix4.identity();
    } else {
      _endMatrix = Matrix4.identity()
        ..translate(-_position.dx, -_position.dy)
        ..scale(2.0);
    }

    _animation = Matrix4Tween(
      begin: _transformationController.value,
      end: _endMatrix,
    ).animate(
      CurveTween(curve: Curves.easeOut).animate(_animationController),
    );
    _animationController.forward(from: 0);
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    )..addListener(() {
        _transformationController.value = _animation.value;
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.bgColorLight,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios_rounded),
            iconSize: 30,
            color: MyTheme.primaryColorLight,
          ),
        ),
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            widget.name + " Code",
            style: GoogleFonts.spaceGrotesk().copyWith(
                fontSize: 27,
                color: MyTheme.primaryColorLight,
                fontWeight: FontWeight.w700),
          ),
        ),
        elevation: 1,
        backgroundColor: context.theme.scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: InteractiveViewer(
          transformationController: _transformationController,
          child: GestureDetector(
            onDoubleTap: _handleDoubleTap,
            onDoubleTapDown: _handleDoubleTapDown,
            child: Padding(
              padding: EdgeInsets.all(Responsive.isDesktop(context)
                  ? 150
                  : (Responsive.isTablet(context) ? 75 : 0)),
              child: CachedNetworkImage(
                imageUrl: widget.imgURL,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                placeholder: (context, url) => SizedBox(
                    height: 100,
                    child: Center(child: CircularProgressIndicator())),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
