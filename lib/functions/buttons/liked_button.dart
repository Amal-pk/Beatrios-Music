// ignore_for_file: must_be_immutable, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/db/liked_songs_db.dart';
import 'package:on_audio_query/on_audio_query.dart';

class LikedButton extends StatelessWidget {
  LikedButton({Key? key, required this.song}) : super(key: key);
  final SongModel song;

  LikedSongDB _db = Get.put(LikedSongDB());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LikedSongDB>(
      builder: (controller) {
        return IconButton(
          onPressed: () {
            if (_db.islike(song)) {
              _db.delete(song.id);
              // LikedSongDB.likedsongs.notifyListeners();

              const snackBar = SnackBar(
                  backgroundColor: Colors.white,
                  content: Text(
                    'Removed From Favorite',
                    style: TextStyle(color: Colors.black),
                  ));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              _db.add(song);
              // LikedSongDB.likedsongs.notifyListeners();
              const snackbar = SnackBar(
                backgroundColor: Colors.white,
                content: Text(
                  'Song Added to Favorite',
                  style: TextStyle(color: Colors.black),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }

            // LikedSongDB.likedsongs.notifyListeners();
          },
          icon: _db.islike(song)
              ? const Icon(
                  Icons.favorite,
                  color: Colors.white,
                )
              : const Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                ),
        );
      },
    );
  }
}
