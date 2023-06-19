import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:prophunter/constant.dart';
import 'package:prophunter/models/units.dart';
import 'package:prophunter/widgets/property_card.dart';

import '../../../size_config.dart';
import '../../property_details/property_details.dart';

class GridViewProperty extends StatelessWidget {
  GridViewProperty({Key? key, required this.unitList}) : super(key: key);
  List<Units> unitList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          unitList.length,
          (index) => GestureDetector(
              onTap: () {
                pushNewScreen(
                  context,
                  screen: PropertyDetails(
                    property: propertyMap[unitList[index].propertyId]!,
                    unit: unitList[index],
                  ),
                  withNavBar: true, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              child: PropertyCard(
                  units: unitList[index],
                  properties: propertyMap[unitList[index].propertyId]!,
                  width: SizeConfig.screenWidth))),
    );
  }
}
