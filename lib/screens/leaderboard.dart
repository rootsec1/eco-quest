import 'package:dio/dio.dart';
import 'package:ecoquest/common_widgets.dart';
import 'package:ecoquest/constants.dart';
import 'package:ecoquest/theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class CouponCarouselCard extends StatelessWidget {
  const CouponCarouselCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.brown[700],
      child: ListTile(
        title: const Text(
          "🚀 Maintain your streak for 7 days to get a free 50\$ coupon at Instacart, Amazon, or Walmart",
          style: TextStyle(
            fontSize: standardSeparation,
            color: backgroundColor,
          ),
        ),
        subtitle: CircleAvatar(
          child: Image.network(
            "https://assets.stickpng.com/images/5e8ce3cc664eae0004085464.png",
          ),
        ),
      ),
    );
  }
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  _getLeaderboardList() async {
    final Response response =
        await dioClientGlobal.get('${baseApiUrl}get-leaderboard/');
    final List<dynamic> apiResponseData = response.data;
    return apiResponseData;
  }

  _getColorForRank(int rank) {
    switch (rank) {
      case 1:
        return Colors.yellow[700];
      case 2:
        return Colors.grey[400];
      case 3:
        return Colors.brown[700];
      default:
        return Colors.white;
    }
  }

  Widget _getLeaderboardTable() {
    return FutureBuilder(
      future: _getLeaderboardList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text("Error loading leaderboard"),
          );
        }

        if (snapshot.data == null) {
          return const Center(
            child: Text("No data found"),
          );
        }

        dynamic leaderboardList = snapshot.data;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: leaderboardList.length,
          itemBuilder: (context, index) {
            dynamic leaderboardEntry = leaderboardList[index];
            return Card(
              color: _getColorForRank(index + 1),
              child: ListTile(
                leading: const Icon(
                  Icons.emoji_events,
                  size: standardSeparation * 2,
                ),
                title: Text(
                  '${leaderboardEntry['user']['name']}',
                  style: const TextStyle(
                    fontSize: standardSeparation,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  '${leaderboardEntry['total_carbon_footprint'] / 1000} kg of CO2',
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          left: standardSeparation / 2,
          right: standardSeparation / 2,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(height: standardSeparation),
            const CouponCarouselCard(),
            const SizedBox(height: standardSeparation),
            const Text(
              "🏆 Top 5",
              style: TextStyle(
                fontSize: standardSeparation + 4,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: standardSeparation),
            _getLeaderboardTable(),
          ],
        ),
      ),
    );
  }
}
