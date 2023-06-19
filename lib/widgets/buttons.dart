import 'package:flutter/material.dart';
import 'package:prophunter/widgets/text.dart';

import '../constant.dart';
import '../size_config.dart';

class RoundedIconBtn extends StatelessWidget {
  RoundedIconBtn({
    Key? key,
    required this.text,
    this.color = kPrimaryColor,
    required this.icon,
    required this.press,
    this.borderRadius = 0,
    this.width,
    this.height,
  }) : super(key: key);

  final String icon;
  final GestureTapCancelCallback press;
  Text text;
  Color color;
  double borderRadius;
  double? height;
  double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenWidth(height ?? 50),
      width: getProportionateScreenWidth(width ?? double.infinity),
      child: TextButton.icon(
        style: TextButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
        ),
        onPressed: press,
        icon: Image.asset(icon),
        label: text,
      ),
    );
  }
}

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.text,
    this.press,
  }) : super(key: key);
  final String text;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth * .9,
      height: getProportionateScreenHeight(50),
      child: OutlinedButton(
        onPressed: press as void Function()?,
        style: OutlinedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          side: BorderSide(width: 1, color: Colors.white),
          primary: Colors.white,
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: getProportionateScreenWidth(17), color: Colors.white),
        ),
      ),
    );
  }
}

Widget backButton(context) {
  return Align(
    alignment: Alignment.topLeft,
    child: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          color: fadeWhite,
          size: 25,
        )),
  );
}

class CustomButton extends StatelessWidget {
  Text text;
  Color color;
  IconData? icon;
  double borderRadius;
  Function press;
  double? height;
  double? width;

  CustomButton(
      {required this.text,
      this.color = kPrimaryColor,
      this.icon,
      required this.press,
      this.borderRadius = 0,
      this.width,
      this.height,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        onPressed: press as void Function()?,
        style: TextButton.styleFrom(
          backgroundColor: color,
          elevation: 0,
        ),
        child: text,
      ),
    );
  }
}

class TextIconButton extends StatelessWidget {
  final String text;
  final GestureTapCancelCallback press;
  final IconData icon;
  final double? iconSize;
  final Color? color;

  const TextIconButton(
      {required this.text,
      required this.press,
      required this.icon,
      this.iconSize,
      this.color,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextButton.icon(
        label: Text(
          text,
          style: titleWhite20.copyWith(color: color ?? Colors.white),
        ),
        icon: Icon(
          icon,
          color: color ?? Colors.white,
          size: iconSize,
        ),
        onPressed: press,
      ),
    );
  }
}
