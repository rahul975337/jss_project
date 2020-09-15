import 'package:flutter/material.dart';
import 'package:jss_project/constants/constants.dart';
import 'package:jss_project/screens/hostelites/timeline.dart';

class Hostelites extends StatefulWidget {
  @override
  _HostelitesState createState() => _HostelitesState();
}

class _HostelitesState extends State<Hostelites> {
  double _safePaddingTop, _safePaddingBottom, _height, _width, _keyboard;
  List count = [
    '200',
    '340',
    '640',
    '200',
    '340',
    '640',
    '200',
    '340',
    '640',
    '200',
    '340',
    '640'
  ];
  List imageList = [
    kImageUrl,
    kImageUrl,
    kImageUrl,
    kImageUrl,
    kImageUrl,
    kImageUrl,
    kImageUrl,
    kImageUrl,
    kImageUrl,
    kImageUrl,
    kImageUrl,
    kImageUrl,
  ];
  List nameList = [
    'Pallavi',
    'Sapna',
    'Disha',
    'Rahul',
    'Rahul',
    'Rahul',
    'Rahul',
    'Rahul',
    'Rahul',
    'Rahul',
    'Rahul',
    'Rahul'
  ];
  @override
  Widget build(BuildContext context) {
    _safePaddingTop = MediaQuery.of(context).padding.top;
    _safePaddingBottom = MediaQuery.of(context).padding.bottom;
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height -
        (_safePaddingBottom + _safePaddingTop);
    _keyboard = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
        backgroundColor: kProfPrimaryBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: _height * 0.1,
                  decoration: BoxDecoration(
                      color: kProfSecondaryBackgroundColor,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(_width * 0.06),
                        bottomLeft: Radius.circular(_width * 0.06),
                      )),
                  child: Center(
                    child: Text(
                      'Hostelites',
                      style: TextStyle(
                          color: kProfAccentColour, fontSize: _width * 0.07),
                    ),
                  ),
                ),
                SizedBox(
                  height: _height * 0.03,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: _width * 0.03, right: _width * 0.03),
                  color: kProfPrimaryBackgroundColor,
                  width: _width,
                  child: Timeline(
                    nameList: nameList,
                    imageList: imageList,
                    indicators: count,
                    width: _width,
                    height: _height,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
