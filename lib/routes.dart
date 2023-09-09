import 'package:ecoquest/enum.dart';
import 'package:ecoquest/screens/activity.dart';
import 'package:ecoquest/screens/add_food_activity.dart';
import 'package:ecoquest/screens/add_power_bill_activity.dart';
import 'package:ecoquest/screens/add_transit_activity.dart';
import 'package:ecoquest/screens/home.dart';
import 'package:ecoquest/screens/host_carpool.dart';
import 'package:ecoquest/screens/leaderboard.dart';
import 'package:ecoquest/screens/learn.dart';
import 'package:ecoquest/screens/settings.dart';
import 'package:ecoquest/screens/sign_in.dart';
import 'package:ecoquest/screens/splash.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext context)> appRoutes =
    <String, Widget Function(BuildContext context)>{
  ScreenNames.SPLASH.name: (_) => const SplashScreen(),
  ScreenNames.SIGN_IN.name: (_) => const SignInScreen(),
  ScreenNames.HOME.name: (_) => const HomeScreen(),
  ScreenNames.ACTIVITY.name: (_) => const ActivityScreen(),
  ScreenNames.LEADERBOARD.name: (_) => const LeaderboardScreen(),
  ScreenNames.LEARN.name: (_) => const LearnScreen(),
  ScreenNames.SETTINGS.name: (_) => const SettingsScreen(),
  ScreenNames.ADD_TRANSIT_ACTIVITY.name: (_) => const AddTransitActivity(),
  ScreenNames.ADD_FOOD_ACTIVITY.name: (_) => const AddFoodActivity(),
  ScreenNames.ADD_ENERGY_ACTIVITY.name: (_) => const AddPowerBillActivity(),
  ScreenNames.HOST_CARPOOL.name: (_) => const HostCarpoolScreen(),
  ScreenNames.SEARCH_CARPOOL.name: (_) => const HostCarpoolScreen(),
};
