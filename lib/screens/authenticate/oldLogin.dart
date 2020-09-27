// import 'package:flutter/material.dart';
// import 'package:jss_project/screens/loggedIn/root.dart';

// class OldLogin extends StatefulWidget {
//   @override
//   _OldLoginState createState() => new _OldLoginState();
// }

// class _OldLoginState extends State<OldLogin> {
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//         resizeToAvoidBottomPadding: false,
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               child: Stack(
//                 children: <Widget>[
//                   Container(
//                     padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
//                     child: Text('Hello',
//                         style: TextStyle(
//                             fontSize: 80.0, fontWeight: FontWeight.bold)),
//                   ),
//                   Container(
//                     padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
//                     child: Text('There',
//                         style: TextStyle(
//                             fontSize: 80.0, fontWeight: FontWeight.bold)),
//                   ),
//                   Container(
//                     padding: EdgeInsets.fromLTRB(220.0, 175.0, 0.0, 0.0),
//                     child: Text('.',
//                         style: TextStyle(
//                             fontSize: 80.0,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.green)),
//                   )
//                 ],
//               ),
//             ),
//             Container(
//                 padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
//                 child: Column(
//                   children: <Widget>[
//                     TextField(
//                       decoration: InputDecoration(
//                           labelText: 'UserID',
//                           labelStyle: TextStyle(
//                               fontFamily: 'Montserrat',
//                               fontWeight: FontWeight.bold,
//                               color: Colors.grey),
//                           focusedBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(color: Colors.green))),
//                     ),
//                     SizedBox(height: 20.0),
//                     TextField(
//                       decoration: InputDecoration(
//                           labelText: 'PASSWORD',
//                           labelStyle: TextStyle(
//                               fontFamily: 'Montserrat',
//                               fontWeight: FontWeight.bold,
//                               color: Colors.grey),
//                           focusedBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(color: Colors.green))),
//                       obscureText: true,
//                     ),
//                     SizedBox(height: 5.0),
//                     SizedBox(height: 40.0),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => Root()),
//                         );
//                       },
//                       child: Container(
//                         height: 50.0,
//                         child: Material(
//                           borderRadius: BorderRadius.circular(20.0),
//                           shadowColor: Colors.greenAccent,
//                           color: Colors.green,
//                           elevation: 7.0,
//                           child: Center(
//                             child: Text(
//                               'LOGIN',
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'Montserrat'),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20.0),
//                   ],
//                 )),
//           ],
//         ));
//   }
// }
