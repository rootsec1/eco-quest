// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:ecoquest/common_widgets.dart';
import 'package:ecoquest/constants.dart';
import 'package:ecoquest/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class HostCarpoolScreen extends StatefulWidget {
  const HostCarpoolScreen({super.key});

  @override
  State<HostCarpoolScreen> createState() => _HostCarpoolScreenState();
}

class _HostCarpoolScreenState extends State<HostCarpoolScreen> {
  final bool _isLoading = false;
  final TextEditingController _originController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _seatsAvailableController =
      TextEditingController();

  bool _isMaleSelected = false;
  bool _isFemaleSelected = false;
  bool _isOtherSelected = false;
  bool _isWheelchairAccessible = false;

  onHostCarpoolButtonPressed() async {
    if (_originController.text.isEmpty) {
      alertUser(
        'Please enter the street address of your origin',
        context,
      );
      return;
    }

    if (_destinationController.text.isEmpty) {
      alertUser(
        'Please enter the street address of your destination',
        context,
      );
      return;
    }

    if (_seatsAvailableController.text.isEmpty) {
      alertUser(
        'Please enter the number of seats available',
        context,
      );
      return;
    }

    if (!_isMaleSelected && !_isFemaleSelected && !_isOtherSelected) {
      alertUser('Please select at least one gender', context);
      return;
    }

    String origin = _originController.text.trim();
    String destination = _destinationController.text.trim();
    int seatsAvailable = int.parse(_seatsAvailableController.text.trim());

    List<Location> locationsOrigin = await locationFromAddress(origin);
    List<Location> locationsDestination =
        await locationFromAddress(destination);

    if (locationsOrigin.isEmpty) {
      alertUser('Please enter a valid origin address', context);
      return;
    }

    if (locationsDestination.isEmpty) {
      alertUser('Please enter a valid destination', context);
      return;
    }

    Location originLocation = locationsOrigin.first;
    Location destinationLocation = locationsDestination.first;

    String allowedGenders = "";
    if (_isMaleSelected) allowedGenders += "male,";
    if (_isFemaleSelected) allowedGenders += "female,";
    if (_isOtherSelected) allowedGenders += "other,";
    allowedGenders = allowedGenders.substring(0, allowedGenders.length - 1);
    if (_isMaleSelected && _isFemaleSelected && _isOtherSelected) {
      allowedGenders = "all";
    }

    final Response apiResponse = await dioClientGlobal.post(
      '${baseApiUrl}host-carpool-task/',
      data: {
        'uid': FirebaseAuth.instance.currentUser?.uid,
        'source_location':
            '${originLocation.latitude},${originLocation.longitude}',
        'destination_location':
            '${destinationLocation.latitude},${destinationLocation.longitude}',
        'seats_available': seatsAvailable,
        'allowed_genders': allowedGenders,
        'is_wheelchair_accessible': _isWheelchairAccessible,
      },
    );
    final dynamic responseData = apiResponse.data;
    print(responseData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onHostCarpoolButtonPressed,
        icon: const Icon(
          Icons.arrow_forward,
          size: standardSeparation * 1.5,
        ),
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
                titleText: 'Host Carpool',
                subTitleText: 'Give back to the community by hosting a carpool',
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
              const SizedBox(height: standardSeparation),
              TextField(
                enabled: !_isLoading,
                controller: _seatsAvailableController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'number of seats available',
                  icon: Icon(Icons.event_seat),
                ),
              ),
              const SizedBox(height: standardSeparation * 2),
              const Text(
                'What genders are you comfortable carpooling with?',
                style: TextStyle(
                  fontSize: standardSeparation,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CheckboxListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'male',
                  style: TextStyle(fontSize: standardSeparation),
                ),
                value: _isMaleSelected,
                onChanged: _isLoading
                    ? null
                    : (value) =>
                        setState(() => _isMaleSelected = value ?? false),
              ),
              CheckboxListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'female',
                  style: TextStyle(fontSize: standardSeparation),
                ),
                value: _isFemaleSelected,
                onChanged: _isLoading
                    ? null
                    : (value) =>
                        setState(() => _isFemaleSelected = value ?? false),
              ),
              CheckboxListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'other',
                  style: TextStyle(fontSize: standardSeparation),
                ),
                value: _isOtherSelected,
                onChanged: _isLoading
                    ? null
                    : (value) =>
                        setState(() => _isOtherSelected = value ?? false),
              ),
              const SizedBox(height: standardSeparation * 2),
              const Text(
                'Is your car wheelchair accessible?',
                style: TextStyle(
                  fontSize: standardSeparation,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: standardSeparation),
              RadioListTile<bool>(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  "yes",
                  style: TextStyle(fontSize: standardSeparation),
                ),
                value: true,
                groupValue: _isWheelchairAccessible,
                onChanged: (bool? value) => setState(
                  () => _isWheelchairAccessible = value ?? false,
                ),
              ),
              RadioListTile<bool>(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  "no",
                  style: TextStyle(fontSize: standardSeparation),
                ),
                value: false,
                groupValue: _isWheelchairAccessible,
                onChanged: (bool? value) => setState(
                  () => _isWheelchairAccessible = value ?? false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
