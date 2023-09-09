import 'package:flutter/material.dart';

void alertUser(String content, BuildContext context, {int seconds = 5}) {
  Future<void>.microtask(() {
    final SnackBar snackBar = SnackBar(
      content: Text(content),
      duration: Duration(seconds: seconds),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  });
}
