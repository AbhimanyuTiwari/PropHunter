import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prophunter/models/properties.dart';
import 'package:prophunter/models/units.dart';
import 'package:prophunter/widgets/text.dart';

import '../constant.dart';
import '../models/bedrooms.dart';
import '../size_config.dart';

class PropertyCard extends StatelessWidget {
  final double width;
  final Properties properties;
  final Units units;

  const PropertyCard({required this.units, required this.properties, required this.width, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,

      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: kPrimaryColor, borderRadius: BorderRadius.circular(10)),
      width: width,
      // height: SizeConfig.screenHeight * .23,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: properties.images[0],
                  height: SizeConfig.screenHeight * .14,
                  width: width * 0.33,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                width: width * 0.33,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: kFadeBlack,
                ),
                child: Text(
                  statusMap[units.statusId]!.name,
                  style: const TextStyle(color: kSecondaryColor),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        communityMap[properties.communityId]!.name,
                        style: const TextStyle(
                            color: fadeWhite, fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: SizeConfig.screenWidth * .02,
                      ),
                      const Expanded(
                        child: Divider(
                          thickness: 2,
                          color: fadeWhite,
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.screenWidth * .05,
                      ),
                    ],
                  ),
                  defaultSpace,
                  Text(
                    properties.name,
                    style: titleWhite20.copyWith(fontSize: getProportionateScreenWidth(19)),
                  ),
                  Text("${units.name} | ${units.position}",
                      style: const TextStyle(color: fadeWhite, fontSize: 12)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/bed.svg',
                            width: getProportionateScreenWidth(20),
                            color: fadeWhite,
                          ),
                          Text(
                            bedRoomMap[units.bedrooms]!.name,
                            style: titleWhite12,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/area.svg',
                            width: getProportionateScreenWidth(20),
                            color: fadeWhite,
                          ),
                          Text(
                            units.size.toString(),
                            style: titleWhite12,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/property.svg',
                            width: getProportionateScreenWidth(20),
                            color: fadeWhite,
                          ),
                          Text(
                            propertyTypeMap[properties.propertyTypeId]!.name,
                            style: titleWhite12,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    'AED ${units.price}',
                    style:
                        TextStyle(fontSize: getProportionateScreenWidth(20), color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Container(
// margin: EdgeInsets.all(20),
// padding: EdgeInsets.all(15),
// decoration:
// BoxDecoration(color: kPrimaryColor, borderRadius: BorderRadius.circular(10)),
// width: SizeConfig.screenWidth * .8,
// height: SizeConfig.screenHeight * .23,
// child: Row(
// children: [
// Column(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// ClipRRect(
// borderRadius: BorderRadius.circular(10),
// child: CachedNetworkImage(
// width: SizeConfig.screenWidth * .8*.33,
// imageUrl: properties[index].images[0],
// height: SizeConfig.screenHeight * .14,
// fit: BoxFit.fill,
// ),
// ),
// Container(
// width: SizeConfig.screenWidth * .27,
// padding: EdgeInsets.all(5),
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(5),
// color: Color(0xff2F2D2D),
// ),
// child: const Text(
// 'Off Plan',
// style: TextStyle(color: kSecondaryColor),
// textAlign: TextAlign.center,
// ),
// )
// ],
// ),
// SizedBox(
// width: 10,
// ),
// Expanded(
// flex: 3,
// child: Container(
// child: Column(
//
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
//
// mainAxisSize: MainAxisSize.max,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Row(
// children: [
// Text(
// communities[topPicks[index].communityId]!.name,
// style: TextStyle(
// color: fadeWhite,
// fontSize: 14,
// fontWeight: FontWeight.bold),
// ),
// SizedBox(
// width: SizeConfig.screenWidth * .02,
// ),
// const Expanded(
// child: Divider(
// thickness: 2,
// color: fadeWhite,
// ),
// ),
// SizedBox(
// width: SizeConfig.screenWidth * .05,
// ),
// ],
// ),
// defaultSpace,
// Text(
// topPicks[index].name,
// style: titleWhite20.copyWith(
// fontSize: getProportionateScreenWidth(19)),
// ),
// Text("Es Fln DLJNs",
// style: TextStyle(color: fadeWhite, fontSize: 12)),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Column(
// children: [
// SvgPicture.asset(
// 'assets/icons/bed.svg',
// width: getProportionateScreenWidth(20),
// color: fadeWhite,
// ),
// Text('2 Bedrooms',style: titleWhite12,),
// ],
// ),
// Column(
// children: [
// SvgPicture.asset(
// 'assets/icons/area.svg',
// width: getProportionateScreenWidth(20),
// color: fadeWhite,
// ),
// Text('1000',style: titleWhite12,),
// ],
// ),
// Column(
// children: [
// SvgPicture.asset(
// 'assets/icons/property.svg',
// width: getProportionateScreenWidth(20),
// color: fadeWhite,
// ),
// Text('Apartment',style: titleWhite12,),
// ],
// ),
// ],
// ),
// Text('AED 123233',style: TextStyle(fontSize: getProportionateScreenWidth(22),color: Colors.white),)
// ],
// ),
// ),
// ),
// ],
// ),
// )
