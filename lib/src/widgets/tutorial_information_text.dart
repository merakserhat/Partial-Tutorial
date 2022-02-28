import 'package:flutter/material.dart';

class TutorialInformationText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final EdgeInsets? textPadding;
  final Color? informationBackgroundColor;

  const TutorialInformationText(
      {Key? key,
      required this.text,
      this.textStyle,
      this.textPadding,
      this.informationBackgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: textPadding ??
          const EdgeInsets.symmetric(vertical: 30, horizontal: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: informationBackgroundColor ??
              const Color.fromRGBO(51, 51, 51, 0.6)),
      child: Text(
        text,
        style: textStyle?.copyWith(color: Colors.white) ??
            Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Colors.white),
        softWrap: true,
        textAlign: TextAlign.center,
      ),
    );
  }
}

/*
if (tutorialIndex + 1 < widget.controllers.length) {
            setState(() {
              tutorialIndex++;
            });
          } else {
            setState(() {
              isTutorialActive = false;
            });
          }
 */
