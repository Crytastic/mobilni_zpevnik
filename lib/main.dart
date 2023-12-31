import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/service/ioc_container.dart';
import 'package:mobilni_zpevnik/songbook_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  IoCContainer.setup();

  runApp(
    const SongbookApp(),
  );
}
