// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/db/music_db.dart';

ValueNotifier<List<Playlistmodel>> playlistnotifier = ValueNotifier([]);

Future<void> playlistAdd(Playlistmodel value) async {
  final playListDb = Hive.box<Playlistmodel>('playlistDB');
  await playListDb.add(value);

  playlistnotifier.value.add(value);
}

Future<void> getAllPlaylist() async {
  final playListDb = Hive.box<Playlistmodel>('playlistDB');
  playlistnotifier.value.clear();
  playlistnotifier.value.addAll(playListDb.values);

  playlistnotifier.notifyListeners();
}

Future<void> playlistDelete(int index) async {
  final playListDb = Hive.box<Playlistmodel>('playlistDB');
  await playListDb.deleteAt(index);
  getAllPlaylist();
}

// Future<void> appReset(context) async {
//   final playListDb = Hive.box<Playlistmodel>('playlistDB');
//   final musicDb = Hive.box<int>('favoriteDB');
//   await musicDb.clear();
//   await playListDb.clear();
//   FavoriteDB.favoriteSongs.value.clear();
//   Navigator.of(context).pushAndRemoveUntil(
//       MaterialPageRoute(
//         builder: (context) => const SplashScreen(),
//       ),
//       (route) => false);
// }