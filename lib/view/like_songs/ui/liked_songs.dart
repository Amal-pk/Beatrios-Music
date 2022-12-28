import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/db/liked_songs_db.dart';
import 'package:music_player/functions/color/app_colors.dart';
import 'package:music_player/view/like_songs/controller/controller.dart';
import 'package:music_player/view/like_songs/ui/list_view.dart';

class LikedSongs extends StatelessWidget {
  LikedSongs({Key? key}) : super(key: key);
  final LikedSongsController _controller = Get.put(LikedSongsController());
  final LikedSongDB _db = Get.put(LikedSongDB());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return CmnBgdClor(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            'F A V O R I T E',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GetBuilder<LikedSongDB>(
            builder: (controller) {
              return Hive.box<int>('LikedSongsDB').isEmpty
                  ? Center(
                      child: SizedBox(
                        height: height,
                        width: width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'No Favorite Songs',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Lottie.asset(
                              'assets/images/lf20_2jqib8ia.json',
                              height: height / 5,
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListViewLikedSongWidget(
                      likeData: _db.likedsongs,
                    );
            },
          ),
        ),
      ),
    );
  }
}
