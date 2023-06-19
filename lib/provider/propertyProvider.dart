import 'package:flutter/cupertino.dart';

import '../constant.dart';
import '../models/properties.dart';

class PropertyProvider extends ChangeNotifier {
  List<Properties> _property = [];
  Map<int, Properties> _propertyMap = {};
  bool _isLoading = true;

  void addElement(Properties type) {
    _property.add(type);
    _propertyMap[type.id] = type;
    notifyListeners();
  }

  void createPropertyList(List<Properties> prop) {
    _property = prop;
    propertyMap.clear();
    for (int i = 0; i < prop.length; i++) {
      propertyMap[prop[i].id] = prop[i];
    }
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  List<Properties> get propertyList => _property;

  List<Properties> getSuggestions(String query) {
    List<Properties> matches = <Properties>[];
    matches.addAll(_property);
    matches.retainWhere((property) => property.name.toLowerCase().contains(query.toLowerCase()));
    List<Properties> prop = [];
    for (int i = 0; i < matches.length && i < 7; i++) {
      prop.add(matches[i]);
    }
    return prop;
  }
}
