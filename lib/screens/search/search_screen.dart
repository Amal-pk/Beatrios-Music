import 'package:flutter/material.dart';
import 'package:music_player/functions/color/app_colors.dart';
import 'package:music_player/widgets/songstorage.dart';
import 'package:music_player/screens/home/home_screen.dart';
import 'package:music_player/screens/playing_music/play_music.dart';
import 'package:on_audio_query/on_audio_query.dart';

ValueNotifier<List<SongModel>> temp = ValueNotifier([]);

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);
  final searchController = TextEditingController();
  static List<SongModel> playSongs = [];

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final OnAudioQuery audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return CmnBgdClor(
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: TextField(
                onChanged: (String? value) {
                  if (value != null && value.isNotEmpty) {
                    temp.value.clear();
                    for (SongModel item in HomeScreen.song) {
                      if (item.title
                          .toLowerCase()
                          .contains(value.toLowerCase())) {
                        temp.value.add(item);
                      }
                    }
                    temp.notifyListeners();
                  }
                },
                decoration: InputDecoration(
                  fillColor: Colors.black,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.all(15),
                  hintText: 'Search',
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: temp,
                      builder: (BuildContext context, List<SongModel> songData,
                          Widget? child) {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider();
                          },
                          itemBuilder: (BuildContext context, int index) {
                            final datas = songData[index];
                            return ListTile(
                              leading: QueryArtworkWidget(
                                id: datas.id,
                                artworkBorder: const BorderRadius.all(
                                  Radius.circular(0),
                                ),
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: Container(
                                  height: height / 18,
                                  width: width / 8.6,
                                  color:
                                      const Color.fromARGB(255, 74, 154, 191),
                                  child: const Icon(
                                    Icons.music_note,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              title: Text(
                                datas.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                final searchIndex = creatSearchIndex(datas);
                                FocusScope.of(context).unfocus();
                                Songstorage.player.setAudioSource(
                                    Songstorage.createSongList(
                                      HomeScreen.song,
                                    ),
                                    initialIndex: searchIndex);
                                Songstorage.player.play();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlayMusic(
                                      songModel: HomeScreen.song,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          itemCount: temp.value.length,
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  int? creatSearchIndex(SongModel data) {
    for (int i = 0; i < HomeScreen.song.length; i++) {
      if (data.id == HomeScreen.song[i].id) {
        return i;
      }
    }
    return null;
  }
}
