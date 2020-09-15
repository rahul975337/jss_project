import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:jss_project/constants/constants.dart';
// import 'package:hexcolor/hexcolor.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';


class CustomDialog extends StatelessWidget {
  final String title, description;
  // buttonText;
  final Image image;

  CustomDialog({
    @required this.title,
    @required this.description,
    // @required this.buttonText,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0.0,
      // backgroundColor: Colors.transparent,
      backgroundColor: kProfSecondaryBackgroundColor,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: Consts.padding,
        left: Consts.padding,
        right: Consts.padding,
      ),
      margin: EdgeInsets.only(top: Consts.avatarRadius),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Stack(
            children: [
              Positioned(
                left: 10,
                bottom: 10,
                child: Icon(
                  Icons.check,
                  color: Hexcolor('#0df653'),
                  size: 100,
                ),
              ),
              CircularStepProgressIndicator(
                totalSteps: 100,
                currentStep: 72,
                selectedColor: Hexcolor('#0df653'),
                unselectedColor: kProfPrimaryBackgroundColor,
                padding: 0,
                width: 100,
              ),
            ],
          ),

          SizedBox(height: 24.0),
          Text(
            title,
            style: TextStyle(
              color: Hexcolor('#0df653'),
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16.0,
            ),
          ),
          // SizedBox(height: 24.0),
          // Align(
          //   alignment: Alignment.bottomRight,
          //   child: FlatButton(
          //     onPressed: () {
          //       Navigator.of(context).pop(); // To close the dialog
          //     },
          //     child: Text(buttonText),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class Consts {
  // Consts._();

  static const double padding = 50.0;
  static const double avatarRadius = 40.0;
}