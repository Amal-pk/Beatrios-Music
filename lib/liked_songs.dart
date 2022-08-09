import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/db/liked_songs_db.dart';
import 'package:music_player/functions/app_colors.dart';
import 'package:music_player/functions/songstorage.dart';
import 'package:music_player/home_screen.dart';
import 'package:music_player/playing_music/play_music.dart';
import 'package:on_audio_query/on_audio_query.dart';

class LikedSongs extends StatefulWidget {
  const LikedSongs({Key? key}) : super(key: key);

  @override
  State<LikedSongs> createState() => _LikedSongsState();
}

class _LikedSongsState extends State<LikedSongs> {
  final OnAudioQuery audioQuery = OnAudioQuery();

  static ConcatenatingAudioSource createSongList(List<SongModel> song) {
    List<AudioSource> source = [];
    for (var songs in song) {
      source.add(AudioSource.uri(Uri.parse(songs.uri!)));
    }
    return ConcatenatingAudioSource(children: source);
  }

  playSong(String? uri) {
    try {
      HomeScreen.audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(uri!),
        ),
      );
      HomeScreen.audioPlayer.play();
    } on Exception {
      log("Error Parssing song");
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return ValueListenableBuilder(
      valueListenable: LikedSongDB.likedsongs,
      builder: (BuildContext ctx, List<SongModel> likeData, Widget? child) {
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
              child: ValueListenableBuilder(
                valueListenable: LikedSongDB.likedsongs,
                builder: (BuildContext ctx, List<SongModel> likeData,
                    Widget? child) {
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
                      : ListView.builder(
                          itemCount: likeData.length,
                          itemBuilder: (ctx, index) {
                            return GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  onTap: () {
                                    List<SongModel> newList = [...likeData];
                                    setState(() {});
                                    Songstorage.player.stop();
                                    Songstorage.player.setAudioSource(
                                        Songstorage.createSongList(newList),
                                        initialIndex: index);
                                    Songstorage.player.play();
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => PlayMusic(
                                          songModel: newList,
                                        ),
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
                                      color: const Color.fromARGB(
                                          255, 74, 154, 191),
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
                                  trailing: IconButton(
                                    onPressed: (() {
                                      LikedSongDB.delete(likeData[index].id);
                                      setState(() {});
                                    }),
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
