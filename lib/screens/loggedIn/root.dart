import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:jss_project/helperFunctions/sharedFunctions.dart';
import 'package:jss_project/screens/loggedIn/Map/map.dart';
import 'package:jss_project/screens/loggedIn/chats/chat_screen.dart';
import 'package:jss_project/screens/loggedIn/home/homePage.dart';
import 'package:jss_project/screens/loggedIn/hostelites/hostelites.dart';
import 'package:jss_project/screens/loggedIn/maintainance/maintainance.dart';
import 'package:jss_project/screens/loggedIn/permission/permission.dart';
import 'package:jss_project/screens/loggedIn/settings/settings.dart';
import 'package:jss_project/shared/bottomNav.dart';
import 'package:jss_project/shared/loading.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  final key = GlobalKey();
  PageController _pageController;
  int _page = 0;
  double _safePaddingTop, _safePaddingBottom, _height, _width, _keyboard;
  double height;
  String _myName = '';
  String _myImage = '';
  // final DatabaseService _databaseService = DatabaseService();

  _setFunction() async {
    await SharedFunctions.getUserNameSharedPreference().then((value) {
      setState(() => _myName = value);
      print(_myName);
    });
     await SharedFunctions.getUserImageSharedPreference().then((imageLink) {
      setState(() => _myImage = imageLink);
    });
  }

  void _navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _setFunction();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void _onPageChanged(int page) {
    height = key.currentContext.size.height;
    print(height);
    setState(() {
      this._page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    _safePaddingTop = MediaQuery.of(context).padding.top;
    _safePaddingBottom = MediaQuery.of(context).padding.bottom;
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height -
        (_safePaddingBottom + _safePaddingTop);
    _keyboard = MediaQuery.of(context).viewInsets.bottom;
    return _myName == '' && _myImage == ''
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.blue,
            body: Container(
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: _pageController,
                onPageChanged: _onPageChanged,
                children: <Widget>[
                  Home4(),
                  Maintainance(),
                  Permssion(),
                  Hostelites(),
                  SettingsPage(),
                  ChatScreen(),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              key: key,
              child: BottomNav(
                items: <IconData>[
                  FeatherIcons.home,
                  FeatherIcons.hardDrive,
                  FeatherIcons.phoneOutgoing,
                  FeatherIcons.users,
                  FeatherIcons.settings,
                  FeatherIcons.messageSquare
                ],
                width: double.infinity,
                onTap: _navigationTapped,
                currentIndex: _page,
              ),
            ),
          );
  }
}
