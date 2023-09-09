import 'package:ecoquest/screens/activity.dart';
import 'package:ecoquest/screens/leaderboard.dart';
import 'package:ecoquest/screens/learn.dart';
import 'package:ecoquest/screens/settings.dart';
import 'package:ecoquest/theme.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  Widget _getCorrespondingFragment() {
    switch (currentIndex) {
      case 0:
        return const ActivityScreen();
      case 1:
        return const LeaderboardScreen();
      case 2:
        return const LearnScreen();
      case 3:
        return const SettingsScreen();
      default:
        return const ActivityScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: primaryColor,
        selectedLabelStyle: const TextStyle(color: primaryColor),
        unselectedItemColor: primaryColor,
        unselectedLabelStyle: const TextStyle(color: primaryColor),
        currentIndex: currentIndex,
        onTap: (value) => setState(() => currentIndex = value),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fitbit),
            label: 'activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'leaderboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'learn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'settings',
          ),
        ],
      ),
      body: SafeArea(child: _getCorrespondingFragment()),
    );
  }
}
