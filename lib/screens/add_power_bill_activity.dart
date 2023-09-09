// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:ecoquest/common_widgets.dart';
import 'package:ecoquest/constants.dart';
import 'package:ecoquest/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddPowerBillActivity extends StatefulWidget {
  const AddPowerBillActivity({super.key});

  @override
  State<AddPowerBillActivity> createState() => _AddPowerBillActivityState();
}

class _AddPowerBillActivityState extends State<AddPowerBillActivity> {
  final TextEditingController _kwhController = TextEditingController();

  onKwhSubmitButtonPressed() async {
    final String kwh = _kwhController.text;
    if (kwh.isEmpty) {
      alertUser('Please enter a valid number', context);
      return;
    }

    final double kwhDouble = double.parse(kwh);
    final Response apiResponse = await dioClientGlobal.post(
      '${baseApiUrl}submit-power-bill-activity/',
      data: {
        'uid': FirebaseAuth.instance.currentUser?.uid,
        'kwh': kwhDouble,
      },
    );
    final dynamic responseData = apiResponse.data;
    double co2Emissions = responseData['carbon_footprint'] / 1000;
    alertUser(
      'Your carbon footprint for this power bill is $co2Emissions kg',
      context,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.arrow_forward, size: standardSeparation * 1.5),
        onPressed: onKwhSubmitButtonPressed,
        label: const Text(
          'submit',
          style: TextStyle(fontSize: standardSeparation),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: standardSeparation,
            right: standardSeparation,
            top: standardSeparation,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleAndSubTitleWidget(
                titleText: 'Submit your power usage',
                subTitleText: 'Enter the KWh used in the last month',
              ),
              const SizedBox(height: standardSeparation * 2),
              TextField(
                controller: _kwhController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  icon: Icon(Icons.electrical_services),
                  border: OutlineInputBorder(),
                  labelText: 'KWh',
                ),
              ),
              const SizedBox(height: standardSeparation * 2),
            ],
          ),
        ),
      ),
    );
  }
}
