import 'package:flutter/material.dart';

class Chord {
  String name;

  Chord({
    required this.name,
  }) {
    name = name.replaceAll("mi", 'm');
    name = name.replaceAll("H", 'B');
  }

  String getChordName() {
    return name;
  }

  AssetImage getImage(bool darkTheme) {
    return AssetImage(
        'images/chords/${darkTheme ? "white" : "black"}/$name.png');
  }
}
