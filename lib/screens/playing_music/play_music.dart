import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/screens/like_songs/controller/liked_songs_db_controller.dart';
import 'package:music_player/functions/color/app_colors.dart';
import 'package:music_player/functions/buttons/liked_button.dart';
import 'package:music_player/screens/playing_music/widgets/controller.dart';
import 'package:music_player/widgets/songstorage.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart' as rx;

class PlayMusic extends StatelessWidget {
  PlayMusic({
    Key? key,
    required this.songModel,
  }) : super(key: key);
  final List<SongModel> songModel;

  final LikedSongDB _db = Get.put(LikedSongDB());
  final PlayScreenController _playScreenController =
      Get.put(PlayScreenController());
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return CmnBgdClor(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: (() {
              // setState(() {});
              Get.back();
            }),
            icon: const Icon(
              Icons.keyboard_arrow_down_outlined,
              color: Colors.white,
            ),
          ),
          title: const Center(
            child: Text(
              'Play From Playlist',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          actions: [
            PopupMenuButton(
              elevation: 0,
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              color: Colors.transparent,
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: IconButton(
                    icon: const Icon(Icons.volume_up),
                    color: Colors.white,
                    onPressed: () {
                      showSliderDialog(
                        context: context,
                        title: "Adjust volume",
                        divisions: 10,
                        min: 0,
                        max: 100,
                        value: Songstorage.player.volume,
                        stream: Songstorage.player.volumeStream,
                        onChanged: Songstorage.player.setVolume,
                      );
                    },
                  ),
                ),
                PopupMenuItem(
                  child: StreamBuilder<double>(
                    stream: Songstorage.player.speedStream,
                    builder: (context, snapshot) => IconButton(
                      icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        showSliderDialog(
                          context: context,
                          title: "Adjust speed",
                          divisions: 10,
                          min: 0.5,
                          max: 1.5,
                          value: Songstorage.player.speed,
                          stream: Songstorage.player.speedStream,
                          onChanged: Songstorage.player.setSpeed,
                        );
                      },
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            height: height,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Obx(
                      () => QueryArtworkWidget(
                        id: songModel[_playScreenController.currentIndex.value]
                            .id,
                        type: ArtworkType.AUDIO,
                        artworkHeight: height / 2.2,
                        artworkWidth: width,
                        nullArtworkWidget: SizedBox(
                          height: height / 2.2,
                          width: width,
                          child: Lottie.asset(
                            'assets/images/lf20_19misjxd.json',
                          ),
                        ),
                        keepOldArtwork: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height / 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Obx(
                                (() => Text(
                                      songModel[_playScreenController
                                              .currentIndex.value]
                                          .displayNameWOExt,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Obx(
                                () => Text(
                                  songModel[_playScreenController
                                                  .currentIndex.value]
                                              .artist
                                              .toString() ==
                                          "<unknown>"
                                      ? "Unknown Artist"
                                      : songModel[_playScreenController
                                              .currentIndex.value]
                                          .artist
                                          .toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (_db.isInitialized)
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Obx(
                            () => LikedButton(
                              song: songModel[
                                  _playScreenController.currentIndex.value],
                            ),
                          ),
                        )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: StreamBuilder<DurationState>(
                      stream: _durationStateStream,
                      builder: (context, snapshot) {
                        final durationState = snapshot.data;
                        final progress =
                            durationState?.position ?? Duration.zero;
                        final total = durationState?.total ?? Duration.zero;
                        return ProgressBar(
                          timeLabelTextStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                          progress: progress,
                          total: total,
                          barHeight: 3.0,
                          thumbRadius: 5,
                          progressBarColor: Colors.white,
                          thumbColor: Colors.white,
                          baseBarColor: Colors.grey,
                          bufferedBarColor: Colors.grey,
                          buffered: const Duration(milliseconds: 2000),
                          onSeek: (duration) {
                            Songstorage.player.seek(duration);
                          },
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      StreamBuilder<bool>(
                        stream: Songstorage.player.shuffleModeEnabledStream,
                        builder: (context, snapshot) {
                          final shuffleModeEnabled = snapshot.data ?? false;
                          return IconButton(
                            onPressed: () {
                              Songstorage.player.setShuffleModeEnabled(
                                !shuffleModeEnabled,
                              );
                            },
                            icon: shuffleModeEnabled
                                ? const Icon(Icons.shuffle,
                                    size: 30, color: Colors.blueGrey)
                                : const Icon(
                                    Icons.shuffle,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                          );
                        },
                      ),
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
                          color: Colors.white,
                        ),
                      ),
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
                          color: Colors.white,
                        ),
                      ),
                      StreamBuilder<LoopMode>(
                        stream: Songstorage.player.loopModeStream,
                        builder: (context, snapshot) {
                          final loopmode = snapshot.data ?? LoopMode.off;
                          const icons = [
                            Icon(
                              Icons.repeat,
                              color: Colors.white,
                              size: 30,
                            ),
                            Icon(
                              Icons.repeat,
                              color: Colors.blueGrey,
                              size: 30,
                            ),
                            Icon(
                              Icons.repeat_one,
                              color: Colors.blueGrey,
                              size: 30,
                            ),
                          ];
                          const cycleModes = [
                            LoopMode.off,
                            LoopMode.all,
                            LoopMode.one,
                          ];
                          final index = cycleModes.indexOf(loopmode);
                          return IconButton(
                            onPressed: () {
                              Songstorage.player.setLoopMode(
                                cycleModes[(cycleModes.indexOf(loopmode) + 1) %
                                    cycleModes.length],
                              );
                            },
                            icon: icons[index],
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Stream<DurationState> get _durationStateStream =>
      rx.Rx.combineLatest2<Duration, Duration?, DurationState>(
          Songstorage.player.positionStream,
          Songstorage.player.durationStream,
          (position, duration) => DurationState(
              position: position, total: duration ?? Duration.zero));

  void changeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    Songstorage.player.seek(duration);
  }

  void showSliderDialog({
    required BuildContext context,
    required String title,
    required int divisions,
    required double min,
    required double max,
    String valueSuffix = '',
    required double value,
    required Stream<double> stream,
    required ValueChanged<double> onChanged,
  }) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
        content: StreamBuilder<double>(
          stream: stream,
          builder: (context, snapshot) => SizedBox(
            height: 100.0,
            child: Column(
              children: [
                Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Fixed',
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0)),
                Slider(
                  divisions: divisions,
                  min: min,
                  max: max,
                  value: snapshot.data ?? value,
                  onChanged: onChanged,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DurationState {
  DurationState({this.position = Duration.zero, this.total = Duration.zero});
  Duration position, total;
}
