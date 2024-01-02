import 'package:get_it/get_it.dart';
import 'package:mobilni_zpevnik/service/auth_service.dart';
import 'package:mobilni_zpevnik/service/song_service.dart';
import 'package:mobilni_zpevnik/service/songbook_service.dart';

class IoCContainer {
  static void setup() {
    GetIt.I.registerSingleton(SongService());
    GetIt.I.registerSingleton(SongbookService());
    GetIt.I.registerSingleton(AuthService());
  }
}
