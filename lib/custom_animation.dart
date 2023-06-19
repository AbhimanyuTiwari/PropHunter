import 'dart:async';

import 'package:flutter/material.dart';

class CustomAnimation extends StatefulWidget {
  static String routeName = '/custom_animation';

  const CustomAnimation({Key? key}) : super(key: key);

  @override
  State<CustomAnimation> createState() => _CustomAnimationState();
}

class _CustomAnimationState extends State<CustomAnimation> {
  Duration _animationDuration = Duration(seconds: 2);
  Timer? _timer, zeroDurationTimer;

  @override
  void initState() {
    super.initState();
    zeroDurationTimer = Timer(
      Duration.zero,
      () {
        _changeColor();
      },
    );
    _timer = Timer.periodic(_animationDuration, (timer) => _changeColor());
  }

  void _changeColor() {
    selected = !selected;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    print("End");
    _timer?.cancel();
    zeroDurationTimer?.cancel();
  }

  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        width: selected ? 200.0 : 300.0,
        height: selected ? 200.0 : 300.0,
        duration: const Duration(seconds: 2),
        curve: Curves.fastOutSlowIn,
        child: Image.asset(
          'assets/images/transparent_logo.png',
          width: 72,
        ),
      ),
    );
  }
}
