import 'dart:async';

import 'package:flutter/material.dart';
import 'package:music_player/bottom_navigation.dart';
import 'package:music_player/functions/app_colors.dart';

class LogoScreen extends StatefulWidget {
  const LogoScreen({Key? key}) : super(key: key);

  @override
  State<LogoScreen> createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {
  @override
  void initState() {
    super.initState();
    timer();
  }

  @override
  Widget build(BuildContext context) {
    return CmnBgdClor(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 4, 204, 191),
        body: Center(
          child: Image.asset(
            'assets/images/Beatrios_Music-removebg.png',
          ),
        ),
      ),
    );
  }

  void timer() {
    Timer(
      const Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => const BottomNavigator(),
        ),
      ),
    );
  }
}
