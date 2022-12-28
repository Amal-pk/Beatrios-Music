import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PlaylistEmptyScreenWidget extends StatelessWidget {
  const PlaylistEmptyScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Center(
      child: SizedBox(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
    );
  }
}
