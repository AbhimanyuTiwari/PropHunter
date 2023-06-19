import 'package:flutter/material.dart';
import 'package:prophunter/constant.dart';
import 'package:prophunter/widgets/text.dart';

class Chips extends StatelessWidget {
  Chips(
      {Key? key,
      required this.items,
      required this.press,
      required this.selectItems,
      this.isBedRoom = false})
      : super(key: key);
  List items;
  bool isBedRoom;
  List selectItems;
  final Function(bool, int) press;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 15,
      children: List<Widget>.generate(
        items.length,
        (int index) {
          return ChoiceChip(
            backgroundColor: Colors.black,
            elevation: 5,
            side: BorderSide(color: fadeWhite),
            label: Text(
              isBedRoom ? items[index].name : items[index].name,
              style: titleWhite15,
            ),
            selected: selectItems.contains(items[index]),
            onSelected: (value) {
              press(value, index);
            },
          );
        },
      ),
    );
  }
}
