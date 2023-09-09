import 'package:ecoquest/common_widgets.dart';
import 'package:ecoquest/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
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
                  titleText: 'learn',
                  subTitleText: 'tips to lower your carbon footprint',
                ),
                Expanded(
                  child: SizedBox(
                    height: 80,
                    child: Lottie.asset(
                      "assets/lottie/learn.json",
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
