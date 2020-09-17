import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:jss_project/constants/constants.dart';
import 'package:jss_project/screens/home/graph.dart';
import 'package:jss_project/screens/home/graph2.dart';
import 'package:jss_project/screens/home/home.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Home4 extends StatefulWidget {
  @override
  _Home4State createState() => _Home4State();
}

class _Home4State extends State<Home4> {
  double _safePaddingTop, _safePaddingBottom, _height, _width, _keyboard;
  List count = [400, 450, 560];

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
                    height: _height * 0.08,
                  ),
                  Container(
                    height: _width * 0.22,
                    width: _width,
                    margin: EdgeInsets.only(left: _width * 0.08),
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            Stepper(width: _width, auth: count[index]),
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
                    height: _height / 2,
                    child: LineGraph(
                      features: features,
                      size: Size(_height / 2, _width - 60),
                      labelX: [
                        'Mon',
                        'Tuey',
                        'Wed',
                        'Thur',
                        'Fri',
                        'Sat',
                        'Sun'
                      ],
                      labelY: [
                        '100',
                        '200',
                        '300',
                        '400',
                        '500',
                        '600',
                      ],
                      showDescription: true,
                      graphColor: Colors.white70,
                    ),
                  ),
                  BarChartSample2(),
                  LineChartSample2(),
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
  })  : _width = width,
        super(key: key);

  final double _width;
  final int auth;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircularStepProgressIndicator(
        stepSize: 2,
        
        totalSteps: 600,
        currentStep: auth,
        selectedColor: Colors.blueAccent,
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
