// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/db/music_db.dart';

class PlaylistController extends GetxController {
  ValueNotifier<List<Playlistmodel>> playlistnotifier = ValueNotifier([]);

  playlistAdd(Playlistmodel value) {
    final playListDb = Hive.box<Playlistmodel>('playlistDB');
    playListDb.add(value);
    playlistnotifier.value.add(value);
    update();
  }

  getAllPlaylist() {
    final playListDb = Hive.box<Playlistmodel>('playlistDB');
    playlistnotifier.value.clear();
    playlistnotifier.value.addAll(playListDb.values);
    update();
    playlistnotifier.notifyListeners();
  }

  playlistDelete(int index) {
    final playListDb = Hive.box<Playlistmodel>('playlistDB');
    playListDb.deleteAt(index);
    getAllPlaylist();
    update();
  }
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