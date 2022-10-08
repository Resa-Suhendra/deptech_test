import 'package:deptech_test/core/utils/navigation/navigation_utils.dart';
import 'package:deptech_test/gen/assets.gen.dart';
import 'package:deptech_test/ui/constant/constant.dart';
import 'package:flutter/material.dart';

import '../../router/route_list.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double opacityLogo = 0;
  double opacityText = 0;

  void initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      opacityLogo = 1;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      opacityText = 1;
    });
    await Future.delayed(const Duration(seconds: 2));
    navigate.pushToRemoveUntil(routeLogin);
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    setStatusBar();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: opacityLogo,
              duration: const Duration(milliseconds: 300),
              child: Image.asset(
                Assets.icons.notes.path,
                width: deviceWidth * 0.4,
                height: setHeight(400),
              ),
            ),
            AnimatedOpacity(
              opacity: opacityText,
              duration: const Duration(milliseconds: 300),
              child: Text(
                "Remind your Life",
                style: styleTitle.copyWith(
                  fontSize: setFontSize(60),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
