import 'package:ecoquest/enum.dart';
import 'package:ecoquest/screens/home.dart';
import 'package:ecoquest/screens/splash.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext context)> appRoutes =
    <String, Widget Function(BuildContext context)>{
  ScreenNames.SPLASH.name: (_) => const SplashScreen(),
  ScreenNames.HOME.name: (_) => const HomeScreen(),
};
