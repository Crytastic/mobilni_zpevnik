import 'package:flutter/foundation.dart';
import 'package:mobilni_zpevnik/models/preferences.dart';

class PreferencesProvider extends ChangeNotifier {
  final Preferences _preferences = Preferences();

  Preferences get preferences => _preferences;

  void set(String key, dynamic value) {
    _preferences.set(key, value);
    notifyListeners();
  }
}
