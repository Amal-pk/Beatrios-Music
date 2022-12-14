import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'package:on_audio_query/on_audio_query.dart';

class Songstorage extends GetxController {
  static AudioPlayer player = AudioPlayer();
  static int currentIndex = -1;
  static List<SongModel> songCopy = [];
  static List<SongModel> playingSongs = [];

  static ConcatenatingAudioSource createSongList(List<SongModel> songs) {
    List<AudioSource> source = [];
    playingSongs = songs;
    for (var song in songs) {
      source.add(
        AudioSource.uri(
          Uri.parse(song.uri!),
          tag: MediaItem(
            id: song.id.toString(),
            title: song.displayNameWOExt,
            album: song.album,
            artist: song.artist,
          ),
        ),
      );
    }
    return ConcatenatingAudioSource(children: source);
  }
}
