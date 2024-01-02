import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';
import 'package:mobilni_zpevnik/providers/preferences_provider.dart';
import 'package:mobilni_zpevnik/screens/login_error_notifier.dart';
import 'package:mobilni_zpevnik/utils/auto_scroll_provider.dart';
import 'package:provider/provider.dart';

import 'bars/bottom_navigation_bar_provider.dart';
import 'screens/main_screen.dart';

class SongbookApp extends StatelessWidget {
  const SongbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocalJsonLocalization.delegate.directories = ['assets/i18n'];

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomNavigationBarProvider>(
          create: (_) => BottomNavigationBarProvider(),
        ),
        ChangeNotifierProvider<AutoScrollProvider>(
          create: (_) => AutoScrollProvider(),
        ),
        ChangeNotifierProvider<LoginErrorProvider>(
          create: (_) => LoginErrorProvider(),
        ),
        ChangeNotifierProvider<PreferencesProvider>(
            create: (_) => PreferencesProvider()),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          LocalJsonLocalization.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('cs', 'CZ'),
        ],
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        home: const MainScreen(),
      ),
    );
  }
}
