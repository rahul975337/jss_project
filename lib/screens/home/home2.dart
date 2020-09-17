// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:bottom_animation/bottom_animation.dart';
// import 'package:jss_project/constants/constants.dart';
// import 'package:jss_project/screens/home/home.dart';
// import 'package:jss_project/screens/maintainance/maintainance.dart';
// import 'package:jss_project/screens/permission/permission.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   var items = <BottomNavItem>[
//     BottomNavItem(
//       title: 'Home',
//       iconData: Icons.home,
//     ),
//     BottomNavItem(title: 'Profile', iconData: Icons.account_circle),
//     BottomNavItem(title: 'Search', iconData: Icons.arrow_back_ios),
//     BottomNavItem(title: 'Search', iconData: Icons.search),
//   ];
//   var pages = [Home(), Maintainance(), Permssion(), Map()];
//   var cIndex;
//   @override
//   void initState() {
//     cIndex = 0;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'example',
//       theme: ThemeData.dark(
//           // primarySwatch: Colors.indigo,
//           // visualDensity: VisualDensity.adaptivePlatformDensity,
//           ),
//       home: Scaffold(
//         backgroundColor: Colors.white,
//         body: Container(
//           height: 500,
//           width: 500,
//           color: Colors.amber,
//         ),
//         bottomNavigationBar: BottomAnimation(
//           selectedIndex: cIndex,
//           items: items,
//           backgroundColor: kProfSecondaryBackgroundColor,
//           onItemSelect: (value) {
//             setState(() {
//               cIndex = value;
//             });
//             // Navigator.push(
//             //   context,
//             //   MaterialPageRoute(builder: (context) => pages[cIndex]),
//             // );
//           },
//           itemHoverColor: Colors.white,
//           itemHoverColorOpacity: .2,
//           activeIconColor: Colors.white,
//           deactiveIconColor: Colors.white70,
//           barRadius: 20,
//           textStyle: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 18,
//           ),
//           itemHoverWidth: 135,
//           itemHoverBorderRadius: 20,
//         ),
//       ),
//     );
//   }
// }
