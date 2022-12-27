import 'package:get/state_manager.dart';
import 'package:music_player/screens/home/home_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Searchcontroller extends GetxController {
  final List<SongModel> allSongs = HomeScreen.song;
  late List<SongModel> foundSongs = [];
  String temp = '';
  List<SongModel> _results = [];

  @override
  void onInit() {
    foundSongs = allSongs;
    super.onInit();
  }

  void runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      _results = allSongs;
    } else {
      _results = allSongs
          .where(
            (name) => name.title.toLowerCase().contains(
                  enteredKeyword.toLowerCase(),
                ),
          )
          .toList();
    }
    foundSongs = _results;
    update();
  }
}