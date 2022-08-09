import 'package:flutter/material.dart';
import 'package:music_player/db/liked_songs_db.dart';
import 'package:on_audio_query/on_audio_query.dart';

class LikedButton extends StatefulWidget {
  const LikedButton({Key? key, required this.song}) : super(key: key);
  final SongModel song;

  @override
  State<LikedButton> createState() => _LikedButtonState();
}

class _LikedButtonState extends State<LikedButton> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: LikedSongDB.likedsongs,
      builder: (BuildContext ctx, List<SongModel> likeData, Widget? child) {
        return IconButton(
          onPressed: () {
            if (LikedSongDB.islike(widget.song)) {
              LikedSongDB.delete(widget.song.id);
              LikedSongDB.likedsongs.notifyListeners();

              const snackBar = SnackBar(
                  backgroundColor: Colors.white,
                  content: Text(
                    'Removed From Favorite',
                    style: TextStyle(color: Colors.black),
                  ));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              LikedSongDB.add(widget.song);
              LikedSongDB.likedsongs.notifyListeners();
              const snackbar = SnackBar(
                backgroundColor: Colors.white,
                content: Text(
                  'Song Added to Favorite',
                  style: TextStyle(color: Colors.black),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }

            LikedSongDB.likedsongs.notifyListeners();
          },
          icon: LikedSongDB.islike(widget.song)
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
