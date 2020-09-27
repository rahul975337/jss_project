import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jss_project/models/user.dart';
import 'package:jss_project/shared/provider/mode.dart';
import 'package:provider/provider.dart';

import 'screens/wrapper.dart';
import 'services/auth.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MultiProvider(
      providers: [

        ChangeNotifierProvider(
          create: (context) => Mode(),
        ),
        StreamProvider<CurrentUser>.value(
          value: AuthService().user,
        )
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false, home: Wrapper()),
    );
   
  }
}
