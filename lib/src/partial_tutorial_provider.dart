import 'package:flutter/material.dart';

import 'tutorial_item_controller.dart';
import 'widgets/tutorial_background_filter.dart';
import 'widgets/tutorial_bottom_buttons.dart';
import 'widgets/tutorial_information_text.dart';

///Flutter widget that controls the TutorialItems inside of it
///
///This widget has to be wrapped around the whole page including
///SafeArea and Scaffold.
///In order to let users open the tutorial screen, you should create
///a bool inside of the Screen Widget and Change it to false when [onTutorialFinished]
///method called.
class PartialTutorialProvider extends StatefulWidget {
  ///The whole widget tree of a screen including SafeArea and Scaffold
  final Widget child;

  ///The bool that decides to show the tutorial
  final bool isTutorialActive;

  ///The function which will be called after the all tutorial objects are showed
  final VoidCallback? onTutorialFinished;

  ///The list of tutorial item controllers whit correct order
  final List<PartialTutorialItemController> controllers;

  ///TextStyle of the tutorial information
  ///
  /// It is default  Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white)
  final TextStyle? textStyle;

  ///Text information padding
  ///
  /// It is default EdgeInsets.symmetric(vertical: 30, horizontal: 12)
  final EdgeInsets? textPadding;

  ///Background color of the background blurry page
  ///
  /// It is default Colors.black54.withOpacity(0.7)
  final Color? backgroundColor;

  ///Background color of the information text panel
  ///
  /// It is default Color.fromRGBO(51, 51, 51, 0.6))
  final Color? informationBackgroundColor;

  ///Whether to show the border around the tutorial widgets or not
  ///
  /// It is default true
  final bool showBorder;
  final Color borderColor;
  final double borderWidth;

  const PartialTutorialProvider({
    required this.child,
    required this.controllers,
    required this.isTutorialActive,
    this.onTutorialFinished,
    this.textStyle,
    this.textPadding,
    this.showBorder = true,
    this.borderColor = Colors.greenAccent,
    this.backgroundColor,
    this.informationBackgroundColor,
    this.borderWidth = 4,
    Key? key,
  }) : super(key: key);

  @override
  _PartialTutorialProviderState createState() =>
      _PartialTutorialProviderState();
}

class _PartialTutorialProviderState extends State<PartialTutorialProvider> {
  bool tutorialItemsInitialized = false;
  int tutorialIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _initializeItems();
    });

    if (!widget.isTutorialActive ||
        tutorialIndex >= widget.controllers.length) {
      return widget.child;
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          tutorialIndex++;
        });

        if (widget.onTutorialFinished != null &&
            tutorialIndex >= widget.controllers.length) {
          setState(() {
            tutorialIndex = 0;
          });

          widget.onTutorialFinished!();
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          widget.child,
          TutorialBackgroundFilter(backgroundColor: widget.backgroundColor),
          _buildTutorialItemWidget(),
          Positioned(
            bottom: widget.controllers[tutorialIndex].informationPosition ??
                _getInfoTextPosition(),
            left: 20,
            right: 20,
            child: TutorialInformationText(
              text: widget.controllers[tutorialIndex].information,
              textStyle: widget.textStyle,
              informationBackgroundColor: widget.informationBackgroundColor,
            ),
          ),
          Positioned(
            bottom: 3,
            child: TutorialBottomButtons(
                buttonLength: widget.controllers.length,
                currentIndex: tutorialIndex,
                onClick: (index) {
                  setState(() {
                    tutorialIndex = index;
                  });
                }),
          ),
        ],
      ),
    );
  }

  Widget _buildTutorialItemWidget() {
    double borderWidth = widget.borderWidth;
    if (!widget.showBorder) {
      borderWidth = 0;
    }
    return tutorialItemsInitialized
        ? Positioned(
            left: widget.controllers[tutorialIndex].position!.dx - borderWidth,
            top: widget.controllers[tutorialIndex].position!.dy - borderWidth,
            child: IconTheme.merge(
              data: Theme.of(context).primaryIconTheme,
              child: Container(
                decoration: BoxDecoration(
                    border: widget.showBorder
                        ? Border.all(
                            color: widget.borderColor, width: borderWidth)
                        : null,
                    borderRadius: BorderRadius.circular(10)),
                width: widget.controllers[tutorialIndex].size!.width +
                    borderWidth * 2,
                height: widget.controllers[tutorialIndex].size!.height +
                    borderWidth * 2,
                // padding: EdgeInsets.all(5),
                child: AbsorbPointer(
                    absorbing: true,
                    child: widget.controllers[tutorialIndex].child!),
              ),
            ))
        : Container();
  }

  void _initializeItems() {
    if (tutorialItemsInitialized) return;
    for (var element in widget.controllers) {
      element.initializePartialTutorialItem();
    }
    setState(() {
      tutorialItemsInitialized = true;
    });
  }

  double _getInfoTextPosition() {
    double infoTextHeight = 0;

    if (widget.controllers[tutorialIndex].position!.dy > 200) {
      infoTextHeight = MediaQuery.of(context).size.height -
          (widget.controllers[tutorialIndex].position!.dy) +
          50;
    } else {
      infoTextHeight = MediaQuery.of(context).size.height -
          (widget.controllers[tutorialIndex].position!.dy +
              widget.controllers[tutorialIndex].size!.height) -
          200;
    }

    return infoTextHeight;
  }
}
