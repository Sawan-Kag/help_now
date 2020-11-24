import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'homescreen.dart';
class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new HomeScreen(),
      backgroundColor: Colors.white,
       image: Image.asset('assets/images/splash_screen.png',
       alignment: Alignment.center,
       ),
       loadingText: Text("Loading"),
       photoSize: 150.0,
       loaderColor: Colors.red,
      );
  }
}