import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/db/music_db.dart';
import 'package:music_player/db/controller/playlist_db.dart';
import 'package:music_player/functions/color/app_colors.dart';
import 'package:music_player/screens/play_list/widgets/songs.dart';

class PlayListScreen extends StatefulWidget {
  const PlayListScreen({Key? key}) : super(key: key);

  @override
  State<PlayListScreen> createState() => _PlayListScreenState();
}

final nameController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _PlayListScreenState extends State<PlayListScreen> {
  PlaylistController _controller = Get.put(PlaylistController());
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    FocusManager.instance.primaryFocus?.unfocus();
    return ValueListenableBuilder(
      valueListenable: Hive.box<Playlistmodel>('playlistDB').listenable(),
      builder:
          (BuildContext context, Box<Playlistmodel> musicList, Widget? child) {
        return CmnBgdClor(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: const Text(
                  'Playlist',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                actions: [
                  FloatingActionButton(
                    elevation: 0,
                    splashColor: Colors.black,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // playlistnotifier.notifyListeners();

                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: SizedBox(
                              height: height / 3,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Center(
                                      child: Text(
                                        'Create Your Playlist',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Form(
                                      key: _formKey,
                                      child: TextFormField(
                                        controller: nameController,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: ' Playlist Name'),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Please enter playlist name";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: height / 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          width: 100.0,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.blueGrey),
                                            onPressed: () {
                                              nameController.clear();
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              'Cancel',
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 100.0,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.blueGrey),
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                whenButtonClicked();
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: const Text(
                                              'Save',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
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
                  child: Hive.box<Playlistmodel>('playlistDB').isEmpty
                      ? Center(
                          child: SizedBox(
                            height: height,
                            width: width,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Text(
                                    'Add your Playlist      ',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: height / 5,
                                  ),
                                  Lottie.asset(
                                    'assets/images/23143-walking-man.json',
                                    height: height / 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 5,
                          ),
                          itemCount: musicList.length,
                          itemBuilder: (context, index) {
                            final data = musicList.values.toList()[index];
                            return ValueListenableBuilder(
                              valueListenable:
                                  Hive.box<Playlistmodel>('playlistDB')
                                      .listenable(),
                              builder: (BuildContext context,
                                  Box<Playlistmodel> musicList, Widget? child) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => PlaylistData(
                                            playlist: data, folderIndex: index),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Card(
                                      color: Colors.white,
                                      elevation: 0,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
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
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          data.name,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
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
                                                                child:
                                                                    const Text(
                                                                  'No',
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                    context,
                                                                  );
                                                                },
                                                              ),
                                                              TextButton(
                                                                child:
                                                                    const Text(
                                                                        'Yes'),
                                                                onPressed: () {
                                                                  musicList
                                                                      .deleteAt(
                                                                    index,
                                                                  );
                                                                  Navigator.pop(
                                                                      context);
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
                          },
                        ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> whenButtonClicked() async {
    final name = nameController.text.trim();
    if (name.isEmpty) {
      return;
    } else {
      final music = Playlistmodel(name: name, songid: []);
      _controller.playlistAdd(music);
      nameController.clear();
    }
  }
}
