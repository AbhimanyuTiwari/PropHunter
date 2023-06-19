import 'package:flutter/cupertino.dart';

import '../models/units.dart';

class UnitProvider extends ChangeNotifier {
  List<Units> _units = [];
  bool _isLoading = true;

  void addElement(Units type) {
    _units.add(type);
    notifyListeners();
  }

  void removeElement(int index) {
    _units.removeAt(index);
    notifyListeners();
  }

  void createPropertyList(List<Units> prop) {
    _units = prop;

    notifyListeners();
  }

  void changeElement(Units type, int index) {
    _units[index] = type;
    notifyListeners();
  }

  void changeLoading() {
    _isLoading = false;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  List<Units> get unitList => _units;
}
