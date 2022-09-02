// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LikedSongDB extends GetxController {
  bool isInitialized = false;
  final musicDb = Hive.box<int>('LikedSongsDB');
  ValueNotifier<List<SongModel>> likedsongs = ValueNotifier([]);
  initialise(List<SongModel> songs) {
    for (SongModel song in songs) {
      if (islike(song)) {
        likedsongs.value.add(song);
      }
    }
    isInitialized = true;
  }

  add(SongModel song) {
    musicDb.add(song.id);
    likedsongs.value.add(song);
    // ignore: invalid_use_of_protected_member
    // LikedSongDB.likedsongs.notifyListeners();
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
    likedsongs.value.removeWhere((song) => song.id == id);
    update();
  }

  bool islike(SongModel song) {
    if (musicDb.values.contains(song.id)) {
      return true;
    }
    return false;
  }
}
