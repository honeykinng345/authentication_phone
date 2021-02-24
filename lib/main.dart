import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geekfleet/modals/myDeviceListModal.dart';
import 'package:geekfleet/modals/myTicketListModal.dart';
import 'package:geekfleet/screens/dashboard/dashboard.dart';
import 'package:geekfleet/screens/sentCode.dart';
import 'package:geekfleet/screens/signIn.dart';
import 'package:geekfleet/screens/resetPassword.dart';
import 'package:geekfleet/screens/signUp.dart';
import 'package:geekfleet/screens/splashScreen.dart';
import 'package:geekfleet/utils/constants.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyDeviceList()),
        ChangeNotifierProvider(create: (context)=> MyTicketList()),
      ],
      child: MaterialApp(
        title: 'Geek Fleet',
        theme: ThemeData(primarySwatch: Colors.blue, accentColor: primary),
        home: SplashScreen(),
        routes: {
          SignIn.logInScreenRoute: (BuildContext ctx) => SignIn(),
          SignUpScreen.signUpScreenRoute: (BuildContext ctx) => SignUpScreen(),
          SentCode.logInRoute: (BuildContext ctx) => SentCode(),
          ResetPassword.resetPasswordRoute: (BuildContext ctx) =>
              ResetPassword(),
          Dashboard.HomeScreenRoute: (BuildContext ctx) => Dashboard(),
        },
      ),
    );
  }
}
