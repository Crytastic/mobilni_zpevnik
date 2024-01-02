import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:mobilni_zpevnik/models/instrument.dart';
import 'package:mobilni_zpevnik/models/languages.dart';

import 'package:mobilni_zpevnik/providers/preferences_provider.dart';
import 'package:provider/provider.dart';

class PreferenceFormField extends StatefulWidget {
  final String label;
  final dynamic value;

  const PreferenceFormField({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  _PreferenceFormFieldState createState() => _PreferenceFormFieldState();
}

class _PreferenceFormFieldState extends State<PreferenceFormField> {
  @override
  Widget build(BuildContext context) {
    final preferencesProvider = Provider.of<PreferencesProvider>(context);
    onChanged(value) {
      preferencesProvider.set(widget.label, value);
    }

    if (widget.label == "darkMode") {
      return Container();
    } // "darkMode" is the way
    switch (widget.value.runtimeType) {
      case bool:
        return SwitchListTile(
            title: Text(widget.label.i18n()),
            value: widget.value,
            onChanged: onChanged);

      case Instrument:
        return DropdownButtonFormField(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          value: (widget.value as Instrument).name,
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: widget.label.i18n(),
          ),
          items: Instrument.values
              .map((instrument) => DropdownMenuItem<String>(
                    value: instrument.name,
                    child: Text(instrument.name.i18n()),
                  ))
              .toList(),
        );

      // case LanguageCode:
      //   return DropdownButtonFormField(
      //     padding: EdgeInsets.symmetric(horizontal: 15.0),
      //     value: Localizations.localeOf(context).languageCode,
      //     onChanged: onChanged,
      //     decoration: InputDecoration(
      //       labelText: widget.label.i18n(),
      //     ),
      //     items: LanguageCode.values
      //         .map((language) => DropdownMenuItem<String>(
      //               value: language.name,
      //               child: Text(language.name.i18n()),
      //             ))
      //         .toList(),
      //   );
      default:
        return Container();
    }
  }
}
