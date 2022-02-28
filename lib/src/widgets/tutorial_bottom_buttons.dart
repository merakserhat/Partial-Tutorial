import "package:flutter/material.dart";

class TutorialBottomButtons extends StatelessWidget {
  final int buttonLength;
  final int currentIndex;
  final Function(int) onClick;

  TutorialBottomButtons(
      {required this.buttonLength,
      required this.currentIndex,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 11,
      padding: const EdgeInsets.symmetric(horizontal: 64),
      child: Row(
        children: List.generate(
          buttonLength,
          (index) => Expanded(
            child: GestureDetector(
              onTap: () => onClick(index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                color: Colors.transparent,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.white
                      .withOpacity(index <= currentIndex ? 0.5 : 0.2),
                ),
              ),
            ),
          ),
        ).toList(),
      ),
    );
  }
}
