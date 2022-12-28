import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/view/home/controller/controller.dart';
import 'package:music_player/view/home/ui/card_style.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeGridViewWidget extends StatelessWidget {
  final List<SongModel> item;
  HomeGridViewWidget({super.key, required this.item});
  final InitController _controller = Get.put(InitController());

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      scrollDirection: Axis.vertical,
      itemCount: item.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, index) {
        return GestureDetector(
          onTap: () {
            _controller.nextPage(index, item);
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 8),
            child: HomeCardStyle(
              item: item[index],
            ),
          ),
        );
      },
    );
  }
}
