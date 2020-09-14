import 'package:flutter/material.dart';
import 'package:jss_project/screens/Map/map.dart';
import 'package:jss_project/screens/Profile/profile.dart';

import 'screens/home/home.dart';

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
      theme: ThemeData(),
      home: MapSample(),
    );
  }
}
