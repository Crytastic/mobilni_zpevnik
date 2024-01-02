import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobilni_zpevnik/screens/auth_screen.dart';
import 'package:mobilni_zpevnik/screens/screen_template.dart';
import 'package:mobilni_zpevnik/models/song.dart';
import 'package:mobilni_zpevnik/service/songbook_service.dart';
import 'package:mobilni_zpevnik/models/songbook.dart';
import 'package:mobilni_zpevnik/widgets/songbooks_stream_builder.dart';
import 'create_songbook_screen.dart';

class AddToSongbookScreen extends StatelessWidget {
  final Song song;
  final _songbookService = GetIt.I<SongbookService>();

  AddToSongbookScreen({Key? key, required this.song}) : super(key: key);

  void _createNewSongbook(String name, List<Song> songs) async {
    try {
      var songbook = Songbook(name: name, songs: songs);
      var songbookReference = await _songbookService.createSongbook(songbook);

      await _songbookService.addSongToSongbook(songbookReference.id, song);
    } catch (e) {
      if (kDebugMode) {
        print('Error creating songbook: $e');
      }
    }
  }

  void _openCreateSongbookScreen(BuildContext context, Song song) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateSongbookScreen(
          onCreate: _createNewSongbook,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthScreen(
      child: ScreenTemplate(
        appBar: AppBar(
          title: const Text('Add to Songbook'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: ListTile(
                  title: const Text('Create New Songbook'),
                  onTap: () {
                    _openCreateSongbookScreen(context, song);
                  },
                ),
              ),
              const Divider(
                height: 1,
              ),
              SongbooksStreamBuilder(
                builder: (BuildContext context, List<Songbook> songbooks) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: songbooks.length,
                    itemBuilder: (context, index) {
                      var songbook = songbooks[index];
                      return ListTile(
                        title: Text(songbook.name),
                        onTap: () {
                          _songbookService.addSongToSongbook(songbook.id, song);
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
