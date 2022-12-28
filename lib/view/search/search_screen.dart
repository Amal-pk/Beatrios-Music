import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/functions/color/app_colors.dart';
import 'package:music_player/view/playing_music/play_music.dart';
import 'package:music_player/view/search/controller/search_controller.dart';
import 'package:music_player/widgets/songstorage.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final Searchcontroller _searchcontroller = Get.put(Searchcontroller());
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return CmnBgdClor(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    autofocus: true,
                    onChanged: (value) {
                      _searchcontroller.runFilter(value);
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.all(15),
                      hintText: 'Search',
                      suffixIcon: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: _searchcontroller.foundSongs.isNotEmpty
                      ? GetBuilder<Searchcontroller>(
                          builder: (controller) => ListView.builder(
                            itemCount: _searchcontroller.foundSongs.length,
                            itemBuilder: (context, index) => Card(
                              key: ValueKey(
                                  _searchcontroller.foundSongs[index].id),
                              // color: Colors.white,
                              elevation: 4,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                leading: QueryArtworkWidget(
                                  id: _searchcontroller.foundSongs[index].id,
                                  artworkBorder: BorderRadius.circular(0),
                                  type: ArtworkType.AUDIO,
                                  artworkFit: BoxFit.cover,
                                  nullArtworkWidget: Container(
                                    color:
                                        const Color.fromARGB(255, 74, 154, 191),
                                    height: height / 15,
                                    width: width / 8,
                                    child: const Icon(
                                      Icons.music_note,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                title: Text(
                                    _searchcontroller.foundSongs[index].title),
                                onTap: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  Songstorage.player.play();
                                  Songstorage.player.setAudioSource(
                                      Songstorage.createSongList(
                                          _searchcontroller.foundSongs),
                                      initialIndex: index);
                                  Get.to(
                                    PlayMusic(
                                      songModel: _searchcontroller.foundSongs,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        )
                      : const Text(
                          'No Songs found',
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
