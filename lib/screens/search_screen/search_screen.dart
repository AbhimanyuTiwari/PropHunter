import 'package:flutter/material.dart';

import 'components/body.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Body(),
      ),
    );
  }
}
