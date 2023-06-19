import 'package:flutter/cupertino.dart';
import 'package:prophunter/models/user.dart';

class UserProvider extends ChangeNotifier {
  UserData _user = UserData(phoneNo: "", name: "name", email: "email");

  void setUser(user) {
    _user = user;
    notifyListeners();
  }

  UserData get getUser => _user;
}
