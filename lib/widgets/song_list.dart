import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/models/song.dart';
import 'package:mobilni_zpevnik/widgets/song_tile.dart';
import 'package:mobilni_zpevnik/screens/add_to_songbook_screen.dart';

class SongList extends StatelessWidget {
  final List<Song> songs;
  final bool canAddToSongbook;
  final bool canRemoveFromSongbook;
  final VoidCallback? onAddToSongbookTap;
  final Function(Song song)? onRemoveFromSongbookTap;

  const SongList({
    Key? key,
    required this.songs,
    this.canAddToSongbook = true,
    this.canRemoveFromSongbook = false,
    this.onAddToSongbookTap,
    this.onRemoveFromSongbookTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: songs.length,
      itemBuilder: (BuildContext context, int index) {
        return SongTile(
          song: songs[index],
          index: index,
          canAddToSongbook: canAddToSongbook,
          canRemoveFromSongbook: canRemoveFromSongbook,
          onAddToSongbookTap: onAddToSongbookTap ??
              () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddToSongbookScreen(song: songs[index]),
                  ),
                );
              },
          onRemoveFromSongbookTap: onRemoveFromSongbookTap,
        );
      },
    );
  }
}
