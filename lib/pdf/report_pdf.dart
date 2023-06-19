// import 'dart:io';
//
// import 'package:flutter/services.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/widgets.dart';
// import 'package:prophunter/pdf/pdf_open.dart';
//
// class ReportPdf {
//   static Future<File> generate(
//       // {
//       //   required List<List<List>> list,
//       // required String collection,
//       // required String title,
//       // required String purpose,
//       // required masjidName,
//       // required List<String> headings
//       // }
//       ) async {
//     final pdf = Document();
//     final image = pw.MemoryImage(
//       (await rootBundle.load('assets/images/alhisab.png')).buffer.asUint8List(),
//     );
//
//     pdf.addPage(MultiPage(
//       margin: EdgeInsets.all(20),
//       build: (context) => [
//         buildHeader(title),
//         SizedBox(height: 1 * PdfPageFormat.cm),
//         buildTitle(title, masjidName, purpose, collection),
//         pw.Column(
//           mainAxisAlignment: pw.MainAxisAlignment.center,
//           children: List.generate(
//             list.length,
//             (index) => pw.Column(children: [
//               SizedBox(height: 1 * PdfPageFormat.cm),
//               pw.Text(headings[index],
//                   style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//               pw.Center(child: buildInvoice(list[index]))
//             ]),
//           ),
//         ),
//       ],
//       footer: (context) => buildFooter(image),
//     ));
//
//     return PdfOpen.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
//   }
//
//   static Widget buildHeader(title) => Container(
//       height: 70,
//       width: double.infinity,
//       padding: pw.EdgeInsets.only(left: 20),
//       alignment: pw.Alignment.centerLeft,
//       color: PdfColor.fromHex('49C4FE'),
//       child: Text(
//         title,
//         style: TextStyle(
//             fontWeight: pw.FontWeight.bold,
//             color: PdfColors.white,
//             fontSize: 24),
//       ));
//
//   static Widget buildTitle(title, masjibName, purpose, collectionName) {
//     return pw.Center(
//         child: Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           '$masjibName - $title - $purpose ',
//           style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 0.8 * PdfPageFormat.cm),
//       ],
//     ));
//   }
//
//   static Widget buildInvoice(List<List> data) {
//     List<List> details = [];
//     List<String> headers = ['Sno', ...data[0]];
//     data.removeAt(0);
//     for (int i = 0; i < data.length; i++) {
//       details.add([i + 1, ...data[i]]);
//     }
//
//     return Table.fromTextArray(
//       headerFormat: (i, d) => headers[i].toUpperCase(),
//       cellAlignment: pw.Alignment.center,
//       tableWidth: pw.TableWidth.min,
//       headers: headers,
//       border: const pw.TableBorder(
//         horizontalInside: pw.BorderSide(color: PdfColors.white, width: 1.5),
//         verticalInside: pw.BorderSide(color: PdfColors.white, width: 1.5),
//       ),
//       oddRowDecoration: pw.BoxDecoration(
//         color: PdfColor.fromHex('DBE5F1'),
//       ),
//       rowDecoration: pw.BoxDecoration(
//         color: PdfColor.fromHex('B8CCE4'),
//       ),
//       data: details,
//       headerStyle:
//           TextStyle(fontWeight: FontWeight.bold, color: PdfColors.white),
//       headerDecoration: BoxDecoration(color: PdfColor.fromHex('4F81BD')),
//       cellHeight: 40,
//       cellStyle: pw.TextStyle(fontSize: 12),
//       cellAlignments: {
//         0: Alignment.centerLeft,
//       },
//     );
//   }
//
//   static Widget buildTotal(String total, String purpose) {
//     return Container(
//       alignment: Alignment.centerRight,
//       child: Row(
//         children: [
//           Spacer(flex: 6),
//           Expanded(
//             flex: 4,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 buildText(
//                   title:
//                       (purpose == 'Attendance') ? "Total Student" : 'Net total',
//                   value: total,
//                   unite: true,
//                 ),
//                 SizedBox(height: 2 * PdfPageFormat.mm),
//                 Container(height: 1, color: PdfColors.grey400),
//                 SizedBox(height: 0.5 * PdfPageFormat.mm),
//                 Container(height: 1, color: PdfColors.grey400),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   static pw.Widget buildFooter(image) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Divider(),
//         SizedBox(height: 2 * PdfPageFormat.mm),
//         pw.Center(
//           child: pw.Image(image, height: 40),
//         )
//       ],
//     );
//   }
//
//   static buildSimpleText({
//     required String title,
//     required String value,
//   }) {
//     final style = TextStyle(fontWeight: FontWeight.bold);
//
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: pw.CrossAxisAlignment.end,
//       children: [
//         Text(title, style: style),
//         SizedBox(width: 2 * PdfPageFormat.mm),
//         Text(value),
//       ],
//     );
//   }
//
//   static buildText({
//     required String title,
//     required String value,
//     double width = double.infinity,
//     TextStyle? titleStyle,
//     bool unite = false,
//   }) {
//     final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);
//
//     return Container(
//       width: width,
//       child: Row(
//         children: [
//           Expanded(child: Text(title, style: style)),
//           Text(value, style: unite ? style : null),
//         ],
//       ),
//     );
//   }
// }
