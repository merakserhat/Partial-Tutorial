import "package:flutter/material.dart";

import 'tutorial_item.dart';

/// The controller object that should be given to the
/// tutorial items.
///
/// This object holds the information data.
/// It is initialized by the PartialTutorialProvider
/// and child widget, the position and the size of that
/// child widget initialized too.
class PartialTutorialItemController {
  ///The tutorial text that we want to display
  final String information;

  ///Custom position from the top of the screen
  ///
  /// If this is null, custom position will be calculated for every
  /// tutorial object.
  final double? informationPosition;

  ///Allows us to access the position of the child
  late final GlobalKey globalKey;

  ///The child of the tutorial object
  Widget? child;

  ///Absolute position of the child widget
  Offset? position;

  ///Size of the child widget
  Size? size;

  PartialTutorialItemController(
      {required this.information, this.informationPosition}) {
    globalKey = GlobalKey();
  }

  void initializePartialTutorialItem() {
    position = ((globalKey.currentState!.widget.key as GlobalKey)
            .currentContext!
            .findRenderObject() as RenderBox)
        .localToGlobal(Offset.zero);

    size = ((globalKey.currentState!.widget.key as GlobalKey)
            .currentContext!
            .findRenderObject() as RenderBox)
        .size;

    child = (globalKey.currentState!.widget as PartialTutorialItem).child;
  }
}
