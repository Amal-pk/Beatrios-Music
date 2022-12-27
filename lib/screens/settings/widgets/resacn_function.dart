import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:music_player/screens/home/home_screen.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isplaying = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    Future.delayed(
      Duration.zero,
      () {
        _animationController.reset();
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.grey,
      Colors.black,
      Color.fromARGB(255, 255, 255, 255),
      Colors.blueGrey,
    ];
    const colorizeTextStyle = TextStyle(
      fontSize: 50.0,
      fontFamily: 'Horizon',
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Stack(
              children: [
                buildRotationTransition(),
              ],
            ),
            Center(
              child: AnimatedTextKit(
                totalRepeatCount: 20,
                animatedTexts: [
                  ColorizeAnimatedText(
                    'Scanning...',
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_isplaying) {
                  _animationController.repeat();
                  scanToast().then((value) => _animationController.stop());
                }
                setState(() {
                  _isplaying = !_isplaying;
                });
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                backgroundColor: Colors.grey,
                textStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text(
                'Scan',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  RotationTransition buildRotationTransition() {
    return RotationTransition(
      turns: _animationController,
      child: const ClipOval(
        child: Icon(
          Icons.refresh,
          color: Colors.grey,
          size: 65,
        ),
      ),
    );
  }

  Future<void> scanToast() async {
    await Future.delayed(
      const Duration(
        seconds: 5,
      ),
    );
    if (HomeScreen.song.isEmpty) {
      // ignore: use_build_context_synchronously
      return showTopSnackBar(
        context,
        const CustomSnackBar.error(
          iconPositionLeft: 0,
          iconPositionTop: 0,
          iconRotationAngle: 0,
          icon: Icon(
            Icons.abc,
            color: Colors.grey,
          ),
          backgroundColor: Colors.grey,
          message: "no Songs found",
        ),
      );
    }
    // ignore: use_build_context_synchronously
    return showTopSnackBar(
      context,
      CustomSnackBar.success(
        iconPositionLeft: 0,
        iconPositionTop: 0,
        iconRotationAngle: 0,
        backgroundColor: Colors.black,
        message: "Songs Scanned Total songs:${HomeScreen.song.length} ",
      ),
    );
  }
}
