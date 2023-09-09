import 'package:ecoquest/common_widgets.dart';
import 'package:ecoquest/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          left: standardSeparation / 2,
          right: standardSeparation / 2,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TitleAndSubTitleWidget(
                  titleText: 'leaderboard',
                  subTitleText: 'see how you compare',
                ),
                Expanded(
                  child: SizedBox(
                    height: 80,
                    child: Lottie.asset(
                      "assets/lottie/leaderboard.json",
                      alignment: Alignment.centerRight,
                      frameRate: FrameRate(120),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
