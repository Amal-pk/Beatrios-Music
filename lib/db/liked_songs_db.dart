// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LikedSongDB {
  static bool isInitialized = false;
  static final musicDb = Hive.box<int>('LikedSongsDB');
  static ValueNotifier<List<SongModel>> likedsongs = ValueNotifier([]);
  static initialise(List<SongModel> songs) {
    for (SongModel song in songs) {
      if (islike(song)) {
        likedsongs.value.add(song);
      }
    }
    isInitialized = true;
  }

  static add(SongModel song) async {
    musicDb.add(song.id);
    likedsongs.value.add(song);
    // ignore: invalid_use_of_protected_member
    LikedSongDB.likedsongs.notifyListeners();
  }

  static delete(int id) async {
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
  }

  static bool islike(SongModel song) {
    if (musicDb.values.contains(song.id)) {
      return true;
    }
    return false;
  }
}
