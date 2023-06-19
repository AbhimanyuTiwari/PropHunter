import 'package:flutter/material.dart';
import 'package:prophunter/constant.dart';
import 'package:prophunter/models/properties.dart';
import 'package:prophunter/models/units.dart';
import 'package:prophunter/pdf/pdf_invoice.dart';
import 'package:prophunter/screens/property_details/components/property_image.dart';
import 'package:prophunter/utils/date_format.dart';
import 'package:prophunter/widgets/loading_dialog.dart';
import 'package:prophunter/widgets/text.dart';

import '../../../models/bedrooms.dart';
import '../../../pdf/pdf_open.dart';
import '../../../size_config.dart';
import '../../../widgets/buttons.dart';

class Body extends StatefulWidget {
  Body({Key? key, required this.property, required this.unit}) : super(key: key);

  final Properties property;
  final Units unit;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var _today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    print(widget.property.installment);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          backButton(context),
          PropertyImage(images: widget.property.images),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(widget.unit.name, style: titleWhite20.copyWith(color: fadeWhite)),
              SizedBox(
                width: SizeConfig.screenWidth * .05,
              ),
              SizedBox(
                width: SizeConfig.screenWidth * .4,
                child: Divider(
                  thickness: 2,
                  color: fadeWhite,
                ),
              ),
            ],
          ),
          Text(
            communityMap[widget.property.communityId]!.name,
            style: TextStyle(color: Colors.white, fontSize: getProportionateScreenHeight(30)),
          ),
          defaultSpace3x,
          // DefaultButton(
          //   text: 'BOOK',
          //   press: () {},
          // ),
          defaultSpace3x,
          customTile('Property Name', widget.property.name),

          customTile('Property Type', propertyTypeMap[widget.property.propertyTypeId]!.name),
          customTile('Unit Position', widget.unit.position),
          customTile('Project Status', statusMap[widget.unit.statusId]!.name),
          customTile('Total Area', widget.unit.size.toString() + " Sqft"),
          customTile('Bedrooms', bedRoomMap[widget.unit.bedrooms]!.name),
          customTile('Price', "AED " + widget.unit.price.toString()),
          defaultSpace3x,
          Text(
            'Installment',
            style: headingWhite22,
          ),
          defaultSpace2x,
          DataTable(
            showCheckboxColumn: false,
            dataRowHeight: 60,
            columns: [
              DataColumn(
                label: Text(
                  'Milestone',
                  style: titleWhite20,
                ),
              ),
              DataColumn(
                label: Text(
                  '%',
                  style: titleWhite20,
                ),
              ),
              DataColumn(
                label: Text(
                  'Date',
                  style: titleWhite20,
                ),
              ),
              DataColumn(
                label: Text(
                  'AED',
                  style: titleWhite20,
                ),
              )
            ],
            columnSpacing: 15,
            rows: List.generate(
              widget.property.installment.length,
              (index) => DataRow(
                  color: MaterialStateProperty.all<Color>(
                      (index % 2 == 0) ? kFadeBlack : kPrimaryColor),
                  cells: [
                    DataCell(
                      Text(
                        widget.property.installment[index]['name'],
                        style: titleWhite15,
                      ),
                    ),
                    DataCell(Text(
                      widget.property.installment[index]['percent'].toString(),
                      style: titleWhite15,
                    )),
                    DataCell(Text(
                      monthFormat(
                        _today.add(
                          Duration(
                            days: widget.property.installment[index]['daysAfter'],
                          ),
                        ),
                      ),
                      style: titleWhite15,
                    )),
                    DataCell(Text(
                      (widget.property.installment[index]['percent'] / 100 * widget.unit.price)
                          .round()
                          .toString(),
                      style: titleWhite15,
                    )),
                  ]),
            ),
          ),
          defaultSpace3x,
          Text(
            'Floor Plan',
            style: headingWhite22,
          ),
          defaultSpace2x,
          PropertyImage(images: widget.property.media),
          defaultSpace2x,
          defaultSpace2x,
          DefaultButton(
            text: 'Share',
            press: () async {
              showLoaderDialog(context);
              final pdfFile =
                  await PdfInvoice.generate(properties: widget.property, units: widget.unit);
              print("hello");
              Navigator.pop(context);
              PdfOpen.openFile(pdfFile);
            },
          ),

          defaultSpace2x,
        ],
      ),
    );
  }

  Widget customTile(String text1, String text2) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(border: Border(top: BorderSide(color: fadeWhite, width: 0.3))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text1.toUpperCase(),
            style: titleWhite20,
          ),
          Text(
            text2,
            style: titleWhite20,
          ),
        ],
      ),
    );
  }
}
