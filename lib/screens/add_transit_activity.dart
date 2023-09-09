// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:ecoquest/common_widgets.dart';
import 'package:ecoquest/constants.dart';
import 'package:ecoquest/enum.dart';
import 'package:ecoquest/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class AddTransitActivity extends StatefulWidget {
  const AddTransitActivity({super.key});

  @override
  State<AddTransitActivity> createState() => _AddTransitActivityState();
}

class _AddTransitActivityState extends State<AddTransitActivity> {
  bool _isLoading = false;
  TransitTypes? _selectedTransitType;

  final TextEditingController _originController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  getAvatarIconForTransitType(TransitTypes transitType) {
    switch (transitType) {
      case TransitTypes.WALK:
        return const Icon(
          Icons.directions_walk,
          size: standardSeparation * 1.5,
        );
      case TransitTypes.BIKE:
        return const Icon(
          Icons.directions_bike,
          size: standardSeparation * 1.5,
        );
      case TransitTypes.CAR_EV:
        return const Icon(
          Icons.directions_car,
          size: standardSeparation * 1.5,
        );
      case TransitTypes.CAR_GAS:
        return const Icon(
          Icons.directions_car_outlined,
          size: standardSeparation * 1.5,
        );
      case TransitTypes.BUS:
        return const Icon(
          Icons.directions_bus,
          size: standardSeparation * 1.5,
        );
      default:
        return const Icon(
          Icons.flight,
          size: standardSeparation * 1.5,
        );
    }
  }

  onLogTransitButtonPressed() async {
    if (_originController.text.trim().isEmpty) {
      alertUser('Please enter a valid origin', context);
      return;
    }

    if (_destinationController.text.trim().isEmpty) {
      alertUser('Please enter a valid destination', context);
      return;
    }

    if (_selectedTransitType == null) {
      alertUser('Please select a transit type', context);
      return;
    }

    String originStreetAddress = _originController.text.trim();
    String destinationStreetAddress = _destinationController.text.trim();

    try {
      setState(() => _isLoading = true);
      List<Location> locationsOrigin =
          await locationFromAddress(originStreetAddress);
      List<Location> locationsDestination =
          await locationFromAddress(destinationStreetAddress);

      if (locationsOrigin.isEmpty) {
        alertUser('Please enter a valid origin', context);
        return;
      }

      if (locationsDestination.isEmpty) {
        alertUser('Please enter a valid destination', context);
        return;
      }

      Location origin = locationsOrigin.first;
      Location destination = locationsDestination.first;

      final Response apiResponse = await dioClientGlobal.post(
        '${baseApiUrl}submit-transit-activity/',
        data: {
          'uid': FirebaseAuth.instance.currentUser?.uid,
          'action_type': _selectedTransitType?.name,
          'origin': {"lat": origin.latitude, "lng": origin.longitude},
          "destination": {
            "lat": destination.latitude,
            "lng": destination.longitude
          },
        },
      );

      final responseData = apiResponse.data;
      double co2Emissions = responseData['carbon_footprint'] / 1000;
      alertUser(
        'Your carbon footprint for this transit is $co2Emissions kg',
        context,
      );
      Navigator.of(context).pop();
    } catch (ex) {
      alertUser(ex.toString(), context);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onLogTransitButtonPressed,
        icon: const Icon(
          Icons.arrow_forward,
          size: standardSeparation * 1.5,
        ),
        label: const Text(
          'log transit',
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
            children: [
              const TitleAndSubTitleWidget(
                titleText: 'Log transit',
                subTitleText:
                    'Figure out the carbon footprint for your transit',
              ),
              const SizedBox(height: standardSeparation * 2),
              TextField(
                enabled: !_isLoading,
                controller: _originController,
                keyboardType: TextInputType.streetAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'street address of origin',
                  icon: Icon(Icons.gps_not_fixed),
                ),
              ),
              const SizedBox(height: standardSeparation),
              TextField(
                enabled: !_isLoading,
                controller: _destinationController,
                keyboardType: TextInputType.streetAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'street address of destination',
                  icon: Icon(Icons.gps_fixed),
                ),
              ),
              const SizedBox(height: standardSeparation * 2),
              const Text(
                'Please choose the mode of transport',
                style: TextStyle(
                  fontSize: standardSeparation,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: standardSeparation),
              Wrap(
                spacing: standardSeparation,
                children: TransitTypes.values
                    .map(
                      (TransitTypes transitType) => ChoiceChip(
                        avatar: getAvatarIconForTransitType(transitType),
                        label: Text(
                          transitType.name
                              .toLowerCase()
                              .replaceAll('_', ' ')
                              .trim(),
                          style: const TextStyle(fontSize: standardSeparation),
                        ),
                        selected: _selectedTransitType == transitType,
                        onSelected: _isLoading
                            ? null
                            : (value) => setState(
                                () => _selectedTransitType = transitType),
                      ),
                    )
                    .toList(),
              ),
              if (_isLoading) const SizedBox(height: standardSeparation * 2),
              if (_isLoading) const LinearProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
