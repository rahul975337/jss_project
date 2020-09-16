import 'package:flutter/material.dart';
import 'package:jss_project/constants/constants.dart';
import 'package:jss_project/screens/maintainance/bottomBlueButton.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:jss_project/screens/maintainance/maintainanceDialog.dart';

class Permssion extends StatefulWidget {
  @override
  _PermssionState createState() => _PermssionState();
}

class _PermssionState extends State<Permssion> {
  double _safePaddingTop, _safePaddingBottom, _height, _width, _keyboard;
  List titles = [
    'Plumber',
    'Furniture',
    'Cleaning',
    'Electrician',
    'Mess Food',
    'Others'
  ];

  TextEditingController permissionTextEditingController;
  String permission;
  @override
  void initState() {
    super.initState();

    permissionTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    permissionTextEditingController.dispose();
  }

  Widget permissionFieldWidget() {
    return Container(
      width: _width / 1.2,
      height: _height / 2.8,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: kProfSecondaryBackgroundColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: kProfTextColour,
        ),
      ),
      child: Expanded(
        child: TextField(
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            maxLines: null,
            maxLengthEnforced: true,
            controller: permissionTextEditingController,
            onSubmitted: (value) {
              setState(() {
                permission = permissionTextEditingController.text;
              });
            },
            textAlign: TextAlign.left,
            style: TextStyle(color: kProfTextColour, fontSize: 18),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: -2, horizontal: 10),
              border: InputBorder.none,
              hintText: 'Enter the permission.....',
              hintStyle: TextStyle(
                color: Colors.white60,
              ),
            )),
      ),
    );
  }

  ////////
  DateTime selectedFromDate = DateTime.now();

  _selectFromDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedFromDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      // builder: (context, child) {
      //   return Theme(
      //     data: ThemeData.light(), // This will change to light theme.
      //     child: child,
      //   );
      // },
    );
    if (picked != null && picked != selectedFromDate)
      setState(() {
        selectedFromDate = picked;
      });
  }

  DateTime selectedToDate = DateTime.now();

  _selectToDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedToDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      // builder: (context, child) {
      //   return Theme(
      //     data: ThemeData.light(), // This will change to light theme.
      //     child: child,
      //   );
      // },
    );
    if (picked != null && picked != selectedToDate)
      setState(() {
        selectedToDate = picked;
      });
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
                    'Permission',
                    style: TextStyle(
                        color: kProfAccentColour, fontSize: _width * 0.07),
                  ),
                ),
              ),
              SizedBox(
                height: _height * 0.1,
              ),
              Row(
                children: [
                  SizedBox(
                    width: _width / 7,
                  ),
                  Column(
                    children: [
                      Container(
                        child: new InkWell(
                          // onTap: _pickDate(context),
                          child: new Container(
                            //width: 100.0,
                            width: _width * 0.3,
                            height: _height * 0.05,
                            decoration: new BoxDecoration(
                              color: Colors.blueAccent.shade400,
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                            child: new Center(
                              child: new Text(
                                'From',
                                style: new TextStyle(
                                    fontSize: 18.0, color: Colors.white),
                              ),
                            ),
                          ),
                          onTap: () => _selectFromDate(context),
                        ),
                      ),
                      SizedBox(
                        height: _height * 0.03,
                      ),
                      Container(
                        child: Text(
                          "${selectedFromDate.toLocal()}".split(' ')[0],
                          style: new TextStyle(
                              fontSize: 18.0, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: _width / 10,
                  ),
                  Column(
                    children: [
                      Container(
                        child: new InkWell(
                          onTap: () => _selectToDate(context),
                          child: new Container(
                            //width: 100.0,
                            width: _width * 0.3,
                            height: _height * 0.05,
                            decoration: new BoxDecoration(
                              color: Colors.blueAccent.shade400,
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                            child: new Center(
                              child: new Text(
                                'To',
                                style: new TextStyle(
                                    fontSize: 18.0, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: _height * 0.03,
                      ),
                      Container(
                        child: Text(
                          "${selectedToDate.toLocal()}".split(' ')[0],
                          style: new TextStyle(
                              fontSize: 18.0, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: _width / 7,
                  ),
                ],
              ),

              // Container(
              //   height: _height * 0.8,
              //   decoration: BoxDecoration(
              //       color: kProfSecondaryBackgroundColor,
              //       borderRadius: BorderRadius.only(
              //           topLeft: Radius.circular(_width * 0.08),
              //           topRight: Radius.circular(_width * 0.08))),
              //   child: Container(
              //     margin: EdgeInsets.only(
              //       left: _width * 0.08,
              //       top: _width * 0.2,
              //       right: _width * 0.08,
              //     ),
              //   ),
              // ),
              SizedBox(
                height: _height * 0.06,
              ),
              Row(
                children: [
                  SizedBox(
                    width: _width / 7,
                  ),
                  Container(
                    child: new InkWell(
                      onTap: () => _selectToDate(context),
                      child: new Container(
                        //width: 100.0,
                        width: _width * 0.3,
                        height: _height * 0.05,
                        decoration: new BoxDecoration(
                          color: Colors.blueAccent.shade400,
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        child: new Center(
                          child: new Text(
                            'No of Days',
                            style: new TextStyle(
                                fontSize: 18.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: _width / 8,
                  ),
                  Container(
                    child: Text(
                      "${(selectedToDate.day - selectedFromDate.day)} Days"
                          ,
                      style: new TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: _height * 0.06,
              ),
              permissionFieldWidget(),
              SizedBox(
                height: _height * 0.05,
              ),
              BottomBlueButton(
                buttonText: 'Submit Application',
                widthOfScreen: _width / 1.1,
                func: () {
                  setState(() {
                    permissionTextEditingController.clear();
                    permissionTextEditingController.clear();

                    showDialog(
                      context: context,
                      builder: (BuildContext context) => CustomDialog(
                        title: "Success!!",
                        description:
                            "Application!!\nWe will let you know as soon as possible",
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
  }
}
