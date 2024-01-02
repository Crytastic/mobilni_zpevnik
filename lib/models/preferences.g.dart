// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Preferences _$PreferencesFromJson(Map<String, dynamic> json) => Preferences(
      darkMode: json['darkMode'] as bool? ?? true,
      mainInstrument:
          $enumDecodeNullable(_$InstrumentEnumMap, json['mainInstrument']) ??
              Instrument.guitar,
      showChords: json['showChords'] as bool? ?? true,
      simplifiedChords: json['simplifiedChords'] as bool? ?? false,
      showBAsH: json['showBAsH'] as bool? ?? false,
      showMiAsM: json['showMiAsM'] as bool? ?? true,
      language: $enumDecodeNullable(_$LanguageCodeEnumMap, json['language']) ??
          LanguageCode.cs,
    );

Map<String, dynamic> _$PreferencesToJson(Preferences instance) =>
    <String, dynamic>{
      'darkMode': instance.darkMode,
      'mainInstrument': _$InstrumentEnumMap[instance.mainInstrument]!,
      'showChords': instance.showChords,
      'simplifiedChords': instance.simplifiedChords,
      'showBAsH': instance.showBAsH,
      'showMiAsM': instance.showMiAsM,
      'language': _$LanguageCodeEnumMap[instance.language]!,
    };

const _$InstrumentEnumMap = {
  Instrument.guitar: 'guitar',
  Instrument.ukulele: 'ukulele',
  Instrument.piano: 'piano',
};

const _$LanguageCodeEnumMap = {
  LanguageCode.en: 'en',
  LanguageCode.cs: 'cs',
};
