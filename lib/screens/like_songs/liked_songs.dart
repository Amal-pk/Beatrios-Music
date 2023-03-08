// ignore_for_file: must_be_immutable, prefer_final_fields

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/screens/like_songs/controller/liked_songs_db_controller.dart';
import 'package:music_player/functions/color/app_colors.dart';
import 'package:music_player/screens/like_songs/widgets/list_view.dart';
import 'package:music_player/widgets/songstorage.dart';
import 'package:on_audio_query/on_audio_query.dart';

class LikedSongs extends StatelessWidget {
  LikedSongs({Key? key}) : super(key: key);

  final OnAudioQuery audioQuery = OnAudioQuery();
  LikedSongDB _db = Get.put(LikedSongDB());

  static ConcatenatingAudioSource createSongList(List<SongModel> song) {
    List<AudioSource> source = [];
    for (var songs in song) {
      source.add(AudioSource.uri(Uri.parse(songs.uri!)));
    }
    return ConcatenatingAudioSource(children: source);
  }

  playSong(String? uri) {
    try {
      Songstorage.player.setAudioSource(
        AudioSource.uri(
          Uri.parse(uri!),
        ),
      );
      Songstorage.player.play();
    } on Exception {
      log("Error Parssing song");
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return CmnBgdClor(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Liked Songs',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GetBuilder<LikedSongDB>(
            builder: (controller) {
              return Hive.box<int>('LikedSongsDB').isEmpty
                  ? Center(
                      child: SizedBox(
                        height: height,
                        width: width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'No Favorite Songs',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            // SizedBox(
                            //   height: height / 5,
                            // ),
                            Lottie.asset(
                              'assets/images/lf20_2jqib8ia.json',
                              height: height / 5,
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListViewLikedSongWidget(likeData: _db.likedsongs);
            },
          ),
        ),
      ),
    );
  }
}
