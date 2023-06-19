import 'package:flutter/material.dart';
import 'package:prophunter/models/properties.dart';

import '../../models/units.dart';
import '../../size_config.dart';
import 'components/body.dart';

class PropertyDetails extends StatelessWidget {
  final Properties property;
  final Units unit;

  const PropertyDetails({Key? key, required this.property, required this.unit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Body(
          property: property,
          unit: unit,
        )),
      ),
    );
  }
}
