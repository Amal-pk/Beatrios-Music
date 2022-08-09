// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:music_player/db/liked_songs_db.dart';
import 'package:music_player/functions/app_colors.dart';
import 'package:music_player/functions/songstorage.dart';
import 'package:music_player/home_screen.dart';
import 'package:music_player/liked_songs.dart';
import 'package:music_player/play_list.dart';
import 'package:music_player/playing_music/mini_screen.dart';
import 'package:music_player/search_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int currentIndex = 0;
  final pages = [
    const HomeScreen(),
    SearchScreen(),
    const LikedSongs(),
    const PlayListScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    return CmnBgdClor(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: ValueListenableBuilder(
          valueListenable: LikedSongDB.likedsongs,
          builder:
              (BuildContext context, List<SongModel> music, Widget? child) {
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
                BottomNavigationBar(
                  elevation: 0,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.blueGrey,
                  backgroundColor: Colors.transparent,
                  currentIndex: currentIndex,
                  onTap: (index) {
                    setState(() {
                      currentIndex = index;
                      LikedSongDB.likedsongs.notifyListeners();
                    });
                  },
                  type: BottomNavigationBarType.fixed,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.search,
                        ),
                        label: 'Search'),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.favorite,
                        ),
                        label: 'Like'),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.library_music_rounded,
                        ),
                        label: 'Playlist'),
                  ],
                ),
              ],
            ));
          }),
    ));
  }
}
