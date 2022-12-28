import 'package:get/get.dart';
import 'package:music_player/db/liked_songs_db.dart';
import 'package:music_player/functions/buttons/liked_button.dart';
import 'package:music_player/view/playing_music/play_music.dart';
import 'package:music_player/widgets/songstorage.dart';
import 'package:on_audio_query/on_audio_query.dart';

class LikedSongsController extends GetxController {
  nextPage(index, List<SongModel> likeData) {
    List<SongModel> newList = [...likeData];
    Songstorage.player.stop();
    Songstorage.player.setAudioSource(
      Songstorage.createSongList(newList),
      initialIndex: index,
    );
    Songstorage.player.play();
    Get.to(
      () => PlayMusic(
        songModel: newList,
      ),
    );
    update();
  }

  button(index, List<SongModel> likeData) {
    GetBuilder<LikedSongDB>(
      builder: (controller) => LikedButton(song: likeData[index]),
    );
    update();
  }
}
