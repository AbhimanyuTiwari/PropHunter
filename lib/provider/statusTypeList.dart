import 'package:flutter/cupertino.dart';

import '../models/status.dart';

class StatusTypeProvider extends ChangeNotifier {
  List<Status> _statusType = [];
  bool _isStatusLoading = true;

  void addStatusElement(Status type) {
    _statusType.add(type);
    notifyListeners();
  }

  void removeStatusElement(Status type) {
    _statusType.remove(type);
    notifyListeners();
  }

  void createStatusList(List<Status> prop) {
    _statusType = prop;
    notifyListeners();
  }

  void changeStatusElement(Status type, int index) {
    _statusType[index] = type;
    notifyListeners();
  }

  bool get isStatusLoading => _isStatusLoading;

  List<Status> get statusTypeList => _statusType;
}
