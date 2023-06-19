import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:prophunter/screens/property_list/property_list.dart';
import 'package:prophunter/services/queries.dart';

import '../../../constant.dart';
import '../../../models/banner.dart';
import '../../../models/units.dart';
import '../../../size_config.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/text.dart';
import '../../../widgets/top_bar.dart';

class BannerComponent extends StatelessWidget {
  BannerComponent({Key? key, required this.banners}) : super(key: key);
  List<Banners> banners;
  final List<String> imageUrl = [
    'https://cdn.properties.emaar.com/wp-content/uploads/2021/09/LEBANON2.jpg',
    'https://cdn.properties.emaar.com/wp-content/uploads/2021/08/Pakistan.jpg',
    'https://cdn.properties.emaar.com/wp-content/uploads/2021/08/misr-resized.jpeg'
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.black,
          height: SizeConfig.screenHeight * .60,
          width: double.infinity,
          child: PageView(
            children: List.generate(
              banners.length,
              (index) => Stack(
                children: [
                  SizedBox(
                    height: SizeConfig.screenHeight * .60,
                    child: CachedNetworkImage(
                      imageUrl: banners[index].imageUrl,
                      fit: BoxFit.fill,
                      placeholder: (con, str) {
                        return Center(
                          child: Image.asset(
                            'assets/images/transparent_logo.png',
                            width: SizeConfig.screenWidth * .50,
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: SizeConfig.screenHeight * 0.25,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: SizeConfig.screenHeight * 0.02,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: SizeConfig.screenWidth * .05),
                              width: SizeConfig.screenWidth * 0.90,
                              color: Colors.black,
                              child: Column(
                                children: [
                                  defaultSpace3x,
                                  defaultSpace,
                                  Text(
                                    "PROPHUNTER",
                                    style: titleWhite20.copyWith(
                                        fontSize: getProportionateScreenHeight(22)),
                                  ),
                                  Text(
                                    banners[index].heading,
                                    style: headingWhite27,
                                  ),
                                  Text(
                                    banners[index].subheading,
                                    style: titleWhite18,
                                    textAlign: TextAlign.center,
                                  ),
                                  defaultSpace3x,
                                  TextIconButton(
                                      text: 'VIEW DETAILS',
                                      press: () async {
                                        List<Units> units = await CustomQuery()
                                            .getUnitsByPropertyId(banners[index].propertyId);
                                        pushNewScreen(context,
                                            screen: PropertyList(
                                              unitList: units,
                                            ));
                                      },
                                      icon: Icons.arrow_back_ios_rounded)
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: SizeConfig.screenHeight * 0.04,
                          width: SizeConfig.screenWidth * .4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xff042B4A),
                          ),
                          child: Center(
                              child: Text(
                            'LATEST LAUNCH',
                            style: titleWhite18,
                          )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const TopBar(),
      ],
    );
  }
}
