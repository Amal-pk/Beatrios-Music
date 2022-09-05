import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LikedSongDB extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  bool isInitialized = false;
  final musicDb = Hive.box<int>('LikedSongsDB');
  List<SongModel> likedsongs = [];
  initialise(List<SongModel> songs) {
    for (SongModel song in songs) {
      if (islike(song)) {
        likedsongs.add(song);
      }
    }
    isInitialized = true;
  }

  add(SongModel song) {
    musicDb.add(song.id);
    likedsongs.add(song);
    update();
  }

  delete(int id) async {
    int deleted = 0;
    if (!musicDb.values.contains(id)) {
      return;
    }
    final Map<dynamic, int> likemap = musicDb.toMap();
    likemap.forEach(
      (key, value) {
        if (value == id) {
          deleted = key;
        }
      },
    );
    musicDb.delete(deleted);
    likedsongs.removeWhere((song) => song.id == id);
    update();
  }

  bool islike(SongModel song) {
    return musicDb.values.contains(song.id);
  }
}
