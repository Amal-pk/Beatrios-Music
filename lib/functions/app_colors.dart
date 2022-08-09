// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CmnBgdClor extends StatelessWidget {
  Widget? child;
  CmnBgdClor({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 68, 74, 90),
            Color.fromARGB(246, 7, 23, 8),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }
}
