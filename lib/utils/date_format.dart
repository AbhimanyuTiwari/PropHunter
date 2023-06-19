import 'package:intl/intl.dart';

String monthFormat(DateTime date) {
  return DateFormat.yMMMd().format(date);
}
