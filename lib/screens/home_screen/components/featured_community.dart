import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:prophunter/constant.dart';
import 'package:prophunter/models/communities.dart';
import 'package:prophunter/models/featuredCommunity.dart';
import 'package:prophunter/screens/property_list/property_list.dart';
import 'package:prophunter/size_config.dart';
import 'package:prophunter/widgets/text.dart';

import '../../../models/units.dart';
import '../../../services/queries.dart';

class FeaturedCommunityList extends StatelessWidget {
  const FeaturedCommunityList({Key? key, required this.featuredCommunity}) : super(key: key);
  final List<FeaturedCommunity> featuredCommunity;

  Widget propertyCard(
      {required String imageUrl,
      required BuildContext context,
      required String heading,
      required String subheading,
      required List<String> amenities,
      required int communityId,
      required String communityName}) {
    return Container(
      // color: kFadeBlack,
      width: SizeConfig.screenWidth * 0.85,
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.only(right: 15),
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
          Row(
            children: [
              Text(
                heading.toUpperCase(),
                style: titleWhite15.copyWith(color: fadeWhite, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: SizeConfig.screenWidth * .02,
              ),
              Expanded(
                  child: Divider(
                color: fadeWhite,
                thickness: 1,
              ))
            ],
          ),
          defaultSpace,
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  communityName,
                  style: titleWhite20.copyWith(fontSize: getProportionateScreenWidth(25)),
                ),
                Text(subheading, style: titleWhite15),
              ],
            ),
          ),
          defaultSpace2x,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: SizeConfig.screenWidth * 0.4,
                        child: Row(
                          children: [
                            Image.asset('assets/icons/${amenities[0]}.png',
                                height: 30, color: kSecondaryColor),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                "${amenitiesList[amenities[0]]}",
                                style: titleWhite15,
                                softWrap: false,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: SizeConfig.screenWidth * 0.4,
                        child: Row(
                          children: [
                            Image.asset('assets/icons/${amenities[1]}.png',
                                height: 30, color: kSecondaryColor),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                "${amenitiesList[amenities[1]]}",
                                style: titleWhite15,
                                softWrap: false,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                defaultSpace2x,
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: SizeConfig.screenWidth * 0.4,
                        child: Row(
                          children: [
                            Image.asset('assets/icons/${amenities[2]}.png',
                                height: 30, color: kSecondaryColor),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                "${amenitiesList[amenities[2]]}",
                                style: titleWhite15,
                                softWrap: false,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: SizeConfig.screenWidth * 0.4,
                        child: Row(
                          children: [
                            Image.asset('assets/icons/${amenities[3]}.png',
                                height: 30, color: kSecondaryColor),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                "${amenitiesList[amenities[3]]}",
                                style: titleWhite15,
                                softWrap: false,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.screenHeight * .54,
      child: ListView.builder(
        itemBuilder: (context, index) {
          Community data = communityMap[featuredCommunity[index].communityId]!;
          return GestureDetector(
            onTap: () async {
              List<Units> units = await CustomQuery()
                  .getUnitByCommunityId(featuredCommunity[index].communityId, context);

              pushNewScreen(context,
                  screen: PropertyList(
                    unitList: units,
                  ));
            },
            child: propertyCard(
              communityId: featuredCommunity[index].communityId,
              amenities: featuredCommunity[index].amenities,
              heading: featuredCommunity[index].heading,
              subheading: featuredCommunity[index].subheading,
              context: context,
              imageUrl: featuredCommunity[index].image,
              communityName: data.name,
            ),
          );
        },
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: featuredCommunity.length,
      ),
    );
  }
}
