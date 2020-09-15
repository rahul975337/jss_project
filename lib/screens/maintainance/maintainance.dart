import 'package:flutter/material.dart';
import 'package:jss_project/constants/constants.dart';
import 'package:jss_project/screens/maintainance/bottomBlueButton.dart';
import 'package:jss_project/screens/maintainance/maintainanceDialog.dart';

class Maintainance extends StatefulWidget {
  @override
  _MaintainanceState createState() => _MaintainanceState();
}

class _MaintainanceState extends State<Maintainance> {
  double _safePaddingTop, _safePaddingBottom, _height, _width, _keyboard;
  List titles = [
    'Plumber',
    'Furniture',
    'Cleaning',
    'Electrician',
    'Mess Food',
    'Others'
  ];

  int currentSelectedIndex;
  TextEditingController titleTextEditingController;
  String title;
  TextEditingController descriptionTextEditingController;
  String description;
  @override
  void initState() {
    super.initState();
    titleTextEditingController = TextEditingController();
    descriptionTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    titleTextEditingController.dispose();
    descriptionTextEditingController.dispose();
  }

  Widget titleFieldWidget() {
    return Container(
      width: _width / 1.1,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: kProfSecondaryBackgroundColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: kProfTextColour),
      ),
      child: TextField(
          controller: titleTextEditingController,
          onSubmitted: (value) {
            setState(() {
              title = titleTextEditingController.text;
            });
          },
          style: TextStyle(
              color: kProfTextColour,
              fontSize: 18,
              fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: -2, horizontal: 10),
            border: InputBorder.none,
            hintText: 'Enter the title.....',
            hintStyle: TextStyle(
              color: Colors.white60,
            ),
          )),
    );
  }

  Widget descriptionFieldWidget() {
    return Container(
      width: _width / 1.1,
      height: _height / 2.3,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: kProfSecondaryBackgroundColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: kProfTextColour),
      ),
      child: Expanded(
        child: TextField(
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            maxLines: null,
            maxLengthEnforced: true,
            controller: descriptionTextEditingController,
            onSubmitted: (value) {
              setState(() {
                description = descriptionTextEditingController.text;
              });
            },
            textAlign: TextAlign.left,
            style: TextStyle(color: kProfTextColour, fontSize: 18),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: -2, horizontal: 10),
              border: InputBorder.none,
              hintText: 'Enter the Description.....',
              hintStyle: TextStyle(
                color: Colors.white60,
              ),
            )),
      ),
    );
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
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: _height * 0.1,
              width: _width,
              child: Row(
                children: [
                  SizedBox(
                    width: _width * 0.1,
                  ),
                  Icon(
                    Icons.arrow_back_ios,
                  ),
                  Text(
                    'Maintainance',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            Container(
              height: _height * 0.1,
              width: _width,
            ),
            Container(
              height: _height * 0.8,
              decoration: BoxDecoration(
                  color: kProfSecondaryBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(_width * 0.08),
                      topRight: Radius.circular(_width * 0.08))),
              child: Container(
                margin: EdgeInsets.only(
                  left: _width * 0.08,
                  top: _width * 0.2,
                  right: _width * 0.08,
                ),
                child: GridView.builder(
                  // shrinkWrap: true,
                  itemCount: titles.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: _width * 0.1,
                      mainAxisSpacing: _width * 0.1),
                  itemBuilder: (context, index) {
                    return MaintainanceTile(
                      index: index,
                      title: titles[index],
                      isSelected: currentSelectedIndex == index,
                      onSelect: () {
                        setState(() {
                          currentSelectedIndex = index;
                        });
                        showBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) => Container(
                            height: _height * 0.8,
                            width: _width,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(_width * 0.08),
                                    topRight: Radius.circular(_width * 0.08))),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: _height * 0.03,
                                  ),
                                  Container(
                                    child: Text(
                                      'Plumber',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: _width * 0.08),
                                    ),
                                  ),
                                  SizedBox(
                                    height: _height * 0.03,
                                  ),
                                  Container(
                                    child: titleFieldWidget(),
                                  ),
                                  SizedBox(
                                    height: _height * 0.03,
                                  ),
                                  Container(
                                    child: descriptionFieldWidget(),
                                  ),
                                  SizedBox(
                                    height: _height * 0.02,
                                  ),
                                  BottomBlueButton(
                                    buttonText: 'Submit Complaint',
                                    widthOfScreen: _width,
                                    func: () {
                                      setState(() {
                                        descriptionTextEditingController
                                            .clear();
                                        titleTextEditingController.clear();

                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              CustomDialog(
                                            title: "Success!!",
                                            description:
                                                "Complaint recieved!!\nWe will resolve your issue as soon as possible",
                                          ),
                                        );
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      height: _height,
                      width: _width,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MaintainanceTile extends StatefulWidget {
  final int index;
  final bool isSelected;
  final VoidCallback onSelect;
  final String title;

  const MaintainanceTile({
    Key key,
    @required this.index,
    @required this.isSelected,
    @required this.onSelect,
    @required double height,
    @required double width,
    this.title,
  })  : assert(index != null),
        assert(isSelected != null),
        assert(onSelect != null),
        _height = height,
        _width = width,
        super(key: key);
  final double _height;
  final double _width;

  @override
  _MaintainanceTileState createState() => _MaintainanceTileState();
}

class _MaintainanceTileState extends State<MaintainanceTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onSelect,
      child: Container(
        decoration: widget.isSelected
            ? BoxDecoration(
                color: kProfAccentColour,
                borderRadius: BorderRadius.circular(widget._width * 0.07))
            : BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(widget._width * 0.07)),
      ),
    );
  }
}