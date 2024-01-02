import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:mobilni_zpevnik/models/song.dart';
import 'package:mobilni_zpevnik/models/songbook.dart';
import 'package:rxdart/rxdart.dart';

class SongbookService {
  final _songbookCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('songbooks')
      .withConverter(
    fromFirestore: (snapshot, options) {
      final json = snapshot.data() ?? {};
      json['id'] = snapshot.id;
      return Songbook.fromJson(json);
    },
    toFirestore: (value, options) {
      final json = value.toJson();
      json.remove('id');
      return json;
    },
  );

  final _songbooksSubject = BehaviorSubject<List<Songbook>>();

  SongbookService() {
    _songbookCollection
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((docSnapshot) => docSnapshot.data())
            .toList())
        .publishValue()
        .autoConnect()
        .listen((songbooks) {
      _songbooksSubject.add(songbooks);
    });
  }

  Stream<List<Songbook>> get songbooksStream => _songbooksSubject.stream;

  Future<DocumentReference> createSongbook(Songbook songbook) {
    return _songbookCollection.add(songbook);
  }

  Future<void> addSongToSongbook(String? songbookId, Song song) async {
    final songbookReference = _songbookCollection.doc(songbookId);

    final songbookSnapshot = await songbookReference.get();
    final existingSongs =
        List<Map<String, dynamic>>.from(songbookSnapshot['songs']);

    final songExists =
        existingSongs.any((existingSong) => existingSong['id'] == song.id);
    if (!songExists) {
      existingSongs.add(song.toJson());
      await songbookReference.update({'songs': existingSongs});
    } else {
      if (kDebugMode) {
        print('Song with ID ${song.id} already exists in the songbook.');
      }
    }
  }

  Future<void> removeSongFromSongbook(
      String? songbookId, String? songId) async {
    final songbookReference = _songbookCollection.doc(songbookId);

    final songbookSnapshot = await songbookReference.get();
    final existingSongs =
        List<Map<String, dynamic>>.from(songbookSnapshot['songs']);

    existingSongs.removeWhere((song) => song['id'] == songId);

    await songbookReference.update({'songs': existingSongs});
  }

  Future<void> deleteSongbook(String? songbookId) {
    return _songbookCollection.doc(songbookId).delete();
  }

  Future<String> getFavoritesSongbookId() async {
    final favoritesSongbookQuery = await _songbookCollection
        .where('name', isEqualTo: 'Favorites')
        .limit(1)
        .get();

    if (favoritesSongbookQuery.docs.isNotEmpty) {
      return favoritesSongbookQuery.docs.first.id;
    } else {
      const newFavoritesSongbook = Songbook(
        name: 'Favorites',
        songs: [],
      );

      final newFavoritesSongbookRef =
          await createSongbook(newFavoritesSongbook);

      return newFavoritesSongbookRef.id;
    }
  }
}
