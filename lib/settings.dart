import 'package:flutter/material.dart';
import 'package:music_player/functions/app_colors.dart';
import 'package:music_player/functions/get_setting.dart';
import 'package:music_player/functions/resacn_function.dart';
import 'package:share_plus/share_plus.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return CmnBgdClor(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: (() {
                Navigator.pop(context);
              }),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: ListView(
            children: [
              ListTile(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(15.0)),
                      ),
                      builder: (context) {
                        return const ScanScreen();
                      });
                },
                leading: IconButton(
                  onPressed: (() {}),
                  icon: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                ),
                title: const Text(
                  'Rescan',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                onTap: () {
                  linkShare();
                },
                leading: IconButton(
                  onPressed: (() {
                    linkShare();
                  }),
                  icon: const Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                ),
                title: const Text(
                  'Share',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                onTap: () {
                  GetSettings.feedBack();
                },
                leading: IconButton(
                  onPressed: (() {
                    GetSettings.feedBack();
                  }),
                  icon: const Icon(
                    Icons.list_alt_rounded,
                    color: Colors.white,
                  ),
                ),
                title: const Text(
                  'Feedback',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                onTap: () {},
                leading: IconButton(
                  onPressed: (() {}),
                  icon: const Icon(
                    Icons.star_border_rounded,
                    color: Colors.white,
                  ),
                ),
                title: const Text(
                  'Rate App',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  GetSettings.about();
                },
                leading: IconButton(
                  onPressed: (() {
                    GetSettings.about();
                  }),
                  icon: const Icon(
                    Icons.info_outline,
                    color: Colors.white,
                  ),
                ),
                title: const Text(
                  'About Developer',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: height / 2.5,
              ),
              const Center(
                child: Text(
                  'v 1.0.0',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  linkShare() async {
    const appLink = '';
    await Share.share(appLink);
  }
}



// Future<void> reStart() async {
//   final musicDb = Hive.box<int>('LikedSongsDB');
//   final playListDB = await Hive.openBox<Playlistmodel>('playlist_db');
//   await playListDB.clear();
//   await musicDb.clear();
// }
