import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:prophunter/constant.dart';
import 'package:prophunter/models/units.dart';
import 'package:prophunter/screens/property_list/components/grid_view_property.dart';
import 'package:prophunter/screens/property_list/components/list_view_property.dart';
import 'package:prophunter/screens/search_screen/search_screen.dart';
import 'package:prophunter/widgets/search_bar.dart' as search;

import '../../../size_config.dart';
import '../../../widgets/alert_box.dart';
import '../../../widgets/text.dart';

class Body extends StatefulWidget {
  Body({Key? key, required this.unitList}) : super(key: key);
  List<Units> unitList;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool viewGrid = true;
  String selectedSort = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          search.SearchBar(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              optionBox('Filter', CupertinoIcons.text_alignleft, () {
                pushNewScreen(context, screen: SearchScreen());
              }),
              optionBox('Sorting', CupertinoIcons.sort_up, () {
                showAlertDialog(
                    context: context,
                    title: 'Sort',
                    child: sortBox(),
                    press: () {
                      if (selectedSort == "PRICELOW")
                        widget.unitList.sort((a, b) => a.price.compareTo(b.price));
                      else if (selectedSort == "PRICEHIGH")
                        widget.unitList.sort((a, b) => b.price.compareTo(a.price));
                      else if (selectedSort == "SIZELOW")
                        widget.unitList.sort((a, b) => a.size.compareTo(b.size));
                      else if (selectedSort == "SIZEHIGH")
                        widget.unitList.sort((a, b) => b.size.compareTo(a.size));
                      else if (selectedSort == "BEDROOM")
                        widget.unitList.sort((a, b) => a.bedrooms.compareTo(b.bedrooms));
                      setState(() {});
                    });
              }),
              optionBox(
                  'View', viewGrid ? CupertinoIcons.list_bullet : CupertinoIcons.rectangle_grid_2x2,
                  () {
                viewGrid = !viewGrid;
                setState(() {});
              }),
            ],
          ),
          defaultSpace3x,
          Expanded(
            child: SingleChildScrollView(
              child: viewGrid
                  ? GridViewProperty(unitList: widget.unitList)
                  : ListViewProperty(unitList: widget.unitList),
            ),
          ),
        ],
      ),
    );
  }

  Widget optionBox(String text, IconData icon, VoidCallback press) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: fadeWhite, width: 0.5)),
      onPressed: press,
      icon: Icon(
        icon,
        color: kSecondaryColor,
        size: getProportionateScreenWidth(18),
      ),
      label: Text(
        text,
        style: titleWhite18,
      ),
    );
  }

  Widget sortBox() {
    return StatefulBuilder(builder: (context, setState) {
      return Container(
        child: Column(
          children: [
            CheckboxListTile(
              shape: Border(top: BorderSide(color: fadeWhite, width: 0.5)),
              title: Text(
                "Price (Low to High)",
                style: titleWhite18,
              ),
              //    <-- label
              value: selectedSort == 'PRICELOW',
              checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              activeColor: Colors.blue,
              onChanged: (newValue) {
                if (newValue!) {
                  selectedSort = "PRICELOW";
                } else {
                  selectedSort = "";
                }
                setState(() {});
              },
            ),
            CheckboxListTile(
              shape: Border(top: BorderSide(color: fadeWhite, width: 0.5)),
              title: Text(
                "Price (High to Low)",
                style: titleWhite18,
              ),
              //    <-- label
              value: selectedSort == 'PRICEHIGH',
              checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              activeColor: Colors.blue,
              onChanged: (newValue) {
                if (newValue!) {
                  selectedSort = "PRICEHIGH";
                } else {
                  selectedSort = "";
                }
                setState(() {});
              },
            ),
            CheckboxListTile(
              shape: Border(top: BorderSide(color: fadeWhite, width: 0.5)),
              title: Text(
                "Size (Low to High)",
                style: titleWhite18,
              ),
              //    <-- label
              value: selectedSort == 'SIZELOW',
              checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              activeColor: Colors.blue,
              onChanged: (newValue) {
                if (newValue!) {
                  selectedSort = "SIZELOW";
                } else {
                  selectedSort = "";
                }
                setState(() {});
              },
            ),
            CheckboxListTile(
              shape: Border(top: BorderSide(color: fadeWhite, width: 0.5)),
              title: Text(
                "Size (Hight to Low)",
                style: titleWhite18,
              ),
              //    <-- label
              value: selectedSort == 'SIZEHIGH',
              checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              activeColor: Colors.blue,
              onChanged: (newValue) {
                if (newValue!) {
                  selectedSort = "SIZEHIGH";
                } else {
                  selectedSort = "";
                }
                setState(() {});
              },
            ),
            CheckboxListTile(
              shape: Border(top: BorderSide(color: fadeWhite, width: 0.5)),
              title: Text(
                "Bedroom",
                style: titleWhite18,
              ),
              //    <-- label
              value: selectedSort == 'BEDROOM',
              checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              activeColor: Colors.blue,
              onChanged: (newValue) {
                if (newValue!) {
                  selectedSort = "BEDROOM";
                } else {
                  selectedSort = "";
                }
                setState(() {});
              },
            ),
          ],
        ),
      );
    });
  }
}
