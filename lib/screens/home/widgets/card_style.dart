import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeCardStyle extends StatelessWidget {
  final SongModel item;
  const HomeCardStyle({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item.displayNameWOExt,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        maxLines: 1,
                      ),
                      Text(
                        item.artist.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: QueryArtworkWidget(
              artworkBorder: const BorderRadius.all(
                Radius.circular(8),
              ),
              id: item.id,
              type: ArtworkType.AUDIO,
              nullArtworkWidget: Card(
                color: const Color.fromARGB(255, 74, 154, 191),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(
                  Icons.music_note_rounded,
                  size: width / 8,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
