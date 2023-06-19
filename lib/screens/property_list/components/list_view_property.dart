import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:prophunter/models/bedrooms.dart';

import '../../../constant.dart';
import '../../../models/units.dart';
import '../../../size_config.dart';
import '../../../widgets/text.dart';
import '../../property_details/property_details.dart';

class ListViewProperty extends StatelessWidget {
  ListViewProperty({Key? key, required this.unitList}) : super(key: key);
  List<Units> unitList;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      showCheckboxColumn: false,
      dataRowHeight: 60,
      columns: [
        DataColumn(
          label: headingIcon('Property', 'property.svg'),
        ),
        DataColumn(
          label: headingIcon('Area(Sqft)', 'area.svg'),
        ),
        DataColumn(
          label: headingIcon('Bedrooms', 'bed.svg'),
        ),
        DataColumn(
          label: headingIcon('Price', 'price.svg'),
        )
      ],
      columnSpacing: 15,
      rows: List.generate(
        unitList.length,
        (index) => DataRow(
            onSelectChanged: (val) {
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
            color: MaterialStateProperty.all<Color>((index % 2 == 0) ? kFadeBlack : kPrimaryColor),
            cells: [
              DataCell(
                Text(
                  unitList[index].name,
                  style: titleWhite15,
                ),
              ),
              DataCell(Text(
                unitList[index].size.toString(),
                style: titleWhite15,
              )),
              DataCell(Text(
                bedRoomMap[unitList[index].bedrooms]!.name,
                style: titleWhite15,
              )),
              DataCell(Text(
                '${unitList[index].price} AED',
                style: titleWhite15,
              )),
            ]),
      ),
    );
  }

  Widget headingIcon(String text, String image) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/icons/" + image,
          width: getProportionateScreenWidth(20),
          color: kSecondaryColor,
        ),
        Text(
          text,
          style: titleWhite15,
        )
      ],
    );
  }
}
