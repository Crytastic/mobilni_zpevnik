import 'package:flutter/cupertino.dart';

class MenuOption {
  final IconData icon;
  final String title;
  final Function()? onTap;

  MenuOption({required this.icon, required this.title, this.onTap});
}
