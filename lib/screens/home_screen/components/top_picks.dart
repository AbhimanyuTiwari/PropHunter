import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:prophunter/constant.dart';
import 'package:prophunter/screens/property_list/property_list.dart';
import 'package:prophunter/size_config.dart';
import 'package:prophunter/widgets/buttons.dart';
import 'package:prophunter/widgets/text.dart';

import '../../../models/properties.dart';
import '../../../models/units.dart';
import '../../../services/queries.dart';

class TopPicks extends StatelessWidget {
  const TopPicks({Key? key, required this.topPick}) : super(key: key);
  final List<int> topPick;

  Widget propertyCard(
      {required String imageUrl,
      required BuildContext context,
      required String communityName,
      required String propertyName,
      required String propertyType,
      required int index}) {
    return Container(
      color: kFadeBlack,
      width: SizeConfig.screenWidth * 0.8,
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.symmetric(horizontal: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1 / 0.65,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: SizeConfig.screenWidth * 0.8,
              fit: BoxFit.fill,
            ),
          ),
          defaultSpace2x,
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                Text(
                  communityName,
                  style: titleWhite20.copyWith(color: fadeWhite),
                ),
                SizedBox(
                  width: SizeConfig.screenWidth * .07,
                ),
                const Expanded(
                  child: Divider(
                    thickness: 2,
                    color: fadeWhite,
                  ),
                ),
                SizedBox(
                  width: SizeConfig.screenWidth * .07,
                ),
              ],
            ),
          ),
          defaultSpace,
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  propertyName,
                  style: titleWhite20.copyWith(fontSize: getProportionateScreenWidth(19)),
                ),
                Text(propertyType, style: titleWhite15),
              ],
            ),
          ),
          TextIconButton(
            text: "View Details",
            press: () async {
              List<Units> units = await CustomQuery().getUnitsByPropertyId(topPick[index]);

              pushNewScreen(context,
                  screen: PropertyList(
                    unitList: units,
                  ));
            },
            color: kSecondaryColor,
            icon: Icons.arrow_back_ios_rounded,
            iconSize: getProportionateScreenWidth(15),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.screenHeight * .44,
      child: ListView.builder(
        itemBuilder: (context, index) {
          Properties data = propertyMap[topPick[index]]!;
          return propertyCard(
              context: context,
              imageUrl: data.images[0],
              communityName: data.communityName,
              propertyName: data.name,
              propertyType: data.propertyType,
              index: index);
        },
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: topPick.length,
      ),
    );
  }
}
