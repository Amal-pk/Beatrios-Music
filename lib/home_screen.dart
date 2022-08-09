import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:music_player/db/liked_songs_db.dart';
import 'package:music_player/functions/app_colors.dart';
import 'package:music_player/functions/songstorage.dart';
import 'package:music_player/playing_music/play_music.dart';
import 'package:music_player/settings.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:just_audio/just_audio.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static List<SongModel> song = [];
  static AudioPlayer audioPlayer = AudioPlayer();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _audioQuery = OnAudioQuery();

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  void requestPermission() async {
    await Permission.storage.request();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return CmnBgdClor(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Music Store',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: (() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Settings(),
                  ),
                );
              }),
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        body: FutureBuilder<List<SongModel>>(
            future: _audioQuery.querySongs(
                orderType: OrderType.ASC_OR_SMALLER,
                sortType: null,
                uriType: UriType.EXTERNAL,
                ignoreCase: true),
            builder: (context, item) {
              if (item.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (item.data!.isEmpty) {
                return const Center(
                  child: Text(
                    'No Songs Found',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              }
              HomeScreen.song = item.data!;
              Songstorage.playingSongs = item.data!;
              if (!LikedSongDB.isInitialized) {
                LikedSongDB.initialise(item.data!);
              }
              Songstorage.songCopy = item.data!;

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                scrollDirection: Axis.vertical,
                itemCount: item.data!.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  return GestureDetector(
                    onTap: () {
                      Songstorage.player.setAudioSource(
                          Songstorage.createSongList(item.data!),
                          initialIndex: index);
                      Songstorage.player.play();
                      setState(() {});
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlayMusic(
                            songModel: item.data!,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 16, left: 16, right: 8),
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          item.data![index].displayNameWOExt,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          maxLines: 1,
                                        ),
                                        Text(
                                          item.data![index].artist.toString(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: QueryArtworkWidget(
                                artworkBorder: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                id: item.data![index].id,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: Card(
                                  color: Color.fromARGB(255, 74, 154, 191),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Icon(
                                    Icons.music_note_rounded,
                                    size: width / 8,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
