import 'package:flutter/material.dart';

class BottomBlueButton extends StatelessWidget {
  BottomBlueButton(
      {this.buttonText, this.route, this.widthOfScreen, this.func});

  final Widget route;
  final double widthOfScreen;
  final String buttonText;
  final Function func;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new InkWell(
        onTap: func,
        child: new Container(
          //width: 100.0,
          width: widthOfScreen - widthOfScreen * 0.09,
          height: widthOfScreen * 0.13,
          decoration: new BoxDecoration(
            color: Colors.blueAccent.shade400,
            borderRadius: new BorderRadius.circular(10.0),
          ),
          child: new Center(
            child: new Text(
              buttonText,
              style: new TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
