import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobilni_zpevnik/models/preferences.dart';

class PreferencesService {
  final _preferences = FirebaseFirestore.instance.collection('users');

  Future<void> savePreferences(Preferences preferences) async {
    try {
      await _preferences
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set(preferences.toJson());
    } catch (e) {
      print(e);
    }
  }

  Stream<Preferences> get preferencesStream => _preferences
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .snapshots()
          .map((snapshot) {
        final json = snapshot.data() ?? {};
        return Preferences.fromJson(json);
      });
}
