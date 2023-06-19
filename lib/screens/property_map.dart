import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:prophunter/models/properties.dart';
import 'package:prophunter/models/units.dart';
import 'package:prophunter/screens/property_details/property_details.dart';
import 'package:prophunter/services/queries.dart';
import 'package:prophunter/size_config.dart';
import 'package:prophunter/widgets/property_card.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import '../provider/propertyProvider.dart';
import '../widgets/custom_map.dart';

class PropertyMap extends StatefulWidget {
  static const routeName = '/property_map';

  const PropertyMap({Key? key}) : super(key: key);

  @override
  _PropertyMapState createState() => _PropertyMapState();
}

class _PropertyMapState extends State<PropertyMap> with WidgetsBindingObserver {
  int index = -1;
  List<Units> unitList = [];

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Properties> propertyList =
        Provider.of<PropertyProvider>(context, listen: false).propertyList;

    SizeConfig().init(context);

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          CustomMap(
              press: (int i) async {
                unitList = await CustomQuery().getUnitsByPropertyId(propertyList[i].id);
                index = i;
                setState(() {});
              },
              propertyList: propertyList),
          if (index != -1)
            Positioned(
                bottom: 30,
                child: SizedBox(
                  height: SizeConfig.screenHeight * .25,
                  width: SizeConfig.screenWidth * .98,
                  child: Center(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: unitList.length,
                        itemBuilder: (context, j) {
                          Properties property = propertyList[index];
                          Units unit = unitList[j];
                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  pushNewScreen(
                                    context,
                                    screen: PropertyDetails(
                                      property: propertyMap[unitList[j].propertyId]!,
                                      unit: unitList[j],
                                    ),
                                    withNavBar: true, // OPTIONAL VALUE. True by default.
                                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                  );
                                },
                                child: PropertyCard(
                                    units: unit,
                                    properties: property,
                                    width: SizeConfig.screenWidth * .8),
                              ),
                            ),
                          );
                        }),
                  ),
                )),
        ],
      ),
    );
  }
}
