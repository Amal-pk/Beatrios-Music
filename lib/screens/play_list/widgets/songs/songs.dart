import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/db/controller/playlist_db.dart';
import 'package:music_player/db/music_db.dart';
import 'package:music_player/functions/buttons/playlist_button.dart';
import 'package:music_player/functions/color/app_colors.dart';
import 'package:music_player/screens/play_list/widgets/songs/controller.dart';
import 'package:music_player/widgets/songstorage.dart';
import 'package:music_player/screens/playing_music/play_music.dart';
import 'package:music_player/screens/play_list/widgets/songs/all_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistData extends StatelessWidget {
  PlaylistData({Key? key, required this.playlist, required this.folderIndex})
      : super(key: key);
  final Playlistmodel playlist;
  final int folderIndex;
  SongController _songController = Get.put(SongController());
  PlaylistController _controller = Get.put(PlaylistController());

  late List<SongModel> playlistSong;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return CmnBgdClor(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: (() {
              Navigator.of(context).pop();
            }),
            icon: const Icon(Icons.arrow_back),
          ),
          title: Center(
            child: Text(playlist.name),
          ),
          actions: [
            IconButton(
              onPressed: (() {
                Get.to(
                  () => PlaylistAllSongs(
                    playlist: playlist,
                    folderIndex: folderIndex,
                  ),
                );
              }),
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GetBuilder<PlaylistController>(
            builder: (controller) {
              playlistSong = _controller.playListSongs;
              return playlistSong.isEmpty
                  ? Center(
                      child: SizedBox(
                        height: height,
                        width: width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'No Songs',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            Lottie.asset(
                              'assets/images/107575-ai-music-animation.json',
                              height: height / 2,
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.separated(
                      itemCount: playlistSong.length,
                      separatorBuilder: (ctx, index) {
                        return const Divider();
                      },
                      itemBuilder: (ctx, index) {
                        return ListTile(
                          onTap: () {
                            List<SongModel> newList = [...playlistSong];

                            // setState(() {
                            // Songstorage.player.stop();
                            Songstorage.player.setAudioSource(
                                Songstorage.createSongList(newList),
                                initialIndex: index);
                            Songstorage.player.play();
                            // });
                            Get.to(
                              () => PlayMusic(
                                songModel: newList,
                              ),
                            );
                          },
                          leading: QueryArtworkWidget(
                            artworkBorder: BorderRadius.circular(0),
                            id: playlistSong[index].id,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: Container(
                              color: const Color.fromARGB(255, 74, 154, 191),
                              width: width / 8,
                              height: height / 15,
                              child: const Icon(
                                Icons.music_note,
                                color: Colors.white,
                              ),
                            ),
                            errorBuilder: (context, exception, gdb) {
                              // setState(() {});
                              return const Text('data');
                            },
                          ),
                          title: Text(
                            playlistSong[index].title,
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            playlistSong[index].artist!,
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: GetBuilder<PlaylistController>(
                            builder: ((controller) {
                              return PlaylistButton(
                                folderindex: folderIndex,
                                id: playlistSong[index].id,
                              );
                            }),
                          ),
                        );
                      },
                    );
            },
          ),
        ),
      ),
    );
  }

  // List<SongModel> listPlaylist(List<int> data) {
  //   List<SongModel> plsongs = [];
  //   for (int i = 0; i < Songstorage.songCopy.length; i++) {
  //     for (int j = 0; j < data.length; j++) {
  //       if (Songstorage.songCopy[i].id == data[j]) {
  //         plsongs.add(Songstorage.songCopy[i]);
  //       }
  //     }
  //   }
  //   return plsongs;
  // }

  // void playlistCheck(SongModel data) {
  //   if (!playlist.isValueIn(data.id)) {
  //     playlist.add(data.id);
  //     Get.snackbar(
  //       "",
  //       "Added to \t${playlist.name}",
  //       backgroundColor: Colors.white,
  //     );
  //   } else {
  //     playlist.deleteData(data.id);
  //     Get.snackbar(
  //       "",
  //       "Song Removed From\t${playlist.name}",
  //       backgroundColor: Colors.white,
  //     );
  //   }
  // }
}
