import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:flutter/services.dart';

class MyClass extends StatefulWidget {
  @override
  _MyClassState createState() => _MyClassState();
}

class _MyClassState extends State<MyClass> {
  TextEditingController _numberCtrl = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _numberCtrl.text = "9669997328"; //Phone number
  }

  @override
  Widget build(BuildContext context) {
    List iconButton_Icons = [Icons.phone, Icons.mail, Icons.message];
    List _iconPressedFunctions = [
      () async {
        FlutterPhoneDirectCaller.callNumber(
            _numberCtrl.text); //phoneDailer function
      },
      () async {
        // Android: Will open mail app or show native picker.
        // iOS: Will open mail app if single mail app found.
        var result = await OpenMailApp.openMailApp();
        launch(
            "mailto:tilwani03@gmail.com?subject=Hi&body=Kya Kar raha hai aaj kal?%20"); //Mail Function

        // If no mail apps found, show error
        if (!result.didOpen && !result.canOpen) {
          showNoMailAppsDialog(context);

          // iOS: if multiple mail apps found, show dialog to select.
          // There is no native intent/default app system in iOS so
          // you have to do it yourself.
        } else if (!result.didOpen && result.canOpen) {
          showDialog(
            context: context,
            builder: (_) {
              return MailAppPickerDialog(
                mailApps: result.options,
              );
            },
          );
        }
      },
      () async => await launch(
          "https://wa.me/${919669997328}?text=Hey Rahul"), //Whatsapp onTapFunction
    ];

    List _iconButtonColors = [
      Colors.pinkAccent.shade200,
      Colors.blueAccent.shade200,
      Colors.greenAccent.shade400,
    ];

    List _IconText = ['Phone', 'Mail', 'Whatsapp'];

    double _safePaddingTop = MediaQuery.of(context).padding.top;
    double _safePaddingBottom = MediaQuery.of(context).padding.bottom;
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height -
        (_safePaddingBottom + _safePaddingTop);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Stack(
                  children: [
                    Container(
                      width: _width,
                      height: _height * 0.2,
                      color: Colors.black,
                    ),
                    Positioned(
                      top: _height * 0.17,
                      child: Container(
                        height: _height,
                        width: _width,
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(20),
                          ),
                          border: Border.all(
                              // color: Colors.grey.withOpacity(0.3),
                              ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 0.1,
                              blurRadius: 3,
                              offset: Offset.zero,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      height: _height * 0.1,
                      left: _width * 0.05,
                      child: CircleAvatar(
                        radius: 17,
                        backgroundColor: Colors.grey[900],
                        child: IconButton(
                          icon: Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                            size: 17,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Positioned(
                      height: _height * 0.1,
                      right: _width * 0.05,
                      child: CircleAvatar(
                        radius: 17,
                        backgroundColor: Colors.grey[900],
                        child: IconButton(
                          icon: Icon(
                            Icons.more_horiz,
                            color: Colors.white,
                            size: 17,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: _height * 0.1),
                      child: Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 42,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcR3FDIbTveNEtu97Q4vpCbMJzC2Lz64h6875w&usqp=CAU'),
                          ),
                        ),
                      ),
                    ),
                  ],
                  overflow: Overflow.visible,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  'Antonius Bartkiewicz',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  'Room No : 104',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: _height * 0.03),
                height: 0.6,
                width: _width,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 0.1,
                      blurRadius: 2,
                      offset: Offset.zero,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: _height * 0.15,
                width: _width,
                color: Colors.grey[900],
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(left: 16, right: 16),
                  itemCount: iconButton_Icons.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: _height * 0.2,
                      width: _width * 0.25,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey[900],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 0.8,
                            blurRadius: 5,
                            offset: Offset.zero,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          IconButton(
                            icon: Icon(
                              iconButton_Icons[index],
                              color: _iconButtonColors[index],
                            ),
                            onPressed: _iconPressedFunctions[index],
                          ),
                          SizedBox(
                            height: _height * 0.01,
                          ),
                          Text(
                            _IconText[index],
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                height: _height * 0.30,
                width: _width * 0.86,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey[900],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 0.8,
                      blurRadius: 5,
                      offset: Offset.zero,
                    ),
                  ],
                ),
                child: Container(
                  height: _height * 0.5,
                  width: _width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Text(
                          'About',
                          style: TextStyle(color: Colors.brown, fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 50,
                          ),
                          Icon(
                            Icons.person,
                            color: Colors.brown,
                            size: 15,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '1JS18EC122',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 50,
                          ),
                          Icon(
                            Icons.collections_bookmark,
                            color: Colors.brown,
                            size: 15,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'ECE, department',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 50,
                          ),
                          Icon(
                            Icons.account_balance,
                            color: Colors.brown,
                            size: 15,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'I come from- Ahmedabad, Gujarat.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 50,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.brown,
                            size: 15,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Known Languages - English, Hindi,',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 80,
                          ),
                          Text(
                            'Gujarati, Sindhi',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: _height,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showNoMailAppsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Open Mail App"),
        content: Text("No mail apps installed"),
        actions: <Widget>[
          FlatButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );
    },
  );
}
