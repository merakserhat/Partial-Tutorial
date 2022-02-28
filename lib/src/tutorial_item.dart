import 'package:flutter/material.dart';

import 'tutorial_item_controller.dart';

///Flutter widget that should be wrapped to every tutorial
///item that we want to show.
class PartialTutorialItem extends StatefulWidget {
  ///The widget that we want to give a tutorial
  final Widget child;

  ///The object that holds information about the tutorial
  final PartialTutorialItemController controller;

  PartialTutorialItem({required this.child, required this.controller})
      : super(key: controller.globalKey);
  @override
  _PartialTutorialItemState createState() => _PartialTutorialItemState();
}

class _PartialTutorialItemState extends State<PartialTutorialItem> {
  GlobalKey globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
    );
  }
}
