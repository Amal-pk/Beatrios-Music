// import 'package:get/get.dart';
// import 'package:music_player/functions/songstorage.dart';

// class PlayMusicController extends GetxController {
//   RxBool _isPlaying = false.obs;
//   RxInt currentindex = 0.obs;
//   @override
//   void onInit() {
//     Songstorage.player.currentIndexStream.listen((index) {
//       if (index != null && mounted) {
//         currentindex.value = index;

//         Songstorage.currentIndex = index;
//       }
//     });
//     super.onInit();
//   }
// }
