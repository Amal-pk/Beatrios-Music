import 'package:get/get.dart';
import 'package:music_player/widgets/songstorage.dart';

class MiniPlayerController extends GetxController{
  @override
  void onInit() {
     Songstorage.player.currentIndexStream.listen((index) {
      if (index != null) {
      }
    });
    super.onInit();
  }
}