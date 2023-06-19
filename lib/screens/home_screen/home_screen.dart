import 'package:flutter/material.dart';

import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home_screen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Body(),
        ),
      ),
    );
  }
}
