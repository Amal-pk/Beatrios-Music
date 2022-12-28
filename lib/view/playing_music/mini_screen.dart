import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/view/playing_music/widgets/mini_controller.dart';
import 'package:music_player/widgets/animated_text.dart';
import 'package:music_player/widgets/songstorage.dart';
import 'package:music_player/view/playing_music/play_music.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MiniScreen extends StatelessWidget {
 MiniScreen({Key? key}) : super(key: key);

  // void initState() {
  //   Songstorage.player.currentIndexStream.listen((index) {
  //     if (index != null && mounted) {
  //     }
  //   });
  //   super.initState();
  // }

  final MiniPlayerController _miniPlayerController =
      Get.put(MiniPlayerController());

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: Colors.transparent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      //height: MediaQuery.of(context).size.height * 0.2,
      width: double.infinity,
      height: 70,
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PlayMusic(
                songModel: Songstorage.playingSongs,
              ),
            ),
          );
        },
        iconColor: const Color.fromARGB(255, 248, 246, 246),
        textColor: const Color.fromARGB(255, 255, 255, 255),
        leading: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.2,
          decoration: const BoxDecoration(color: Colors.transparent),
          child: QueryArtworkWidget(
            artworkQuality: FilterQuality.high,
            artworkFit: BoxFit.fill,
            artworkBorder: BorderRadius.circular(0),
            nullArtworkWidget: Lottie.asset(
              'assets/images/lf20_19misjxd.json',
            ),
            id: Songstorage.playingSongs[Songstorage.player.currentIndex!].id,
            type: ArtworkType.AUDIO,
          ),
        ),
        title: AnimatedText(
          text: Songstorage
              .playingSongs[Songstorage.player.currentIndex!].displayNameWOExt,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        subtitle: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            "${Songstorage.playingSongs[Songstorage.player.currentIndex!].artist}",
            style:
                const TextStyle(fontSize: 11, overflow: TextOverflow.ellipsis),
          ),
        ),
        trailing: FittedBox(
          fit: BoxFit.fill,
          child: Row(
            children: [
              IconButton(
                  onPressed: () async {
                    if (Songstorage.player.hasPrevious) {
                      await Songstorage.player.seekToPrevious();
                      await Songstorage.player.play();
                    } else {
                      await Songstorage.player.play();
                    }
                  },
                  icon: const Icon(
                    Icons.skip_previous,
                    size: 30,
                  )),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    elevation: 0,
                    backgroundColor: Colors.transparent),
                onPressed: () async {
                  if (Songstorage.player.playing) {
                    await Songstorage.player.pause();
                    // setState(() {});
                  } else {
                    await Songstorage.player.play();
                    // setState(() {});
                  }
                },
                child: StreamBuilder<bool>(
                  stream: Songstorage.player.playingStream,
                  builder: (context, snapshot) {
                    bool? playingStage = snapshot.data;
                    if (playingStage != null && playingStage) {
                      return const Icon(
                        Icons.pause,
                        size: 35,
                      );
                    } else {
                      return const Icon(
                        Icons.play_arrow,
                        size: 35,
                      );
                    }
                  },
                ),
              ),
              IconButton(
                onPressed: (() async {
                  if (Songstorage.player.hasNext) {
                    await Songstorage.player.seekToNext();
                    await Songstorage.player.play();
                  } else {
                    await Songstorage.player.play();
                  }
                }),
                icon: const Icon(
                  Icons.skip_next,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
