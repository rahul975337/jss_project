
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:jss_project/constants/constants.dart';

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
