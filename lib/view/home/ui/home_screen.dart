// ignore_for_file: prefer_final_fields, must_be_immutable, override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/view/home/controller/controller.dart';
import 'package:music_player/functions/color/app_colors.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  static List<SongModel> song = [];
  InitController _controller = Get.put(InitController());
  @override
  final _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    _controller.onInit();
    return CmnBgdClor(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            'M u s i c  S t o r e',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: (() {
                _controller.settingsPage();
              }),
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        body: FutureBuilder<List<SongModel>>(
          future: _audioQuery.querySongs(
              orderType: OrderType.ASC_OR_SMALLER,
              sortType: null,
              uriType: UriType.EXTERNAL,
              ignoreCase: true),
          builder: (context, item) {
            return _controller.design(item.data);
          },
        ),
      ),
    );
  }
}
