// import 'package:flutter/material.dart';

// class UserIdProvider extends ChangeNotifier {
//   String _userId = '';

//   String get userId => _userId;

//   setUserId(String userId) {
//     _userId = userId;
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';

class UserIdProvider extends ChangeNotifier {
  String _userId = '';

  String get userId => _userId;

  void setUserId(String userId) {
    _userId = userId;
    notifyListeners();
  }
}
