import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:jss_project/constants/constants.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _safePaddingTop, _safePaddingBottom, _height, _width, _keyboard;

  int currentSelectedIndex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // try {
    //   // FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    // } catch (e) {
    //   print('hey');
    // }
  }

  @override
  Widget build(BuildContext context) {
    _safePaddingTop = MediaQuery.of(context).padding.top;
    _safePaddingBottom = MediaQuery.of(context).padding.bottom;
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height -
        (_safePaddingBottom + _safePaddingTop);
    _keyboard = MediaQuery.of(context).viewInsets.bottom;
    List titles = ['Permissions', 'Maintainance', 'Attendance', 'Members'];
    List foodType = ['Breakfast', 'Lunch', 'Dinner'];
    List count = ['200', '340', '640'];
    
    return Scaffold(
      backgroundColor: kProfPrimaryBackgroundColor,
      body: SafeArea(
        child: Container(
          child: AnimatedContainer(
            height: _height,
            color: kProfPrimaryBackgroundColor,

            width: _width,
            // color: kProfSecondaryBackgroundColor,
            duration: Duration(milliseconds: 200),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: _width * 0.2, top: _height * 0.08),
                        child: CircleAvatar(
                          radius: _width * 0.08,
                          backgroundColor: kProfPrimaryBackgroundColor,
                          backgroundImage: NetworkImage(kImageUrl),
                        ),
                      ),
                      SizedBox(
                        width: _width * 0.04,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: _height * 0.08),
                        child: TyperAnimatedTextKit(
                            onTap: () {
                              print("Tap Event");
                            },
                            text: [
                              "Hello,\nRahul Tilwani",
                            ],
                            textStyle: TextStyle(
                                fontSize: _width * 0.06,
                                fontStyle: FontStyle.italic,
                                color: kProfTextColour),
                            speed: Duration(milliseconds: 70),
                            textAlign: TextAlign.start,
                            displayFullTextOnTap: true,
                            isRepeatingAnimation: false,
                            alignment: AlignmentDirectional.center),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _height * 0.1,
                  ),
                  Container(
                    height: _height * 0.1,
                    child: ListView.separated(
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      primary: true,
                      itemBuilder: (context, index) => Container(
                        // height: _height * 0.08,
                        width: _width * 0.18,
                        decoration: BoxDecoration(
                            color: kProfSecondaryBackgroundColor,
                            borderRadius: BorderRadius.circular(_width * 0.03)),
                        child: Column(
                          children: [
                            Text(
                              count[index],
                              style: TextStyle(
                                  fontSize: _width * 0.08,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  color: kProfTextColour),
                            ),
                            SizedBox(
                              height: _height * 0.02,
                            ),
                            Text(
                              foodType[index],
                              style: TextStyle(
                                fontSize: _width * 0.03,
                                fontStyle: FontStyle.italic,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        width: _width * 0.08,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.1,
                  ),
                  
                  Container(
                    height: _width * 0.7,
                    width: _width * 0.7,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(_width * 0.06),
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(kMapPhoto),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.08,
                  ),
                  Container(
                    height: _width * 0.7,
                    child: CollegeImageSlider(
                      height: _height,
                      width: _width,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SideTile extends StatefulWidget {
  final int index;
  final bool isSelected;
  final VoidCallback onSelect;
  final String title;

  const SideTile({
    Key key,
    @required this.index,
    @required this.isSelected,
    @required this.onSelect,
    @required double height,
    this.title,
  })  : assert(index != null),
        assert(isSelected != null),
        assert(onSelect != null),
        _height = height,
        super(key: key);
  final double _height;
  @override
  _SideTileState createState() => _SideTileState();
}

class _SideTileState extends State<SideTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onSelect,
      child: Container(
        height: widget._height * 0.2,
        decoration: widget.isSelected
            ? BoxDecoration(
                color: kProfAccentColour,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              )
            : BoxDecoration(
                color: kProfSecondaryBackgroundColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
        child: Center(
          child: RotatedBox(
            quarterTurns: -1,
            child: Text(
              widget.title,
              style: TextStyle(
                color: kProfTextColour,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CollegeImageSlider extends StatelessWidget {
  final List<String> imgList = [
    kCollegePhotos,
    kCollegePhotos,
    kCollegePhotos,
    kCollegePhotos,
    kCollegePhotos,
    kCollegePhotos,
    kCollegePhotos,
    kCollegePhotos,
    kCollegePhotos,
    kCollegePhotos,
    kCollegePhotos,
    kCollegePhotos
  ];

  CollegeImageSlider({
    Key key,
    @required double height,
    @required double width,
  })  : _height = height,
        _width = width,
        super(key: key);

  final double _height;
  final double _width;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: _height / 4,
        margin: EdgeInsets.only(top: _height * 0.03, bottom: _height * 0.03),
        child: CarouselSlider(
          options: CarouselOptions(
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.0),
          items: imgList
              .map((item) => Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child:
                          Image.network(item, fit: BoxFit.cover, width: _width),
                    ),
                  ))
              .toList(),
        ));
  }
}
