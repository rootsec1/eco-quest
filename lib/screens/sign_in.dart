// ignore_for_file: use_build_context_synchronously

import 'package:ecoquest/common_widgets.dart';
import 'package:ecoquest/constants.dart';
import 'package:ecoquest/enum.dart';
import 'package:ecoquest/theme.dart';
import 'package:ecoquest/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  onSignInButtonPress() async {
    if (FirebaseAuth.instance.currentUser != null) {
      // User already logged in
      Navigator.pushNamedAndRemoveUntil(
        context,
        ScreenNames.ACTIVITY.name,
        (route) => false,
      );
    } else {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        User? firebaseUser = userCredential.user;
        if (firebaseUser != null) {
          // User logged in
          Navigator.pushNamedAndRemoveUntil(
            context,
            ScreenNames.ACTIVITY.name,
            (route) => false,
          );
        }
      } catch (e) {
        alertUser(e.toString(), context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: onSignInButtonPress,
        child: const Icon(Icons.arrow_forward),
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(standardSeparation),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 5),
              const Text(
                'Sign In',
                style: TextStyle(
                  fontSize: standardSeparation * 2,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const Text(
                'Enter your email and password to continue :)',
                style: TextStyle(fontSize: standardSeparation),
              ),
              const SizedBox(height: standardSeparation * 4),
              CustomEmailTextField(emailController: _emailController),
              const SizedBox(height: standardSeparation),
              CustomPasswordTextField(passwordController: _passwordController),
            ],
          ),
        ),
      ),
    );
  }
}
