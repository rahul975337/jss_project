import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jss_project/screens/authenticate/forgotPass.dart';
import 'package:jss_project/screens/loggedIn/root.dart';
import 'package:jss_project/shared/loading.dart';
import 'package:page_transition/page_transition.dart';

import '../../constants/constants.dart';
import '../../services/auth.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  double _safePaddingTop, _safePaddingBottom;
  double _height, _width;
  String secondField;
  String _jssID = '';
  String _password = '';
  String _error;
  bool loading = false;

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
      body: loading
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
                          validator: (val) => val.length < 6
                              ? 'Enter a Password 6+ char long'
                              : null,
                          onChanged: (pass) {
                            setState(() {
                              _password = pass;
                            });
                          },
                          decoration: InputDecoration(
                              labelText: 'Password',
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
                          obscureText: true,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: _height * 0.04, bottom: _height * 0.04),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: ForgotPassword())),
                          child: Text(
                            'Forgot Password',
                            style: TextStyle(
                              color: kProfTextColour,
                              fontWeight: FontWeight.w300,
                              fontSize: _width * 0.04,
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
                  onTap: () => _signInAction(),
                  child: Container(
                    //width: 100.0,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.shade400,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(
                        'Sign In',
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

  _signInAction() async {
    if (this.mounted) {
      FocusScope.of(context).requestFocus(new FocusNode());
    }
    if (_formKey.currentState.validate()) {
      setState(() => loading = true);
      dynamic result = await _auth.signInJSSID(_jssID, _password);
      if (this.mounted) {
        if (result == null) {
          setState(() {
            _error = 'Please give the correct credentials';
            loading = false;
          });
        } else {
          Navigator.of(context).pushReplacement(
              PageTransition(child: Root(), type: PageTransitionType.fade));
          setState(() {
            _error = 'Successfully Signed In!!';
            loading = false;
          });
        }
      }
    }
    if (_error != null) {
      if (this.mounted) {
        final _snackbar = SnackBar(
          content: Text(_error),
        );
        _scaffoldKey.currentState.showSnackBar(_snackbar);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
