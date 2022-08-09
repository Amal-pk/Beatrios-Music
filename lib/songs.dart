// import 'package:flutter/material.dart';
// import 'package:music_player/db/music_db.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// class Songs extends StatefulWidget {
//   const Songs({Key? key, required this.playlist}) : super(key: key);

//   final Playlistmodel playlist;

//   @override
//   State<Songs> createState() => _SongsState();
// }

// class _SongsState extends State<Songs> {
//   final OnAudioQuery audioQuery = OnAudioQuery();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height,
//       child: Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           title: 
//           Text(
//             'Add Songs to ${widget.playlist.playListName}',
//             style: const TextStyle(color: Colors.white),
//           ),
//           leading: IconButton(
//             icon: const Icon(
//               Icons.arrow_back_ios,
//             ),
//             onPressed: () => Navigator.pop(context),
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 FutureBuilder<List<SongModel>>(
//                     future: audioQuery.querySongs(
//                         sortType: SongSortType.DATE_ADDED,
//                         orderType: OrderType.DESC_OR_GREATER,
//                         uriType: UriType.EXTERNAL,
//                         ignoreCase: true),
//                     builder: (context, item) {
//                       if (item.data == null) {
//                         return const Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       }
//                       if (item.data!.isEmpty) {
//                         return const Center(
//                           child: Text(
//                             'NO Songs Found',
//                             style: TextStyle(),
//                           ),
//                         );
//                       }
//                       return ListView.separated(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           scrollDirection: Axis.vertical,
//                           itemBuilder: (ctx, index) {
//                             return ListTile(
//                               onTap: () {},
//                               leading: QueryArtworkWidget(
//                                 id: item.data![index].id,
//                                 type: ArtworkType.AUDIO,
//                                 nullArtworkWidget:
//                                     const Icon(Icons.music_note_outlined),
//                                 artworkFit: BoxFit.fill,
//                                 artworkBorder:
//                                     const BorderRadius.all(Radius.circular(30)),
//                               ),
//                               title: Text(item.data![index].displayNameWOExt),
//                               subtitle: Text("${item.data![index].artist}"),
//                               trailing: IconButton(
//                                   onPressed: () {
//                                     setState(() {});
//                                     playlistCheck(item.data![index]);
//                                     //     playlistnotifier.notifyListeners();
//                                   },
//                                   icon: !widget.playlist
//                                           .isValueIn(item.data![index].id)
//                                       ? const Icon(Icons.add)
//                                       : const Icon(Icons.minimize),
//                                   color: !widget.playlist
//                                           .isValueIn(item.data![index].id)
//                                       ? Colors.white
//                                       : Colors.redAccent),
//                             );
//                           },
//                           separatorBuilder: (ctx, index) {
//                             return const Divider();
//                           },
//                           itemCount: item.data!.length);
//                     })
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void playlistCheck(SongModel data) {
//     if (!widget.playlist.isValueIn(data.id)) {
//       widget.playlist.add(data.id);
//       const snackbar = SnackBar(
//           backgroundColor: Colors.black,
//           content: Text(
//             'Added to Playlist',
//             style: TextStyle(color: Colors.white),
//           ));
//       ScaffoldMessenger.of(context).showSnackBar(snackbar);
//     } else {
//       const snackbar = SnackBar(
//           backgroundColor: Colors.black,
//           content: Text(
//             'Already in Playlist',
//             style: TextStyle(color: Colors.white),
//           ));
//       ScaffoldMessenger.of(context).showSnackBar(snackbar);
//     }
//   }
// }
