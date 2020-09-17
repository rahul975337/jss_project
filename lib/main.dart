import 'package:flutter/material.dart';
import 'package:jss_project/feasting.dart';
import 'package:jss_project/screens/home/home.dart';
import 'package:jss_project/root.dart';
import 'package:jss_project/screens/home/homePage.dart';
import 'package:jss_project/screens/permission/permission.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: Root(),
    );
  }
}
