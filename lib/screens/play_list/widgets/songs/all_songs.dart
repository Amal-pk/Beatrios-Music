

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/db/controller/playlist_db.dart';
import 'package:music_player/db/music_db.dart';
import 'package:music_player/functions/buttons/playlist_button.dart';
import 'package:music_player/functions/color/app_colors.dart';
import 'package:music_player/screens/play_list/widgets/songs/controller.dart';
import 'package:music_player/widgets/songstorage.dart';
import 'package:music_player/screens/playing_music/play_music.dart';

import 'package:on_audio_query/on_audio_query.dart';

class PlaylistAllSongs extends StatelessWidget {
  static List<SongModel> allSongs = [];
  PlaylistAllSongs(
      {Key? key, required this.playlist, required this.folderIndex})
      : super(key: key);
  final Playlistmodel playlist;
  final int folderIndex;
  final _audioQuery = OnAudioQuery();


  // final _audioPlayer = AudioPlayer();
  // playsong(String? uri) {
  //   try {
  //     _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
  //     _audioPlayer.play();
  //   } on Exception {
  //     log('Song Parsing is Error');
  //   }
  // }

  PlaylistController _db = Get.put(PlaylistController());
  SongController _controller = Get.put(SongController());
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return CmnBgdClor(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Center(child: Text(playlist.name)),
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<SongModel>>(
                future: _audioQuery.querySongs(
                    sortType: null,
                    orderType: OrderType.ASC_OR_SMALLER,
                    uriType: UriType.EXTERNAL,
                    ignoreCase: true),
                builder: (context, item) {
                  if (item.data == null) {
                    return const Center(
                      child: Text(''),
                    );
                  }
                  if (item.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        'No Songs Found',
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  }
                  PlaylistAllSongs.allSongs = item.data!;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                      itemCount: item.data!.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(
                        height: 5,
                        thickness: 2,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: ClipRRect(
                            child: QueryArtworkWidget(
                              id: item.data![index].id,
                              artworkBorder: BorderRadius.circular(0),
                              type: ArtworkType.AUDIO,
                              artworkFit: BoxFit.cover,
                              nullArtworkWidget: Container(
                                color: const Color.fromARGB(255, 74, 154, 191),
                                height: height / 15,
                                width: width / 8,
                                child: const Icon(
                                  Icons.music_note,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            Songstorage.player.setAudioSource(
                                Songstorage.createSongList(item.data!),
                                initialIndex: index);
                            Songstorage.player.play();
                            Get.to(
                              () => PlayMusic(
                                songModel: item.data!,
                              ),
                            );
                          },
                          title: Text(
                            item.data![index].displayNameWOExt,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(item.data![index].artist.toString(),
                              style: const TextStyle(color: Colors.white)),
                          trailing: GetBuilder<PlaylistController>(
                            builder: ((controller) {
                              return PlaylistButton(
                                folderindex: folderIndex,
                                id: item.data![index].id,
                              );
                            }),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
