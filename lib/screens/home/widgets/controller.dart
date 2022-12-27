import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class InitController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    requestPermission();
  }

  void requestPermission() {
    Permission.storage.request();
    update();
  }
}
