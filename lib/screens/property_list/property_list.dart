import 'package:flutter/material.dart';

import '../../models/units.dart';
import '../../size_config.dart';
import 'components/body.dart';

class PropertyList extends StatelessWidget {
  static String routeName = '/property_list';

  PropertyList({Key? key, required this.unitList}) : super(key: key);
  List<Units> unitList;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Body(unitList: unitList),
      ),
    );
  }
}
