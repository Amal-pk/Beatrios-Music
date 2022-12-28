import 'dart:async';
import 'package:get/get.dart';
import 'package:music_player/view/main/bottom_navigation/bottom_navigation.dart';

class SpalshScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    timer();
  }

  void timer() {
    Timer(
      const Duration(seconds: 3),
      () => Get.offAll(() => BottomNavigator()),
    );
    update();
  }
}
