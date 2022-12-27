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
            Color.fromARGB(255, 3, 8, 22),
            Color.fromARGB(246, 1, 11, 2),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }
}
