// ignore_for_file: prefer_final_fields, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/controller/playlist_db.dart';
import 'package:music_player/db/music_db.dart';
import 'package:music_player/screens/play_list/widgets/songs/songs.dart';

class PlaylistGridViewWidget extends StatelessWidget {
  PlaylistGridViewWidget({super.key, required this.musicList});

  final List<Playlistmodel> musicList;

  PlaylistController _controller = Get.put(PlaylistController());

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 5,
      ),
      itemCount: musicList.length,
      itemBuilder: (context, index) {
        final data = musicList[index];
        return GestureDetector(
          onTap: () {
            Get.to(
              () => PlaylistData(playlist: data, folderIndex: index),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Card(
              color: Colors.white,
              elevation: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image.asset(
                      'assets/images/music.jpg',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.name,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            icon: const Icon(
                              Icons.delete_outlined,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text(
                                      'Delete Playlist',
                                    ),
                                    content: const Text(
                                        'Are you sure you want to delete this playlist?'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text(
                                          'No',
                                        ),
                                        onPressed: () {
                                          Navigator.pop(
                                            context,
                                          );
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('Yes'),
                                        onPressed: () {
                                          _controller.playlistDelete(
                                            index,
                                          );
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
