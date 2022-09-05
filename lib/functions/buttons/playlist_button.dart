import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/db/controller/playlist_db.dart';
import 'package:music_player/db/music_db.dart';

class PlaylistButton extends StatelessWidget {
  PlaylistButton({Key? key, required this.folderindex, required this.id})
      : super(key: key);

  int? folderindex;
  int? id;
  List<dynamic> songlist = [];
  static List<dynamic> updatelist = [];
  static List<dynamic> dltlist = [];

  final PlaylistController _playlistController = Get.put(PlaylistController());
  @override
  Widget build(BuildContext context) {
    final checkIndex =
        _playlistController.playlistnotifier[folderindex!].songid.contains(id);
    final indexCheck = _playlistController.playlistnotifier[folderindex!].songid
        .indexWhere((element) => element == id);
    if (checkIndex != true) {
      return IconButton(
        onPressed: () async {
          songlist.add(id);
          List<dynamic> newlist = songlist;
          PlaylistButton.updatelist = [
            newlist,
            _playlistController.playlistnotifier[folderindex!].songid
          ].expand((element) => element).toList();
          final model = Playlistmodel(
            name: _playlistController.playlistnotifier[folderindex!].name,
            songid: PlaylistButton.updatelist,
          );
          _playlistController.playlistUpate(folderindex, model);
          // _playlistController.getAllPlaylist();
          _playlistController.listPlaylist(folderindex);
          Get.snackbar(
            "",
            "Added to \t${_playlistController.playlistnotifier[folderindex!].name}",
            backgroundColor: Colors.white,
          );
        },
        icon: const Icon(
          Icons.playlist_add,
          color: Colors.white,
        ),
      );
    }
    return IconButton(
      onPressed: () async {
        await _playlistController.playlistnotifier[folderindex!].songid
            .removeAt(indexCheck);
        PlaylistButton.dltlist = [
          songlist,
          _playlistController.playlistnotifier[folderindex!].songid
        ].expand((element) => element).toList();
        final model = Playlistmodel(
          name: _playlistController.playlistnotifier[folderindex!].name,
          songid: PlaylistButton.dltlist,
        );
        _playlistController.playlistUpate(folderindex, model);

        Get.snackbar(
          "",
          "Remove from \t ${_playlistController.playlistnotifier[folderindex!].name}",
          backgroundColor: Colors.white,
        );
      },
      icon: const Icon(
        Icons.close,
        color: Colors.white,
      ),
    );
  }
}
