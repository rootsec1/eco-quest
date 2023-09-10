import 'package:ecoquest/constants.dart';
import 'package:ecoquest/enum.dart';
import 'package:ecoquest/firebase_options.dart';
import 'package:ecoquest/routes.dart';
import 'package:ecoquest/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> _runPreRenderOperations() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void main() async {
  await _runPreRenderOperations();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      routes: appRoutes,
      theme: appTheme,
      darkTheme: appTheme,
      initialRoute: ScreenNames.SPLASH.name,
      color: primaryColor,
    ),
  );
}
