import 'package:flutter/material.dart';
import 'package:prophunter/constant.dart';
import 'package:prophunter/widgets/text.dart';

import 'buttons.dart';

showAlertDialog(
    {required BuildContext context,
    required String title,
    required Widget child,
    required VoidCallback press}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kFadeBlack,
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.all(20),
          scrollable: true,
          title: Text(
            title,
            style: titleWhite18,
          ),
          content: child,
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            DefaultButton(
              text: "SAVE",
              press: () {
                press();
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}
