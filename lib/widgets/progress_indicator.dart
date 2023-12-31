import 'package:flutter/material.dart';

class ProgressDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context).pop();
  }
}
