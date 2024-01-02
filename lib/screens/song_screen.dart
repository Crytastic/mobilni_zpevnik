import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/models/song.dart';
import 'package:mobilni_zpevnik/providers/preferences_provider.dart';
import 'package:mobilni_zpevnik/screens/screen_template.dart';
import 'package:mobilni_zpevnik/utils/auto_scroll_provider.dart';
import 'package:mobilni_zpevnik/utils/song_parser.dart';
import 'package:provider/provider.dart';

class SongScreen extends StatelessWidget {
  final Song song;

  const SongScreen({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    final autoScrollProvider =
        Provider.of<AutoScrollProvider>(context, listen: true);

    return ScreenTemplate(
      appBar: AppBar(
        title: Text(song.name),
      ),
      bottomBar: null,
      body: SingleChildScrollView(
        controller: autoScrollProvider.scrollController,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Artist: ${song.artist}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SongParser(songContent: song.content),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: autoScrollProvider.toggleAutoScroll,
        child: Icon(
          autoScrollProvider.isScrolling
              ? Icons.stop_rounded
              : Icons.arrow_downward_rounded,
        ),
      ),
    );
  }
}
