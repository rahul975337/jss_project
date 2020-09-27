import 'package:flutter/cupertino.dart';

class Mode extends ChangeNotifier {
  static final Mode _singleton = Mode._internal();
  Mode._internal();

  factory Mode() {
    return _singleton;
  }
  // mode = true => professional
  // mode = false => social
  bool _mode = true;

  get mode => _mode;

  set mode(bool val) {
    _mode = val;
    notifyListeners();
  }
}
