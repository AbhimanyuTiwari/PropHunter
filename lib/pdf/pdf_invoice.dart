import 'dart:io';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:prophunter/constant.dart';
import 'package:prophunter/models/bedrooms.dart';
import 'package:prophunter/models/properties.dart';
import 'package:prophunter/pdf/pdf_open.dart';

import '../models/units.dart';

class PdfInvoice {
  static Future<File> generate({required Properties properties, required Units units}) async {
    // print(data[0]);
    final pdf = Document();
    final logo = pw.MemoryImage(
      (await rootBundle.load('assets/images/logo_white_background.jpg')).buffer.asUint8List(),
    );

    List<pw.ImageProvider> imageList = [], media = [];
    for (var image in properties.images) {
      pw.ImageProvider netImage = await networkImage(image);
      imageList.add(netImage);
    }
    for (var image in properties.media) {
      pw.ImageProvider netImage = await networkImage(image);
      media.add(netImage);
    }
    // for(var image in properties.)
    List<List<String>> list = [];
    int price = units.price;
    DateTime date = DateTime.now();
    for (int i = 0; i < properties.installment.length; i++) {
      double percent = properties.installment[i]['percent'];
      DateTime newDate = date.add(Duration(days: properties.installment[i]['daysAfter']));
      String formatedDate = DateFormat('yyyy-mm-dd').format(newDate);
      int result = ((price * percent) / 100).round();

      list.add([
        properties.installment[i]['name'],
        properties.installment[i]['percent'].toString(),
        formatedDate,
        result.toString()
      ]);
    }
    print(date);
    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(formatDateMMMd(date), properties.name, date),
        pw.Divider(),

        pw.SizedBox(height: PdfPageFormat.cm * 1),
        buildTitle(imageList[0], properties, logo),

        pw.SizedBox(height: PdfPageFormat.cm * 1),
        pw.Padding(
          padding: pw.EdgeInsets.symmetric(horizontal: PdfPageFormat.cm * 1),
          child: pw.Column(children: [
            buildPropertyDetails(properties, units),
            pw.SizedBox(height: PdfPageFormat.cm * 1),
            pw.Container(
                padding: pw.EdgeInsets.all(10),
                width: double.infinity,
                alignment: pw.Alignment.centerLeft,
                color: PdfColors.black,
                child: Text("Installments",
                    style: pw.TextStyle(
                        color: PdfColors.white, fontWeight: pw.FontWeight.bold, fontSize: 13))),
            pw.SizedBox(height: PdfPageFormat.cm * 1),
            buildInvoice(['Milestone', 'Percentage', 'Date', 'Amount\n(AED)'], list),
          ]),
        ),

        // Divider(),
      ],
      footer: (context) => buildFooter(),
    ));
    if (media.isNotEmpty) {
      pdf.addPage(
        MultiPage(
          margin: EdgeInsets.all(20),
          build: (context) => [
            pw.Center(
                child: pw.Column(children: [
              pw.Container(
                  padding: pw.EdgeInsets.all(10),
                  width: double.infinity,
                  alignment: pw.Alignment.centerLeft,
                  color: PdfColors.black,
                  child: Text("Floor Plan",
                      style: pw.TextStyle(
                          color: PdfColors.white, fontWeight: pw.FontWeight.bold, fontSize: 13))),
              pw.SizedBox(height: PdfPageFormat.cm),
              ...List.generate(
                  media.length,
                  (index) => Image(media[index],
                      height: PdfPageFormat.a4.width * .85,
                      width: PdfPageFormat.a4.width * .85,
                      fit: pw.BoxFit.fill))
            ])),
          ],
          footer: (context) => buildFooter(),
        ),
      );
    }
    if (imageList.isNotEmpty) {
      pdf.addPage(
        MultiPage(
          margin: EdgeInsets.all(20),
          build: (context) => [
            pw.Center(
                child: pw.Column(children: [
              pw.Container(
                  padding: pw.EdgeInsets.all(10),
                  width: double.infinity,
                  alignment: pw.Alignment.centerLeft,
                  color: PdfColors.black,
                  child: Text("Properties Image",
                      style: pw.TextStyle(
                          color: PdfColors.white, fontWeight: pw.FontWeight.bold, fontSize: 13))),
              pw.SizedBox(height: PdfPageFormat.cm),
            ])),
            pw.Wrap(
                runSpacing: PdfPageFormat.a4.width * .01,
                spacing: PdfPageFormat.a4.width * .01,
                children: List.generate(
                    imageList.length,
                    (index) => Image(imageList[index],
                        height: PdfPageFormat.a4.width * .45,
                        width: PdfPageFormat.a4.width * .45,
                        fit: pw.BoxFit.fill)))
          ],
          footer: (context) => buildFooter(),
        ),
      );
    }

    return PdfOpen.saveDocument(name: '${properties.name}.pdf', pdf: pdf);
  }

  static Widget buildHeader(title, subtitle, date) => Container(
      width: double.infinity,
      padding: pw.EdgeInsets.only(left: 20, right: 20),
      alignment: pw.Alignment.centerLeft,
      // color: PdfColor.fromHex('000000'),
      child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
        Text(
          '$title, ${DateFormat('hh:mm a').format(date)}',
          style: TextStyle(color: PdfColors.black, fontSize: 12),
        ),
        Text(
          ('$subtitle | Sales Offer').toUpperCase(),
          style: TextStyle(color: PdfColors.black, fontSize: 12),
        ),
      ]));

  //
  static Widget buildTitle(ImageProvider image, Properties property, pw.ImageProvider logo) {
    return Row(children: [
      pw.Image(image,
          width: PdfPageFormat.a4.width * .4,
          height: PdfPageFormat.a4.width * .4,
          fit: pw.BoxFit.fill),
      pw.SizedBox(width: PdfPageFormat.cm * 3),
      pw.Column(children: [
        pw.Image(logo,
            height: PdfPageFormat.a4.width * 0.08,
            width: PdfPageFormat.a4.width * 0.18,
            fit: pw.BoxFit.fill),
        pw.SizedBox(height: PdfPageFormat.cm * 0.5),
        pw.Container(
            alignment: pw.Alignment.center,
            child: Text(property.name,
                style: pw.TextStyle(fontSize: 25, fontWeight: pw.FontWeight.bold))),
        pw.SizedBox(height: PdfPageFormat.cm),
        Text('Sales Offer', style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold))
      ])
    ]);
  }

  //
  static Widget buildInvoice(List<String> head, List<List> data) {
    List<List> details = [];
    print(data[0]);
    for (int i = 0; i < data.length; i++) {
      details.add([i + 1, ...data[i]]);
    }
    List<String> headers = ['Sno', ...head];
    return Table.fromTextArray(
      headerFormat: (i, d) => headers[i].toUpperCase(),
      cellAlignment: pw.Alignment.center,
      headers: headers,
      border: const pw.TableBorder(
        horizontalInside: pw.BorderSide(color: PdfColors.black, width: 1.5),
      ),
      oddRowDecoration: pw.BoxDecoration(
        color: PdfColor.fromHex('D9D9D9'),
      ),
      rowDecoration: pw.BoxDecoration(
        color: PdfColor.fromHex('ffffff'),
      ),
      data: details,
      headerStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: PdfColors.black,
          fontSize: (headers.length > 7) ? 7 : 11),
      headerDecoration: BoxDecoration(color: PdfColor.fromHex('fff')),
      cellHeight: 40,
      cellStyle: pw.TextStyle(fontSize: (headers.length > 7) ? 7 : 11, color: PdfColors.black),
      cellAlignments: {
        0: Alignment.centerLeft,
      },
    );
  }

  //
  static Widget buildPropertyDetails(Properties properties, Units units) {
    return pw.Column(children: [
      buildText(title: 'Project', value: properties.name),
      buildText(title: 'Community', value: communityMap[properties.communityId]!.name),
      buildText(title: 'Unit Name', value: units.name),
      buildText(title: 'Unit Position', value: units.position),
      buildText(title: 'Property Type', value: propertyTypeMap[properties.propertyTypeId]!.name),
      buildText(title: 'Bed Rooms', value: bedRoomMap[units.bedrooms]!.name),
      buildText(title: 'Status', value: statusMap[units.statusId]!.name),
      buildText(title: 'Total Area (in sqft)', value: units.size.toString()),
      buildText(title: 'Price', value: "${units.price} AED"),
    ]);
  }

  //
  static pw.Widget buildFooter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Divider(),
        SizedBox(height: 2 * PdfPageFormat.mm),
        pw.Center(
          child: pw.Text(
              "Disclaimer:\nThe contents of this sales offer, floor plans brochure"
              " is for illustrative purposes only. The designs, facilities,"
              " amenities, numbering, and layout of the units in the Project"
              " are not final and may be subject to change by the developer. "
              "Neither Prophunter (or their respective agents, consultants, "
              "affiliates or employees), warrants or assumes any legal liability"
              " or responsibility in any way for the accuracy, completeness, or "
              "usefulness of any information or illustrations contained within "
              "this floor plans brochure.",
              style: pw.TextStyle(fontSize: 11)),
        )
      ],
    );
  }

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  //
  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold, fontSize: 12);

    return Container(
        width: width,
        child: pw.Column(children: [
          Row(
            children: [
              Expanded(child: Text(title, style: style)),
              Text(value, style: unite ? style : null),
            ],
          ),
          pw.Divider(),
        ]));
  }
}
