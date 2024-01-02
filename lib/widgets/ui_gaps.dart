import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  const Gap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 25.0,
    );
  }
}

class SmallGap extends StatelessWidget {
  const SmallGap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 8.0,
      width: 8.0,
    );
  }
}
