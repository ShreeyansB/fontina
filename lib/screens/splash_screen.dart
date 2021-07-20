import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:fontina/dependencies/fonts_dep.dart';
import 'package:fontina/screens/base_screen.dart';
import 'package:fontina/util/theme.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  bool trig = false;
  double _textOpacity = 0;
  double _connOpacity = 0;
  double _fetchOpacity = 0;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(-1.4, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutQuart,
  ));

  Future<bool> testFuture() async {
    await Future.delayed(Duration(milliseconds: 4000));
    return true;
  }

  void startAnim() {
    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        _controller.forward();
        Future.delayed(Duration(milliseconds: 100), () {
          setState(() {
            _textOpacity = 1;
          });
        });
        Future.delayed(Duration(milliseconds: 1400), () async {
          setState(() {
            _connOpacity = 1;
          });
          var result = await Get.find<FontgenFontsController>().getFonts();
          setState(() {
            _connOpacity = 0;
          });
          await Future.delayed(Duration(milliseconds: 400));
          setState(() {
            _fetchOpacity = 1;
          });
          await Future.delayed(Duration(milliseconds: 2000));
          if (result) {
            Get.off(
              () => BaseScreen(),
              transition: Transition.zoom,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeOutQuad,
            );
          } else {
            Get.off(
              () => NoInternetScreen(),
              transition: Transition.zoom,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeOutBack,
            );
          }
        });
      });
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      startAnim();
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyTheme.bgColorLight,
      body: Center(
        child: Container(
          width: double.infinity,
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 80,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SlideTransition(
                      position: _offsetAnimation,
                      child: Image.asset(
                        "assets/images/new_logo.png",
                        height: size.height * 0.08,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 70),
                      child: AnimatedOpacity(
                        opacity: _textOpacity,
                        curve: Curves.easeIn,
                        duration: Duration(milliseconds: 400),
                        child: Image.asset(
                          "assets/images/new_logo_text.png",
                          height: size.height * 0.05,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Stack(
                children: [
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 400),
                    opacity: _connOpacity,
                    child: DefaultTextStyle(
                      style: MyTheme.cardKey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 35,
                          ),
                          Text("Connecting to servers "),
                          SizedBox(
                            width: 40,
                            child: AnimatedTextKit(
                              repeatForever: true,
                              pause: Duration(milliseconds: 400),
                              animatedTexts: [
                                // TyperAnimatedText("."),
                                // TyperAnimatedText(".."),
                                TyperAnimatedText("...",
                                    speed: Duration(milliseconds: 400)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 400),
                    opacity: _fetchOpacity,
                    child: DefaultTextStyle(
                      style: MyTheme.cardKey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 35,
                          ),
                          Text("Fetching data "),
                          SizedBox(
                            width: 40,
                            child: AnimatedTextKit(
                              repeatForever: true,
                              pause: Duration(milliseconds: 400),
                              animatedTexts: [
                                // TyperAnimatedText("."),
                                // TyperAnimatedText(".."),
                                TyperAnimatedText("...",
                                    speed: Duration(milliseconds: 400)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
