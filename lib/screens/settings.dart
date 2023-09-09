import 'package:ecoquest/common_widgets.dart';
import 'package:ecoquest/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          left: standardSeparation / 2,
          right: standardSeparation / 2,
          top: standardSeparation / 2,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TitleAndSubTitleWidget(
                  titleText: 'settings',
                  subTitleText: 'customize your experience',
                ),
                Expanded(
                  child: SizedBox(
                    height: 80,
                    child: Lottie.asset(
                      "assets/lottie/settings.json",
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
