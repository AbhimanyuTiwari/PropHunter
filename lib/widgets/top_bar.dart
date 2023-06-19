import 'package:flutter/material.dart';

import 'search_bar.dart' as search;

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Row(children: [
        Expanded(flex: 9, child: search.SearchBar()),
        // Expanded(
        //     flex: 1,
        //     child: SvgPicture.asset(
        //       'assets/icons/filter.svg',
        //       width: getProportionateScreenWidth(26),
        //       color: kPrimaryColor,
        //     ))
      ]),
    );
  }
}
