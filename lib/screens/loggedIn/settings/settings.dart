import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:jss_project/constants/constants.dart';
import 'package:jss_project/helperFunctions/sharedFunctions.dart';
import 'package:jss_project/main.dart';
import 'package:jss_project/screens/loggedIn/root.dart';
import 'package:jss_project/services/auth.dart';
import 'package:jss_project/services/database.dart';
import 'package:jss_project/shared/loading.dart';
import 'package:jss_project/shared/provider/mode.dart';
import 'package:page_transition/page_transition.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double _safePaddingTop, _safePaddingBottom, _keyboard;
  final AuthService _auth = AuthService();
  final DatabaseService _database = DatabaseService();
  final Mode mode = Mode();

  double _height, _width;
  List settingsTitles = [
    'Account',
    'Accessibility',
    'Notifications',
    'Report Problem',
    'Legals',
    'Rate Us',
    'Log Out'
  ];
  List settingsSubTitles = [
    'Personal, Kiosk, Profile',
    'Comfortability Handed Operationality',
    'Messages , offers,call tones',
    'Report bugs, technical problems',
    'Terms of Use, User Agreement',
    'Rate Us for our services',
    'Log out'
  ];
  List settingsIconList = [
    FeatherIcons.user,
    FeatherIcons.book,
    FeatherIcons.bell,
    FeatherIcons.anchor,
    FeatherIcons.package,
    FeatherIcons.star,
    FeatherIcons.logOut,
  ];
  List settingsRoutesList = [null, null, null, null, null, null, null];
  String userName = '', userCitotoID = '', userImage = '';
  _settingData() async {
    await SharedFunctions.getUserNameSharedPreference().then((name) {
      setState(() => userName = name);
    });
    await SharedFunctions.getUserCitotoIdSharedPreference().then((id) {
      setState(() => userCitotoID = id);
    });
    await SharedFunctions.getUserImageSharedPreference().then((imageLink) {
      setState(() => userImage = imageLink);
    });
  }

  @override
  void initState() {
    super.initState();
    _settingData();
  }

  @override
  Widget build(BuildContext context) {
    _safePaddingTop = MediaQuery.of(context).padding.top;
    _safePaddingBottom = MediaQuery.of(context).padding.bottom;
    _height = MediaQuery.of(context).size.height -
        (_safePaddingTop + _safePaddingBottom);
    _width = MediaQuery.of(context).size.width;
    _keyboard = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: kProfPrimaryBackgroundColor,
      body: userName == ''&& userImage ==''
          ? Loading()
          : SafeArea(
              child: Container(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: kProfSecondaryBackgroundColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                          ),
                          height: _height / 9,
                          width: _width,
                          child: Container(
                            margin: EdgeInsets.only(
                                left: _width / 12, bottom: _height * 0.02),
                            child: GestureDetector(
                              onTap: () {},
                            ),
                          ),
                        ),
                        Container(
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => SettingsAuth(),
                              //   ),
                              // );
                            },
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: _width / 6),
                                  child: Text(
                                    userName == null ? '' : userName,
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: _height * 0.03,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: _width / 2),
                                  child: Text(
                                    userCitotoID == null
                                        ? ''
                                        : '@$userCitotoID',
                                    style: TextStyle(
                                        color: kProfAccentColour,
                                        fontSize: _height * 0.02,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            // height: _height / 2,
                            width: _width,
                            margin: EdgeInsets.symmetric(
                                horizontal: _width / 6,
                                vertical: _height * 0.07),
                            child: ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                // shrinkWrap: true,
                                itemCount: 7,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                      onTap: () {
                                        if (settingsRoutesList[index] != null) {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType
                                                    .rightToLeftWithFade,
                                                child:
                                                    settingsRoutesList[index]),
                                          );
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              // return object of type Dialog
                                              return AlertDialog(
                                                backgroundColor:
                                                    kProfSecondaryBackgroundColor,
                                                title: new Text(
                                                  "Logout",
                                                  style: TextStyle(
                                                      color: kProfTextColour),
                                                ),
                                                content: new Text(
                                                  "Are you sure you want to Log out?",
                                                  style: TextStyle(
                                                      color: kProfTextColour),
                                                ),
                                                actions: <Widget>[
                                                  // usually buttons at the bottom of the dialog
                                                  new FlatButton(
                                                    child: new Text("Yes"),
                                                    onPressed: () async {
                                                      Navigator.of(context)
                                                          .pop();
                                                      await _auth.signOut();
                                                      Navigator.of(context)
                                                          .popUntil((route) =>
                                                              route.isFirst);
                                                      Navigator.pushReplacement(
                                                        context,
                                                        PageTransition(
                                                            type: PageTransitionType
                                                                .leftToRightWithFade,
                                                            child: MyApp()),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                kProfSecondaryBackgroundColor,
                                            radius: _width * 0.05,
                                            child: Icon(
                                              settingsIconList[index],
                                              color: kProfAccentColour,
                                              size: _width * 0.04,
                                            ),
                                          ),
                                          SizedBox(
                                            width: _width / 20,
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              text:
                                                  '${settingsTitles[index]}\n',
                                              style: TextStyle(
                                                  color: kProfTextColour,
                                                  fontSize: _width * 0.04),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      settingsSubTitles[index],
                                                  style: TextStyle(
                                                      color: Colors.white30,
                                                      fontSize: _width * 0.03),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                separatorBuilder: (context, index) => SizedBox(
                                      height: _height * 0.025,
                                    )),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: _width * 0.2,
                      left: _width * 0.1,
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => SettingsAuth(),
                          //   ),
                          // );
                        },
                        child: userImage != null
                            ? CircleAvatar(
                                backgroundColor: kProfPrimaryBackgroundColor,
                                radius: _width * 0.1,
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  radius: _width * 0.08,
                                  backgroundImage: NetworkImage(userImage),
                                ),
                              )
                            : Container(),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
