import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../../../widgets/text.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({required this.press, required this.title, Key? key}) : super(key: key);
  final VoidCallback press;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: headingWhite20,
        ),
        TextButton(
            onPressed: press,
            child: Text(
              'Clear',
              style: titleWhite18.copyWith(color: kSecondaryColor),
            )),
      ],
    );
  }
}
