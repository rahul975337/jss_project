import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jss_project/models/user.dart';
import 'package:jss_project/screens/loggedIn/home/homePage.dart';
import 'package:jss_project/screens/loggedIn/root.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../helperFunctions/sharedFunctions.dart';
import 'authenticate/login.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    bool _logged = false;

    _setFunction() async {
      await SharedFunctions.getUserIDSharedPreference().then((value) {
        CurrentUser(uID: value);
        Constants.myUID = value;
      });
    }

    _getLoggedIn() async {
      await SharedFunctions.getUserLoggedInSharedPreference().then((value) {
        _logged = value;
      });
    }

    _getLoggedIn();
    if (!_logged) {
      if (user == null) {
        return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Login());
      } else {
        _setFunction();
        return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Root());
      }
    } else {
      _setFunction();
      return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Root());
    }
  }
}
