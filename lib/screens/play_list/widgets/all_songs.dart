import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/db/music_db.dart';
import 'package:music_player/functions/color/app_colors.dart';
import 'package:music_player/widgets/songstorage.dart';
import 'package:music_player/screens/playing_music/play_music.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlaylistAllSongs extends StatefulWidget {
  static List<SongModel> allSongs = [];
  const PlaylistAllSongs({Key? key, required this.playlist}) : super(key: key);
  final Playlistmodel playlist;

  @override
  State<PlaylistAllSongs> createState() => _PlaylistAllSongsState();
}

class _PlaylistAllSongsState extends State<PlaylistAllSongs> {
//  double playerMinHeight=70;

  final _audioQuery = OnAudioQuery();
  static final _audioPlayer = AudioPlayer();

  playsong(String? uri) {
    try {
      _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      _audioPlayer.play();
    } on Exception {
      log('Song Parsing is Error');
    }
  }

  @override
  void initState() {
    super.initState();
    requestPermission();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void requestPermission() {
    Permission.storage.request();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return CmnBgdClor(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Center(child: Text(widget.playlist.name)),
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
                                      color: const Color.fromARGB(
                                          255, 74, 154, 191),
                                      height: height / 15,
                                      width: width / 8,
                                      child: const Icon(
                                        Icons.music_note,
                                        color: Colors.white,
                                      ),
                                    )),
                              ),
                              onTap: () {
                                Songstorage.player.setAudioSource(
                                    Songstorage.createSongList(item.data!),
                                    initialIndex: index);
                                Songstorage.player.play();
                                setState(() {});
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PlayMusic(
                                          songModel: item.data!,
                                        )));
                              },
                              title: Text(
                                item.data![index].displayNameWOExt,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                  item.data![index].artist.toString(),
                                  style: const TextStyle(color: Colors.white)),
                              trailing: IconButton(
                                icon: !widget.playlist
                                        .isValueIn(item.data![index].id)
                                    ? const Icon(
                                        Icons.playlist_add_outlined,
                                      )
                                    : const Icon(Icons.close_rounded),
                                color: !widget.playlist
                                        .isValueIn(item.data![index].id)
                                    ? Colors.white
                                    : Colors.white,
                                onPressed: () {
                                  setState(() {
                                    widget.playlist.add(index);
                                    playlistCheck(item.data![index]);
                                  });
                                },
                              ),
                            );
                          }),
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }

  void playlistCheck(SongModel data) {
    if (!widget.playlist.isValueIn(data.id)) {
      widget.playlist.add(data.id);
      const snackbar = SnackBar(
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(8),
        content: Text(
          'Added to Playlist',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.blueGrey),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
      widget.playlist.deleteData(data.id);
      const snackbar = SnackBar(
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(8),
        content: Text(
          'Song Removed From Playlist',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.blueGrey,
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
}
