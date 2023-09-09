import 'package:dio/dio.dart';
import 'package:ecoquest/common_widgets.dart';
import 'package:ecoquest/constants.dart';
import 'package:ecoquest/enum.dart';
import 'package:ecoquest/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class _ShortcutsWidget extends StatelessWidget {
  const _ShortcutsWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(standardSeparation),
        child: Column(
          children: [
            const Text(
              'shortcuts',
              style: TextStyle(
                fontSize: standardSeparation + 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: standardSeparation),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    ScreenNames.HOST_CARPOOL.name,
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: standardSeparation * 2,
                        child: Image(
                          image: NetworkImage(
                              "https://cdn-icons-png.flaticon.com/512/2395/2395281.png"),
                        ),
                      ),
                      SizedBox(height: standardSeparation / 2),
                      Text(
                        'host\ncarpool',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: standardSeparation),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: standardSeparation * 2,
                        child: Image(
                          image: NetworkImage(
                              "https://cdn-icons-png.flaticon.com/512/954/954591.png"),
                        ),
                      ),
                      SizedBox(height: standardSeparation / 2),
                      Text(
                        'find\ncarpool',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: standardSeparation),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    ScreenNames.ADD_FOOD_ACTIVITY.name,
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: standardSeparation * 2,
                        child: Image(
                          image: NetworkImage(
                              "https://cdn-icons-png.flaticon.com/512/2721/2721981.png"),
                        ),
                      ),
                      SizedBox(height: standardSeparation / 2),
                      Text(
                        'scan\nfood',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: standardSeparation),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _RecentActivityFragment extends StatelessWidget {
  const _RecentActivityFragment();

  Future<dynamic>? getUserActivities() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      return null;
    }
    final Response userActivitiesResponse = await dioClientGlobal.get(
      '${baseApiUrl}get-user-activities/',
      queryParameters: {
        'uid': uid,
      },
    );
    final List<dynamic> userActivities = userActivitiesResponse.data;
    return userActivities;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(standardSeparation / 2),
        child: Column(
          children: [
            const Text(
              'recent activity',
              style: TextStyle(
                fontSize: standardSeparation + 4,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: standardSeparation / 2),
            FutureBuilder(
              future: getUserActivities(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text('error fetching activities  '),
                  );
                }

                if (snapshot.data == null) {
                  return const Center(
                    child: Text('no activities yet'),
                  );
                }

                final List<dynamic> userActivities = snapshot.data;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: userActivities.length,
                  itemBuilder: (listItemContext, index) {
                    Map<String, dynamic> userActivity = userActivities[index];
                    final double co2Emissions =
                        (userActivity['carbon_footprint'] ?? 0) / 1000;
                    final String actionType = userActivity['action_type'];
                    Icon? actionIcon;

                    switch (actionType) {
                      case "LOG_WALK":
                        actionIcon = const Icon(
                          Icons.directions_walk_outlined,
                          size: standardSeparation * 2,
                          color: primaryColor,
                        );
                        break;
                      case "LOG_BIKE_RIDE":
                        actionIcon = const Icon(
                          Icons.directions_bike_outlined,
                          size: standardSeparation * 2,
                          color: primaryColor,
                        );
                        break;

                      case "LOG_CAR_EV":
                        actionIcon = const Icon(
                          Icons.directions_car_outlined,
                          size: standardSeparation * 2,
                          color: primaryColor,
                        );
                        break;

                      case "LOG_CAR_GAS":
                        actionIcon = const Icon(
                          Icons.directions_car_outlined,
                          size: standardSeparation * 2,
                          color: primaryColor,
                        );
                        break;

                      case "LOG_CAR_BUS":
                        actionIcon = const Icon(
                          Icons.directions_bus_outlined,
                          size: standardSeparation * 2,
                          color: primaryColor,
                        );
                        break;

                      case "LOG_FLIGHT":
                        actionIcon = const Icon(
                          Icons.flight_outlined,
                          size: standardSeparation * 2,
                          color: primaryColor,
                        );
                        break;

                      case "LOG_FOOD":
                        actionIcon = const Icon(
                          Icons.dining_outlined,
                          size: standardSeparation * 2,
                          color: primaryColor,
                        );
                        break;

                      case "LOG_POWER_BILL":
                        actionIcon = const Icon(
                          Icons.lightbulb_outline,
                          size: standardSeparation * 2,
                          color: primaryColor,
                        );
                        break;
                    }

                    final String labelText = actionType
                        .toLowerCase()
                        .trim()
                        .replaceAll("log_", "")
                        .replaceAll("_", " ");

                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: actionIcon,
                      title: Text(
                        labelText,
                        style: const TextStyle(
                          fontSize: standardSeparation,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text('$co2Emissions kg CO2'),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: standardSeparation),
          ],
        ),
      ),
    );
  }
}

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  onNewActivityClicked(String activityName, BuildContext dialogContext) {
    Navigator.pop(dialogContext);
    switch (activityName) {
      case 'transit':
        Navigator.pushNamed(
          context,
          ScreenNames.ADD_TRANSIT_ACTIVITY.name,
        );
        break;
      case 'energy':
        Navigator.pushNamed(
          context,
          ScreenNames.ADD_ENERGY_ACTIVITY.name,
        );
        break;
      case 'delivery':
        break;
      case 'food':
        Navigator.pushNamed(
          context,
          ScreenNames.ADD_FOOD_ACTIVITY.name,
        );
        break;
      default:
        // 'recycling'
        break;
    }
  }

  onLogActivityButtonClicked() {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (dialogContext) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.only(
            left: standardSeparation,
            right: standardSeparation,
            top: standardSeparation * 2,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleAndSubTitleWidget(
                  titleText: 'Choose activity',
                  subTitleText: 'Figure out the equivalent carbon footprint',
                ),
                const SizedBox(height: standardSeparation),
                Card(
                  child: ListTile(
                    onTap: () => onNewActivityClicked('transit', dialogContext),
                    title: const Text('transit'),
                    leading: const Icon(
                      Icons.commute,
                      color: primaryColor,
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () => onNewActivityClicked('energy', dialogContext),
                    title: const Text('energy bill'),
                    leading: const Icon(
                      Icons.lightbulb_outline,
                      color: primaryColor,
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () =>
                        onNewActivityClicked('delivery', dialogContext),
                    title: const Text('delivery shipping'),
                    leading: const Icon(
                      Icons.shopping_cart,
                      color: primaryColor,
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () => onNewActivityClicked('food', dialogContext),
                    title: const Text('food'),
                    leading: const Icon(
                      Icons.dinner_dining,
                      color: primaryColor,
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () =>
                        onNewActivityClicked('recycling', dialogContext),
                    title: const Text('recycling'),
                    leading: const Icon(
                      Icons.recycling,
                      color: primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: standardSeparation),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onLogActivityButtonClicked,
        label: const Text(
          'log activity',
          style: TextStyle(fontSize: standardSeparation),
        ),
        icon: const Icon(
          Icons.add,
          size: standardSeparation * 1.5,
        ),
      ),
      body: SingleChildScrollView(
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
                  titleText: 'activity',
                  subTitleText: 'monitor your sustainability score',
                ),
                Expanded(
                  child: SizedBox(
                    height: 80,
                    child: Lottie.asset(
                      "assets/lottie/activity.json",
                      alignment: Alignment.centerRight,
                      frameRate: FrameRate(120),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: standardSeparation),
            const _ShortcutsWidget(),
            const SizedBox(height: standardSeparation),
            const _RecentActivityFragment()
          ],
        ),
      ),
    );
  }
}
