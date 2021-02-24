import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geekfleet/screens/dashboard/dashboard.dart';
import 'package:geekfleet/screens/signIn.dart';
import 'package:geekfleet/utils/firebaseCredentials.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    return Timer(Duration(seconds: 4), onLoading);
  }

  onLoading() async {
    if (await FirebaseCredentials().auth.currentUser == null)
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SignIn()));
    else
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Dashboard()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'images/bg.png',
                    ))),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'images/gfimage.png',
                  height: 100,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Image.asset(
                  'images/gfblack.png',
                  height: 50,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
