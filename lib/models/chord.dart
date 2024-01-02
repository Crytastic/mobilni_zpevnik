import 'package:flutter/material.dart';

class Chord {
  String name;
  bool showMiAsM;
  bool showBAsH;

  Chord({
    required this.name,
    this.showMiAsM = true,
    this.showBAsH = false,
  }) {
    name = name.replaceAll("mi", 'm');
    name = name.replaceAll("H", 'B');
  }

  AssetImage getImage(bool darkTheme) {
    return AssetImage(
        'images/chords/${darkTheme ? "white" : "black"}/$name.png');
  }
}
