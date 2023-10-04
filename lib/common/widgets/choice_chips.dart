import 'package:flutter/material.dart';

class CommonChoiceChips extends StatelessWidget {
  final String title;
  final String toolTip;
  final Color textColor;
  final bool selected;
  final String image;
  final ValueChanged<bool> onSelected;
  const CommonChoiceChips(
      {required this.title,
      required this.textColor,
      required this.selected,
      required this.onSelected,
      required this.toolTip,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Tooltip(
        message: toolTip,
        child: ChoiceChip(
            avatar: Image.asset(image),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.0, color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(6)),
            label: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(color: textColor),
              ),
            ),
            selectedColor: Colors.grey.shade300,
            selected: selected,
            onSelected: onSelected),
      ),
    );
  }
}
