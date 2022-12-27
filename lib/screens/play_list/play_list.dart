// ignore_for_file: prefer_final_fields, must_be_immutable, unused_field

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/db/music_db.dart';
import 'package:music_player/db/controller/playlist_db.dart';
import 'package:music_player/functions/color/app_colors.dart';
import 'package:music_player/screens/play_list/widgets/styles/playlist_empty_screen.dart';
import 'package:music_player/screens/play_list/widgets/styles/playlist_gridview.dart';
import 'package:music_player/screens/play_list/widgets/styles/show_dialog.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayListScreen extends StatelessWidget {
  PlayListScreen({Key? key}) : super(key: key);

  PlaylistController _controller = Get.put(PlaylistController());

  @override
  Widget build(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    return GetBuilder<PlaylistController>(
      builder: (controller) {
        return CmnBgdClor(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: const Text(
                  'P L A Y L I S T ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                actions: [
                  FloatingActionButton(
                    elevation: 0,
                    splashColor: Colors.black,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return PlaylistShowDialog();
                        },
                      );
                    },
                    backgroundColor: Colors.transparent,
                    child: const Icon(Icons.add),
                  )
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: SafeArea(
                  child: GetBuilder<PlaylistController>(
                    builder: ((controller) {
                      final musicList = _controller.playlistnotifier;
                      return musicList.isEmpty
                          ? const PlaylistEmptyScreenWidget()
                          : PlaylistGridViewWidget(
                              musicList: musicList,
                            );
                    }),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
