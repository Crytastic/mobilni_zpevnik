import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobilni_zpevnik/models/instrument.dart';
import 'package:mobilni_zpevnik/models/languages.dart';

part "preferences.g.dart";

@JsonSerializable()
class Preferences {
  bool darkMode;
  Instrument mainInstrument;
  bool showChords;
  bool simplifiedChords;
  bool showBAsH;
  bool showMiAsM;
  LanguageCode language;

  Preferences({
    this.darkMode = true,
    this.mainInstrument = Instrument.guitar,
    this.showChords = true,
    this.simplifiedChords = false,
    this.showBAsH = false,
    this.showMiAsM = true,
    this.language = LanguageCode.cs,
  });

  factory Preferences.fromJson(Map<String, dynamic> json) =>
      _$PreferencesFromJson(json);

  Map<String, dynamic> toJson() => _$PreferencesToJson(this);

  void set(String key, dynamic value) {
    switch (key) {
      case 'darkMode':
        darkMode = value as bool;
        break;
      case 'mainInstrument':
        mainInstrument = value as Instrument;
        break;
      case 'showChords':
        showChords = value as bool;
        break;
      case 'simplifiedChords':
        simplifiedChords = value as bool;
        break;
      case 'showBAsH':
        showBAsH = value as bool;
        break;
      case 'showMiAsM':
        showMiAsM = value as bool;
        break;
      case 'language':
        language = value as LanguageCode;
        break;
      default:
        break;
    }
  }

  dynamic get(String key) {
    switch (key) {
      case 'darkMode':
        return darkMode;
      case 'mainInstrument':
        return mainInstrument;
      case 'showChords':
        return showChords;
      case 'simplifiedChords':
        return simplifiedChords;
      case 'showBAsH':
        return showBAsH;
      case 'showMiAsM':
        return showMiAsM;
      case 'language':
        return language;
      default:
        return null;
    }
  }
}
