import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geekfleet/modals/myDeviceListModal.dart';
import 'package:geekfleet/modals/myTicketListModal.dart';
import 'package:geekfleet/modals/userDataModal.dart';
import 'package:geekfleet/screens/splashScreen.dart';
import 'package:geekfleet/utils/constants.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  InAppPurchaseConnection.enablePendingPurchases();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyDeviceList()),
        ChangeNotifierProvider(create: (context) => MyTicketList()),
        // ChangeNotifierProvider(create: (context) => UserDataModal()),
      ],
      child: MaterialApp(
        title: 'Geek Fleet',
        theme: ThemeData(primarySwatch: Colors.blue, accentColor: primary),
        home: SplashScreen(),
      ),
    );
  }
}
