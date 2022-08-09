// import 'package:flutter/material.dart';
// import 'package:music_player/db/music_db.dart';
// import 'package:music_player/db/playlist_db.dart';
// import 'package:music_player/home_screen.dart';

// class PlaylistButton extends StatefulWidget {
//   PlaylistButton(
//       {Key? key,
//       required this.index,
//       required this.folderindex,
//       required this.id})
//       : super(key: key);

//   int? index;
//   int? folderindex;
//   int? id;
//   List<dynamic> songlist = [];
//   static List<dynamic> updatelist = [];
//   static List<dynamic> dltlist = [];

//   @override
//   State<PlaylistButton> createState() => _PlaylistButtonState();
// }

// class _PlaylistButtonState extends State<PlaylistButton> {
//   @override
//   Widget build(BuildContext context) {
//     final checkIndex =
//         playlistnotifier.value[widget.folderindex!].songId.contains(widget.id);
//     final indexCheck = playlistnotifier.value[widget.folderindex!].songId
//         .indexWhere((element) => element == widget.id);
//     if (checkIndex != true) {
//       return IconButton(
//           onPressed: () async {
//             widget.songlist.add(widget.id);
//             List<dynamic> newlist = widget.songlist;
//             PlaylistButton.updatelist = [
//               newlist,
//               playlistnotifier.value[widget.folderindex!].songId
//             ].expand((element) => element).toList();
//             final model = Playlistmodel(
//                 playListName:
//                     playlistnotifier.value[widget.folderindex!].playListName,
//                 songId: PlaylistButton.updatelist,
//                 id: []);
//             // updatlist(widget.folderindex, model);
//             getAllPlaylist();
//             // Playlistsongcheck.showSelectSong(widget.folderindex);
//             setState(() {});
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 duration: const Duration(seconds: 2),
//                 content: Text(
//                   'added ${HomeScreen.song[indexCheck].title} to ${playlistnotifier.value[widget.folderindex!].playListName}',
//                   style: const TextStyle(color: Colors.white),
//                 ),
//                 backgroundColor: const Color.fromARGB(255, 62, 62, 62),
//                 behavior: SnackBarBehavior.floating,
//               ),
//             );
//           },
//           icon: const Icon(
//             Icons.playlist_add_circle_rounded,
//             size: 35,
//             color: Color.fromARGB(234, 231, 83, 72),
//           ));
//     }
//     return IconButton(
//         onPressed: () async {
//           await playlistnotifier.value[widget.folderindex!].songId
//               .removeAt(indexCheck);
//           PlaylistButton.dltlist = [
//             widget.songlist,
//             playlistnotifier.value[widget.folderindex!].songId
//           ].expand((element) => element).toList();
//           final model = Playlistmodel(
//             id: [],
//             playListName:
//                 playlistnotifier.value[widget.folderindex!].playListName,
//             songId: PlaylistButton.dltlist,
//           );
//           //  playlistAdd(widget.folderindex, model);
//           // Playlistsongcheck.showSelectSong(widget.folderindex);

//           setState(() {});
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                 'song deleted from   ${playlistnotifier.value[widget.folderindex!].playListName}',
//                 style: const TextStyle(color: Colors.white),
//               ),
//               backgroundColor: const Color.fromARGB(255, 68, 68, 68),
//               behavior: SnackBarBehavior.floating,
//             ),
//           );
//         },
//         icon: const Icon(
//           Icons.playlist_add_check_circle,
//           size: 35,
//           color: Color.fromARGB(255, 135, 255, 145),
//         ));
//   }
// }
