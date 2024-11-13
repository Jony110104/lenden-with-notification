import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lenden/config/asstes.dart';
import 'package:lenden/config/router/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FlutterSplashScreen.fadeIn(
      backgroundColor: Colors.white,
      onInit: () {
        debugPrint("On Init");
      },
      onEnd: () {
        context.pushReplacement(Routes.onboarding);
      },
      childWidget: SizedBox(
        height: 400,
        width: 200,
        child: Column(
          children: [
            Image.asset(AppAssets.image.logo),
            const SizedBox(
              height: 80,
            ),
            const Text(
              "LENDEN",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 33),
            )
          ],
        ),
      ),
      onAnimationEnd: () => debugPrint("On Fade In End"),
      duration: const Duration(milliseconds: 4515),
    ));
  }
}
