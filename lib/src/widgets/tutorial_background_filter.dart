import 'dart:ui';

import 'package:flutter/material.dart';

class TutorialBackgroundFilter extends StatelessWidget {
  final Color? backgroundColor;

  const TutorialBackgroundFilter({Key? key, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3, tileMode: TileMode.decal),
      child: Container(
        color: backgroundColor ?? Colors.black54.withOpacity(0.7),
      ),
    );
  }
}
