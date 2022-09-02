import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/widgets/songstorage.dart';
import 'package:music_player/screens/playing_music/play_music.dart';
import 'package:music_player/screens/home/widgets/card_style.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeGridViewWidget extends StatelessWidget {
  final List<SongModel> item;
  const HomeGridViewWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      scrollDirection: Axis.vertical,
      itemCount: item.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, index) {
        return GestureDetector(
          onTap: () {
            Songstorage.player.setAudioSource(Songstorage.createSongList(item),
                initialIndex: index);
            Songstorage.player.play();
            Get.to(
              () => PlayMusic(
                songModel: item,
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 8),
            child: HomeCardStyle(
              item: item[index],
            ),
          ),
        );
      },
    );
  }
}
