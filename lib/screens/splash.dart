import 'dart:async';

import 'package:ecoquest/constants.dart';
import 'package:ecoquest/enum.dart';
import 'package:ecoquest/theme.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        ScreenNames.HOME.name,
        (_) => false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primaryColor,
        child: const Center(
          child: Text(
            appName,
            style: TextStyle(
              color: backgroundColor,
              fontSize: standardSeparation * 2,
            ),
          ),
        ),
      ),
    );
  }
}
