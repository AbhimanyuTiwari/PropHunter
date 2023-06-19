import 'package:flutter/material.dart';

import '../../../constant.dart';

class DropDownBox extends StatelessWidget {
  const DropDownBox({required this.hintText, required this.press, Key? key}) : super(key: key);
  final String hintText;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(35),
          border: Border.all(color: fadeWhite, width: 0.8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              hintText,
              style: const TextStyle(color: fadeWhite),
            ),
            const Icon(
              Icons.arrow_drop_down_sharp,
              color: fadeWhite,
            )
          ],
        ),
      ),
    );
  }
}
