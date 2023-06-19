import 'dart:core';

class Installment {
  String name;
  double percent;
  int id;
  num daysAfter;

  Installment(
      {required this.id, required this.name, required this.percent, required this.daysAfter});
}
