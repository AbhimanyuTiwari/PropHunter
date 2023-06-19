import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:prophunter/screens/property_map.dart';

import '../../../size_config.dart';
import '../../../widgets/text.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushNewScreen(
          context,
          screen: const PropertyMap(),
          withNavBar: true, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      child: SizedBox(
        height: SizeConfig.screenHeight * 0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'Discover All That\'s Possible',
                style: headingWhite22,
              ),
            ),
            Expanded(
              flex: 10,
              child: Stack(
                children: [
                  const Hero(tag: "property_map", child: PropertyMap()),
                  Container(
                    color: Colors.transparent,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
