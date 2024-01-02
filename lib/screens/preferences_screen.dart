import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:localization/localization.dart';
import 'package:mobilni_zpevnik/models/preferences.dart';
import 'package:mobilni_zpevnik/screens/auth_screen.dart';
import 'package:mobilni_zpevnik/screens/screen_template.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobilni_zpevnik/service/preferences_service.dart';
import 'package:mobilni_zpevnik/widgets/common_button.dart';
import 'package:mobilni_zpevnik/widgets/preference_form_field.dart';
import 'package:provider/provider.dart';
import 'package:mobilni_zpevnik/providers/preferences_provider.dart';

class PreferencesScreen extends StatelessWidget {
  PreferencesScreen({super.key});
  void _signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final preferencesProvider = Provider.of<PreferencesProvider>(context);
    final userPreferences = preferencesProvider.preferences;
    return AuthScreen(
      child: ScreenTemplate(
        appBar: AppBar(
          title: Text('preferences'.i18n()),
        ),
        body: ListView(
          children: [
            ...preferencesProvider.preferences.toJson().keys.map((key) {
              return PreferenceFormField(
                label: key,
                value: userPreferences.get(key),
              );
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: CommonButton(
                      width: 200,
                      label: "save".i18n(),
                      onPressed: () => PreferencesService()
                          .savePreferences(userPreferences)),
                )
              ],
            ),
            ListTile(
              title: Text('logout'.i18n()),
              subtitle: Text(FirebaseAuth.instance.currentUser?.email ?? ''),
              onTap: _signUserOut,
            ),
          ],
        ),
      ),
    );
  }
}
