// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:ecoquest/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:ecoquest/common_widgets.dart';
import 'package:ecoquest/constants.dart';
import 'package:ecoquest/util.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final ImagePicker imagePicker = ImagePicker();

class AddFoodActivity extends StatefulWidget {
  const AddFoodActivity({super.key});

  @override
  State<AddFoodActivity> createState() => _AddFoodActivityState();
}

class _AddFoodActivityState extends State<AddFoodActivity> {
  XFile? _selectedImage;
  bool _isLoading = false;
  final TextEditingController _quantityController = TextEditingController();

  onTakePicturePressed() async {
    final XFile? photo = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 25,
    );
    setState(() => _selectedImage = photo);
  }

  onLogFoodButtonPressed() async {
    if (_quantityController.text.trim().isEmpty) {
      alertUser('Please enter a valid weight', context);
      return;
    }

    final int quantity = int.parse(_quantityController.text.trim());
    if (quantity <= 0) {
      alertUser('Please enter a valid weight', context);
      return;
    }

    if (_selectedImage == null) {
      alertUser('Please take a picture of your food', context);
      return;
    }

    try {
      setState(() => _isLoading = true);

      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          _selectedImage!.path,
          filename: _selectedImage!.name,
          contentType: MediaType.parse("image/jpeg"),
        )
      });

      final response = await dioClientGlobal.post(
        "https://api.logmeal.es/v2/image/segmentation/complete/v1.0",
        options: Options(headers: {
          "Authorization": "Bearer $logMealApiToken",
          "Content-Type": "multipart/form-data",
        }),
        data: formData,
      );
      Map<String, dynamic> responseData = response.data;

      String foodCategory = "";
      List<dynamic> foodFamilyList = responseData['foodFamily'];
      for (var foodFamily in foodFamilyList) {
        foodCategory += foodFamily['name'] + ", ";
      }
      foodCategory = foodCategory.trim();
      if (foodCategory.isNotEmpty) {
        foodCategory = foodCategory.substring(0, foodCategory.length - 1);
      }

      List<dynamic> segmentationResults = responseData['segmentation_results'];
      String foodItemsDetected = "";
      for (var segResult in segmentationResults) {
        List<dynamic> recResults = segResult['recognition_results'];
        for (var recResult in recResults) {
          foodItemsDetected += recResult['name'] + ", ";
        }
      }
      foodItemsDetected = foodItemsDetected.trim();
      if (foodItemsDetected.isNotEmpty) {
        foodItemsDetected =
            foodItemsDetected.substring(0, foodItemsDetected.length - 1);
      }
      onFoodDetectionResultReceived(foodCategory, foodItemsDetected);
    } catch (e) {
      alertUser("ERROR: $e", context);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  onFoodDetectionResultReceived(
    String foodCategory,
    String possibleFoodItems,
  ) async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text(
            'Confirm food log',
            style: TextStyle(
              fontSize: standardSeparation + 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                if (foodCategory.isNotEmpty && foodCategory != "_empty_")
                  Text(
                    'Detected food category:\n$foodCategory',
                    style: const TextStyle(fontSize: standardSeparation),
                  ),
                const SizedBox(height: standardSeparation / 2),
                Text(
                  'Possible food items:\n$possibleFoodItems',
                  style: const TextStyle(fontSize: standardSeparation),
                ),
                const SizedBox(height: standardSeparation / 2),
                const Text('Do you want to add this to your log?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'confirm',
                style: TextStyle(color: primaryColor),
              ),
              onPressed: () => onAdditionToLogConfirmed(
                foodCategory,
                possibleFoodItems,
                dialogContext,
              ),
            ),
            TextButton(
              child: const Text(
                'cancel',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  onAdditionToLogConfirmed(
    String foodCategory,
    String possibleFoodItems,
    BuildContext dialogContext,
  ) async {
    final Response<dynamic> response = await dioClientGlobal.post(
      '${baseApiUrl}submit-food-activity/',
      data: {
        'uid': FirebaseAuth.instance.currentUser?.uid,
        'action_type': 'LOG_FOOD',
        'quantity_in_grams': double.parse(_quantityController.text.trim()),
        'probable_food_category_list': foodCategory,
        'probable_food_item_list': possibleFoodItems,
      },
    );
    final responseData = response.data;
    final double carbonFootprint = responseData['carbon_footprint'] / 1000;
    Navigator.pop(dialogContext);
    alertUser(
      'Your carbon footprint for this meal is $carbonFootprint kg',
      context,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _selectedImage == null
          ? null
          : FloatingActionButton.extended(
              onPressed: onLogFoodButtonPressed,
              icon: const Icon(
                Icons.arrow_forward,
                size: standardSeparation * 1.5,
              ),
              label: const Text(
                'log food',
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
                titleText: 'Log food',
                subTitleText: 'Figure out the carbon footprint for your meal',
              ),
              const SizedBox(height: standardSeparation),
              if (_selectedImage != null && _selectedImage!.path.isNotEmpty)
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(File(_selectedImage!.path)),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(standardSeparation),
                  ),
                ),
              const SizedBox(height: standardSeparation),
              Container(
                margin: const EdgeInsets.only(top: standardSeparation),
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _isLoading ? null : onTakePicturePressed,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt, size: standardSeparation * 1.5),
                      SizedBox(width: standardSeparation),
                      Text(
                        'take a picture of your food',
                        style: TextStyle(fontSize: standardSeparation),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: standardSeparation),
              if (_selectedImage != null)
                TextField(
                  enabled: !_isLoading,
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Quantity of food (in grams)',
                  ),
                ),
              const SizedBox(height: standardSeparation),
              if (_isLoading) const LinearProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
