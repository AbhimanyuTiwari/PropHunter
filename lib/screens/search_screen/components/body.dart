import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:prophunter/constant.dart';
import 'package:prophunter/models/communities.dart';
import 'package:prophunter/models/properties.dart';
import 'package:prophunter/models/property_type.dart';
import 'package:prophunter/models/units.dart';
import 'package:prophunter/provider/basicDataProvider.dart';
import 'package:prophunter/provider/propertyProvider.dart';
import 'package:prophunter/screens/search_screen/components/chips.dart';
import 'package:prophunter/screens/search_screen/components/dropdownbox.dart';
import 'package:prophunter/services/queries.dart';
import 'package:prophunter/size_config.dart';
import 'package:prophunter/widgets/bottom_sheet.dart';
import 'package:prophunter/widgets/buttons.dart';
import 'package:prophunter/widgets/loading_dialog.dart';
import 'package:prophunter/widgets/search_bar.dart' as search;
import 'package:prophunter/widgets/text.dart';
import 'package:provider/provider.dart';

import '../../../models/bedrooms.dart';
import '../../../models/status.dart';
import '../../property_list/property_list.dart';
import 'title_widget.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Community> selectedCommunities = [];
  List<Properties> selectedProperties = [];
  List<Status> selectedStatus = [];
  List<BedRoom> selectedBedRoom = [];
  List<Community> communityList = [];
  List<Properties> propertyList = [];
  List<Status> statusList = [];
  List<PropertyType> propertyTypeList = [];
  double maxPrice = 0;
  int divisions = 0;

  List<PropertyType> selectedPropertyType = [];
  RangeValues price = RangeValues(0, 1000000);

  void bottomSheetCallback(List items) {
    selectedCommunities = Community.dynamicToList(items);
    print(selectedCommunities);
    setState(() {});
  }

  void propertyBottomSheet(List items) {
    selectedProperties = items.map<Properties>((e) => e).toList();
    setState(() {});
  }

  void statusChip(value, index) {
    if (value)
      selectedStatus.add(statusList[index]);
    else {
      selectedStatus.remove(statusList[index]);
    }
    setState(() {});
  }

  void bedRoomChip(value, index) {
    if (value)
      selectedBedRoom.add(bedRoom[index]);
    else {
      selectedBedRoom.remove(bedRoom[index]);
    }
    setState(() {});
  }

  void propertyTypeChip(value, index) {
    if (value)
      selectedPropertyType.add(propertyTypeList[index]);
    else {
      selectedPropertyType.remove(propertyTypeList[index]);
    }
    setState(() {});
  }

  @override
  void initState() {
    BasicDataProvider basicProvider = Provider.of<BasicDataProvider>(context, listen: false);
    PropertyProvider propertyProvider = Provider.of<PropertyProvider>(context, listen: false);

    communityList = basicProvider.getCommunityList;
    maxPrice = basicProvider.priceMax.toDouble();
    divisions = basicProvider.priceMin.toInt();
    propertyTypeList = basicProvider.getPropertyTypeList;
    statusList = basicProvider.getStatusTypeList;
    propertyList = propertyProvider.propertyList;

    price = RangeValues(0, maxPrice);
    setState(() {});
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                search.SearchBar(),
                defaultSpace2x,
                TitleWidget(press: () {}, title: "Community & Property"),
                defaultSpace3x,
                DropDownBox(
                    hintText: "Select Community",
                    press: () {
                      bottomSheet(context, communityList, "Select Community", bottomSheetCallback);
                      // print(ans);
                    }),
                Wrap(
                  spacing: 10,
                  children: List.generate(
                      selectedCommunities.length,
                      (index) => Chip(
                            onDeleted: () {
                              selectedCommunities.removeAt(index);
                              setState(() {});
                            },
                            label: Text(
                              selectedCommunities[index].name,
                              style: titleWhite15,
                            ),
                            side: BorderSide(color: fadeWhite),
                          )),
                ),
                defaultSpace3x,
                DropDownBox(
                    hintText: "Select Properties",
                    press: () {
                      bottomSheet(context, propertyList, "Select Property", propertyBottomSheet);
                      // print(ans);
                    }),
                Wrap(
                  spacing: 10,
                  children: List.generate(
                      selectedProperties.length,
                      (index) => Chip(
                            onDeleted: () {
                              selectedProperties.removeAt(index);
                              setState(() {});
                            },
                            label: Text(
                              selectedProperties[index].name,
                              style: titleWhite15,
                            ),
                            side: BorderSide(color: fadeWhite),
                          )),
                ),
                defaultSpace3x,
                TitleWidget(
                    press: () {
                      selectedStatus.clear();
                      setState(() {});
                    },
                    title: "Project Status"),
                defaultSpace2x,
                Chips(items: statusList, press: statusChip, selectItems: selectedStatus),
                defaultSpace3x,
                TitleWidget(
                    press: () {
                      selectedPropertyType.clear();
                      setState(() {});
                    },
                    title: "Property Type"),
                defaultSpace2x,
                Chips(
                    items: propertyTypeList,
                    press: propertyTypeChip,
                    selectItems: selectedPropertyType),
                defaultSpace3x,
                TitleWidget(
                    press: () {
                      selectedBedRoom.clear();
                      setState(() {});
                    },
                    title: "Bedrooms"),
                defaultSpace2x,
                Chips(
                    items: bedRoom,
                    press: bedRoomChip,
                    selectItems: selectedBedRoom,
                    isBedRoom: true),
                defaultSpace3x,
                TitleWidget(
                    press: () {
                      price = RangeValues(0, maxPrice);
                      setState(() {});
                    },
                    title: "Price (AED)"),
                RangeSlider(
                  values: price,
                  max: maxPrice,
                  divisions: divisions,
                  labels: RangeLabels(
                    price.start.round().toString(),
                    price.end.round().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      price = values;
                    });
                  },
                  activeColor: fadeWhite,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * .1,
                )
              ],
            ),
          ),
        ),
        Positioned(
            bottom: 0,
            child: Container(
                width: SizeConfig.screenWidth,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                    color: kFadeBlack, border: Border(top: BorderSide(color: fadeWhite))),
                child: DefaultButton(
                    text: "Search",
                    press: () async {
                      showLoaderDialog(context);
                      List<Units> units = await CustomQuery().getComplexQuery(
                          selectedProperties,
                          selectedCommunities,
                          selectedStatus,
                          selectedPropertyType,
                          price.end.round(),
                          price.start.round(),
                          selectedBedRoom,
                          context);
                      Navigator.pop(context);
                      pushNewScreen(
                        context,
                        screen: PropertyList(
                          unitList: units,
                        ),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.cupertino,
                      );
                    })))
      ],
    );
  }
}
