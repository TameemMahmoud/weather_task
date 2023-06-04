
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:weather_task/features/home_screen/presentation/view/home_screen.dart';

import '../../../utils/resources/app_assets.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/SplashScreen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        splashTransition: SplashTransition.fadeTransition,
        splash: Image.asset(AppAssets.mainLogo, width: MediaQuery.of(context).size.width*0.8,),
        duration: 3000,
        centered: true,
        splashIconSize: 210,
        nextScreen: const HomeScreen(),
      ),
    );
  }
}

