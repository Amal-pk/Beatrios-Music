import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/db/liked_songs_db.dart';
import 'package:music_player/functions/buttons/liked_button.dart';
import 'package:music_player/screens/playing_music/play_music.dart';
import 'package:music_player/widgets/songstorage.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ListViewLikedSongWidget extends StatelessWidget {
  const ListViewLikedSongWidget({super.key, required this.likeData});
  final List<SongModel> likeData;
  @override
  Widget build(BuildContext context) {
    LikedSongDB _db = Get.put(LikedSongDB());

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return ListView.builder(
      itemCount: likeData.length,
      itemBuilder: (ctx, index) {
        return GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              onTap: () {
                List<SongModel> newList = [...likeData];
                // setState(() {});
                Songstorage.player.stop();
                Songstorage.player.setAudioSource(
                    Songstorage.createSongList(newList),
                    initialIndex: index);
                Songstorage.player.play();
                Get.to(
                  () => PlayMusic(
                    songModel: newList,
                  ),
                );
              },
              leading: QueryArtworkWidget(
                id: likeData[index].id,
                type: ArtworkType.AUDIO,
                artworkBorder: const BorderRadius.all(
                  Radius.circular(0),
                ),
                artworkHeight: height / 8,
                artworkWidth: width / 6,
                nullArtworkWidget: Container(
                  height: height / 8,
                  width: width / 6,
                  color: const Color.fromARGB(255, 74, 154, 191),
                  child: const Icon(
                    Icons.music_note_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
              title: Text(
                likeData[index].title,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              trailing: GetBuilder<LikedSongDB>(
                builder: (controller) => LikedButton(song: likeData[index]),
              ),
            ),
          ),
        );
      },
    );
  }
}
