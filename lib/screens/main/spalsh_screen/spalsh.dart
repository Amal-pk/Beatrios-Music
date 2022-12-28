// ignore_for_file: prefer_final_fields, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/functions/color/app_colors.dart';
import 'package:music_player/screens/main/spalsh_screen/widgets/controller.dart';

class SpalshScreen extends StatelessWidget {
  SpalshScreen({Key? key}) : super(key: key);
  SpalshScreenController _controller = Get.put(SpalshScreenController());
  @override
  Widget build(BuildContext context) {
    _controller.onInit();
    return CmnBgdClor(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 4, 204, 191),
        body: Center(
          child: Image.asset(
            'assets/images/Beatrios_Music-removebg.png',
          ),
        ),
      ),
    );
  }
}
