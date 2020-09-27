import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:jss_project/constants/constants.dart';
import 'package:jss_project/helperFunctions/sharedFunctions.dart';
import 'package:jss_project/screens/loggedIn/Map/map.dart';
import 'package:jss_project/services/database.dart';
import 'package:jss_project/shared/collegeImageSlider.dart';
import 'package:jss_project/shared/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Home4 extends StatefulWidget {
  @override
  _Home4State createState() => _Home4State();
}

class _Home4State extends State<Home4> {
  double _safePaddingTop, _safePaddingBottom, _height, _width, _keyboard;
  List count = [400, 450, 560];
  List titles = ['Breakfast', 'Lunch', 'Dinner'];
  bool mapOpen = false;
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
    // await SharedFunctions.getUserNameSharedPreference().then((value) {
    //   setState(() => _myImage = value);
    //   print(_myImage);
    // });
  }

  final List<Feature> features = [
    Feature(
      title: "Breakfast",
      color: Colors.green,
      data: [0.3, 0.5, 0.5, 0.3, 0.5, 0.8, 0.4],
    ),
    Feature(
      title: "Lunch",
      color: Colors.pink,
      data: [1, 0.8, 0.6, 0.7, 0.3, 0.4, 0.3],
    ),
    Feature(
      title: "Dinner",
      color: Colors.cyan,
      data: [0.5, 0.4, 0.85, 0.4, 0.7, 0.6, 0.25],
    ),
  ];
  List colorList = [Colors.green, Colors.pink, Colors.cyan];
  @override
  void initState() {
    super.initState();

    _setFunction();
    print(_myName);
  }

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
      body: _myName == ''
          ? Loading()
          : SafeArea(
              child: Container(
                child: AnimatedContainer(
                  height: _height,
                  color: kProfPrimaryBackgroundColor,
                  width: _width,
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
                                backgroundImage: NetworkImage(_myImage),
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
                                    "Hello,\n$_myName",
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
                          height: _height * 0.08,
                        ),
                        Container(
                          height: _height * 0.14,
                          width: _width,
                          // color: Colors.red,
                          margin: EdgeInsets.only(left: _width * 0.08),
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Container(
                                    height: _height * 0.14,
                                    child: Column(
                                      children: [
                                        Stepper(
                                          width: _width,
                                          auth: count[index],
                                          color: colorList[index],
                                        ),
                                        SizedBox(
                                          height: _height * 0.01,
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 10,
                                                width: 10,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: colorList[index],
                                                      width: 1.5),
                                                  color: colorList[index]
                                                      .withOpacity(0.3),
                                                ),
                                              ),
                                              SizedBox(
                                                width: _width * 0.01,
                                              ),
                                              Text(
                                                titles[index],
                                                style: TextStyle(
                                                    color: colorList[index]),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                              separatorBuilder: (context, index) => SizedBox(
                                    width: _width * 0.1,
                                  ),
                              itemCount: 3),
                        ),
                        SizedBox(
                          height: _height * 0.1,
                        ),
                        Container(
                          // width: _width - 60,
                          // height: _height / 2,
                          child: LineGraph(
                            features: features,
                            size: Size(_width, _height / 3),
                            labelX: ['Mn', 'Te', 'Wd', 'Th', 'Fr', 'St', 'Sn'],
                            labelY: [
                              '100',
                              '200',
                              '300',
                              '400',
                              '500',
                              '600',
                            ],
                            // showDescription: true,

                            graphColor: Colors.white70,
                          ),
                        ),
                        // BarChartSample2(),
                        SizedBox(
                          height: _height * 0.1,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              mapOpen = !mapOpen;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),

                            curve: Curves.bounceIn,
                            // color: Colors.green,
                            height: mapOpen ? _height : _width * 0.7,
                            width: mapOpen ? _width : _width * 0.7,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Stack(
                                  children: [
                                    MapSample(),
                                    Container(
                                      height: _width * 0.7,
                                      width: _width * 0.7,
                                      color: Colors.transparent,
                                    )
                                  ],
                                )),
                          ),
                        ),
                        SizedBox(
                          width: _width * 0.2,
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

class Stepper extends StatelessWidget {
  const Stepper({
    Key key,
    @required double width,
    @required this.auth,
    this.color,
  })  : _width = width,
        super(key: key);

  final double _width;
  final int auth;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircularStepProgressIndicator(
        stepSize: 2,
        totalSteps: 600,
        currentStep: auth,
        selectedColor: color,
        unselectedColor: kProfPrimaryBackgroundColor,
        padding: 0,
        width: _width * 0.22,
        height: _width * 0.22,
        child: Center(
            child: Text(
          '$auth',
          style: TextStyle(color: Colors.white, fontSize: 22),
        )),
      ),
    );
  }
}
