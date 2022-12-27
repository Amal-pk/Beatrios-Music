// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:get/get.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/db/music_db.dart';
import 'package:music_player/widgets/songstorage.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistController extends GetxController {
  @override
  void onInit() {
    getAllPlaylist();
    super.onInit();
  }

  List<Playlistmodel> playlistnotifier = [];
  List<SongModel> playListSongs = [];

  final playListDb = Hive.box<Playlistmodel>('playlistDB');

  playlistAdd(Playlistmodel value) {
    playListDb.add(value);
    // playlistnotifier.value.add(value);
    getAllPlaylist();
    update();
  }

  getAllPlaylist() {
    playlistnotifier.clear();
    playlistnotifier.addAll(playListDb.values);
    update();
    // playlistnotifier.notifyListeners();
  }

  playlistDelete(int index) {
    playListDb.deleteAt(index);
    getAllPlaylist();
    update();
  }

  playlistUpate(index, value) {
    playListDb.putAt(index, value);
    getAllPlaylist();
    print('object');
    listPlaylist(index);
    update();
  }

  listPlaylist(index) {
    final data = playlistnotifier[index].songid;
    playListSongs.clear();
    for (int i = 0; i < Songstorage.songCopy.length; i++) {
      for (int j = 0; j < data.length; j++) {
        if (Songstorage.songCopy[i].id == data[j]) {
          playListSongs.add(Songstorage.songCopy[i]);
          // print(playListSongs);
        }
      }
    }
    update();
    return playListSongs;
  }
  // bool isValueIn(int id) {
  //   update();
  //   return playlistnotifier.contains(id);
  // }
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