import 'package:get/get.dart';
import 'package:music_player/widgets/songstorage.dart';

class PlayScreenController extends GetxController {
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    Songstorage.player.currentIndexStream.listen((index) {
      if (index != null) {
        currentIndex.value = index;

        Songstorage.currentIndex = index;
      }
    });

    super.onInit();
  }
}
