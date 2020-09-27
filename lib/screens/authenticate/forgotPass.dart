import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:jss_project/shared/loading.dart';

import '../../constants/constants.dart';
import '../../services/auth.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  double _safePaddingTop, _safePaddingBottom;
  double _height, _width;
  String secondField;
  String _jssID = '';
  String _email = '';
  String _error;
  bool loading = false;
  String _message =
      'A link to enter a new password will be sent to the registered mail address affiliated with the account';

  @override
  Widget build(BuildContext context) {
    _safePaddingTop = MediaQuery.of(context).padding.top;
    _safePaddingBottom = MediaQuery.of(context).padding.bottom;
    _height = MediaQuery.of(context).size.height -
        (_safePaddingTop + _safePaddingBottom);
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kProfPrimaryBackgroundColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: loading
            ? Stack(
                children: <Widget>[
                  Positioned(
                    top: 0.0,
                    child: _screen(),
                  ),
                  Positioned(
                    bottom: 0.0,
                    child: Container(
                      height: _height + _safePaddingBottom + _safePaddingTop,
                      width: _width,
                      child: Center(child: Loading()),
                    ),
                  ),
                ],
              )
            : _screen(),
      ),
    );
  }

  Widget _screen() {
    return Container(
      height: _height,
      width: _width,
      margin: EdgeInsets.only(top: _safePaddingTop, bottom: _safePaddingBottom),
      child: Form(
        key: _formKey,
        child: Container(
          color: kProfPrimaryBackgroundColor,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: _height * 3 / 6,
                  width: _width,
                  margin: EdgeInsets.only(),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "JSS",
                      style: TextStyle(
                        color: kProfAccentColour,
                        fontSize: _width * 0.16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: _height * 0.02),

              ///TextFields
              Container(
                height: _height * 2.1 / 6,
                width: _width,
                margin: EdgeInsets.symmetric(horizontal: _width * 0.09),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(vertical: _height * 0.01),
                        child: TextFormField(
                          style: TextStyle(color: kProfTextColour),
                          validator: (val) =>
                              val.length < 10 ? 'Enter a valid JSSID' : null,
                          onChanged: (citID) {
                            setState(() {
                              _jssID = citID;
                            });
                          },
                          decoration: InputDecoration(
                              labelText: 'JSS Id',
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Montserrat',
                                  color: kProfTextColour),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueAccent.shade200,
                                    width: 0.7),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent.shade400))),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: _height * 0.01),
                        child: TextFormField(
                          style: TextStyle(color: kProfTextColour),
                          validator: (val) =>
                              val.contains('@') && val.contains('.com')
                                  ? null
                                  : 'Enter a valid mail address',
                          onChanged: (mail) {
                            setState(() {
                              _email = mail;
                            });
                          },
                          decoration: InputDecoration(
                              labelText: 'Registered Email Address',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w400,
                                  color: kProfTextColour),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueAccent.shade200,
                                    width: 0.7),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent.shade400))),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: _height * 0.04,
                            bottom: _height * 0.02,
                            left: _width * 0.02,
                            right: _width * 0.02),
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Text(
                            _message,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kProfTextColour,
                              fontWeight: FontWeight.w300,
                              fontSize: _width * 0.03,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                height: _height * 0.4 / 6,
                width: _width * 0.85,
                margin: EdgeInsets.only(bottom: _height * 0.03),
                child: GestureDetector(
                  onTap: () => _forgotPassAction(context),
                  child: Container(
                    //width: 100.0,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.shade400,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(
                        'Send Mail',
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _forgotPassAction(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      setState(() => loading = true);
      dynamic result = await _auth.resetPassword(_email, _jssID);
      if (result == null) {
        setState(() {
          _error = 'Password Reset Link has been sent to the mail';
          loading = false;
        });
      } else if (result == 0) {
        setState(() {
          _error = 'Please give the correct credentials';
          loading = false;
        });
      }
    }
    if (_error != null) {
      final _snackbar = SnackBar(
        content: Text(_error),
        // action: SnackBarAction(
        //   label: 'OK',
        //   onPressed: () {
        //     // Some code to undo the change.
        //   },
        // ),
      );
      _scaffoldKey.currentState.showSnackBar(_snackbar);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
