import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/db/liked_songs_db.dart';
import 'package:music_player/view/home/ui/gridview.dart';
import 'package:music_player/view/home/ui/home_screen.dart';
import 'package:music_player/view/playing_music/play_music.dart';
import 'package:music_player/view/settings/settings.dart';
import 'package:music_player/widgets/songstorage.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class InitController extends GetxController {
  static List<SongModel> song = [];
  final LikedSongDB _db = Get.put(LikedSongDB());

  @override
  void onInit() {
    super.onInit();
    requestPermission();
  }

  void requestPermission() {
    Permission.storage.request();
    update();
  }

  nextPage(int index, List<SongModel> item) {
    Songstorage.player.setAudioSource(
      Songstorage.createSongList(item),
      initialIndex: index,
    );
    Songstorage.player.play();
    Get.to(
      () => PlayMusic(
        songModel: item,
      ),
    );
    update();
  }

  settingsPage() {
    Get.to(
      () => const Settings(),
    );
    update();
  }

  design(
    item,
  ) {
    if (item == null) {
      update();
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (item!.isEmpty) {
      update();
      return const Center(
        child: Text(
          'No Songs Found',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
    HomeScreen.song = item!;
    Songstorage.playingSongs = item!;
    if (!_db.isInitialized) {
      _db.initialise(item!);
    }
    Songstorage.songCopy = item!;
    update();
    return GetBuilder<InitController>(
      builder: (controller) {
        return HomeGridViewWidget(item: item!);
        update();
      },
    );
  }
}

