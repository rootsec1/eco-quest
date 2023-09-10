// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ecoquest/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:ecoquest/common_widgets.dart';
import 'package:ecoquest/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final _storageRef = FirebaseStorage.instance.ref();
final ImagePicker _imagePicker = ImagePicker();

class AddRecyclingActivity extends StatefulWidget {
  const AddRecyclingActivity({super.key});

  @override
  State<AddRecyclingActivity> createState() => _AddRecyclingActivityState();
}

class _AddRecyclingActivityState extends State<AddRecyclingActivity> {
  XFile? _selectedImage;
  bool _isLoading = false;

  final TextEditingController _quantityController = TextEditingController();

  _onTakePicturePressed() async {
    final XFile? photo = await _imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 25,
    );
    setState(() => _selectedImage = photo);
  }

  _onConfirmButtonPressed() async {
    if (_selectedImage == null) {
      alertUser('Please take a picture of the trash', context);
      return;
    }

    if (_quantityController.text.trim().isEmpty) {
      alertUser('Please enter a valid weight', context);
      return;
    }

    final double quantity = double.parse(_quantityController.text.trim());

    try {
      setState(() => _isLoading = true);
      final tempImageRef = _storageRef.child("images/temp.jpg");
      final uploadTask = await tempImageRef.putFile(File(_selectedImage!.path));
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      final Response response = await dioClientGlobal.post(
        '${baseApiUrl}submit-recycling-activity/',
        data: {
          'uid': FirebaseAuth.instance.currentUser?.uid,
          'quantity': quantity,
          'image_url': downloadUrl,
        },
      );
      final responseData = response.data;
      final String item = responseData["prediction"];
      final double carbonEmission = responseData["carbon_footprint"];

      alertUser(
          "Added $item with a carbon footprint of $carbonEmission kg", context);

      Navigator.pop(context);
    } catch (e) {
      alertUser('ERROR: $e', context);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _selectedImage == null
          ? null
          : FloatingActionButton.extended(
              onPressed: _onConfirmButtonPressed,
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
            left: standardSeparation / 2,
            right: standardSeparation / 2,
            top: standardSeparation / 2,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const TitleAndSubTitleWidget(
                titleText: 'trash & recycling',
                subTitleText: 'keep your community clean to earn rewards!',
              ),
              const SizedBox(height: standardSeparation * 2),
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
              Container(
                margin: const EdgeInsets.only(top: standardSeparation),
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _isLoading ? null : _onTakePicturePressed,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt, size: standardSeparation * 1.5),
                      SizedBox(width: standardSeparation),
                      Text(
                        'take a picture of the trash',
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
                    labelText: 'Quantity of trash (approx in grams)',
                  ),
                ),
              const SizedBox(height: standardSeparation * 2),
              if (_isLoading) const LinearProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
