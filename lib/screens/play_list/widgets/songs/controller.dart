import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/db/music_db.dart';
import 'package:music_player/widgets/songstorage.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class SongController extends GetxController {
  late List<SongModel> playlistSong;
  late Playlistmodel playlist;

  @override
  void onInit() {
    requestPermission();
    FocusManager.instance.primaryFocus?.unfocus();
    super.onInit();
  }

  void requestPermission() {
    Permission.storage.request();
  }
}
