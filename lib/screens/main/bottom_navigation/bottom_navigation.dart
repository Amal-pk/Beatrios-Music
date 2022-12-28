// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, must_be_immutable, unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/db/liked_songs_db.dart';
import 'package:music_player/functions/color/app_colors.dart';
import 'package:music_player/widgets/songstorage.dart';
import 'package:music_player/screens/home/home_screen.dart';
import 'package:music_player/screens/like_songs/liked_songs.dart';
import 'package:music_player/screens/play_list/play_list.dart';
import 'package:music_player/screens/playing_music/mini_screen.dart';
import 'package:music_player/screens/search/search_screen.dart';

class BottomNavigator extends StatelessWidget {
  BottomNavigator({Key? key}) : super(key: key);

  RxInt currentIndex = 0.obs;
  final pages = [
    HomeScreen(),
    SearchScreen(),
    LikedSongs(),
    PlayListScreen(),
  ];
  LikedSongDB _db = Get.put(LikedSongDB());
  @override
  Widget build(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    return CmnBgdClor(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Obx((() => pages[currentIndex.value])),
        bottomNavigationBar: GetBuilder<LikedSongDB>(
          builder: ((controller) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (Songstorage.player.currentIndex != null)
                    Column(
                      children: const [
                        MiniScreen(),
                      ],
                    )
                  else
                    const SizedBox(),
                  Obx(
                    (() => BottomNavigationBar(
                          elevation: 0,
                          selectedItemColor: Colors.white,
                          unselectedItemColor: Colors.grey,
                          backgroundColor: Colors.transparent,
                          currentIndex: currentIndex.value,
                          onTap: (index) {
                            currentIndex.value = index;
                          },
                          type: BottomNavigationBarType.fixed,
                          items: const <BottomNavigationBarItem>[
                            BottomNavigationBarItem(
                              icon: Icon(Icons.home),
                              label: 'Home',
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(
                                Icons.search,
                              ),
                              label: 'Search',
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(
                                Icons.favorite,
                              ),
                              label: 'Like',
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(
                                Icons.library_music_rounded,
                              ),
                              label: 'Playlist',
                            ),
                          ],
                        )),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
