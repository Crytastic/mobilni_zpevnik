import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:localization/localization.dart';
import 'package:mobilni_zpevnik/models/song.dart';
import 'package:mobilni_zpevnik/screens/song_screen.dart';
import 'package:mobilni_zpevnik/widgets/bottom_sheet_menu.dart';
import 'package:mobilni_zpevnik/widgets/colored_tile.dart';
import 'package:mobilni_zpevnik/widgets/menu_option.dart';
import 'package:mobilni_zpevnik/service/songbook_service.dart';

class SongTile extends StatelessWidget {
  final Song song;
  final int index;
  final bool canAddToSongbook;
  final bool canRemoveFromSongbook;
  final VoidCallback? onAddToSongbookTap;
  final Function(Song song)? onRemoveFromSongbookTap;
  final _songbookService = GetIt.I<SongbookService>();

  SongTile({
    Key? key,
    required this.song,
    required this.index,
    required this.canAddToSongbook,
    required this.canRemoveFromSongbook,
    this.onAddToSongbookTap,
    this.onRemoveFromSongbookTap,
  }) : super(key: key);

  Future<void> _addToFavorites() async {
    final String favoritesId = await _songbookService.getFavoritesSongbookId();
    await _songbookService.addSongToSongbook(favoritesId, song);
  }

  @override
  Widget build(BuildContext context) {
    List<MenuOption> menuOptions = [
      if (canAddToSongbook)
        MenuOption(
          icon: Icons.add_circle_rounded,
          title: 'add-to-songbook'.i18n(),
          onTap: onAddToSongbookTap,
        ),
      MenuOption(
        icon: Icons.favorite,
        title: 'add-to-favorites'.i18n(),
        onTap: () {
          _addToFavorites();
          Navigator.pop(context);
        },
      ),
      if (canRemoveFromSongbook)
        MenuOption(
          icon: Icons.remove_circle_rounded,
          title: 'remove-from-songbook'.i18n(),
          onTap: onRemoveFromSongbookTap != null
              ? () => onRemoveFromSongbookTap!(song)
              : null,
        ),
    ];

    return ColoredTile(
      index: index,
      title: Text(song.name),
      subtitle: Text(song.artist),
      trailing: GestureDetector(
        onTap: () {
          BottomSheetMenu.show(
            context,
            ListTile(
              title: Text(song.name),
              subtitle: Text(song.artist),
            ),
            menuOptions,
          );
        },
        child: const Icon(Icons.more_vert),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SongScreen(song: song),
          ),
        );
      },
    );
  }
}
