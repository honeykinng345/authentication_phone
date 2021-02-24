import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geekfleet/screens/signIn.dart';

class SentCode extends StatefulWidget {
  static const String logInRoute = 'Login';

  @override
  _SentCodeState createState() => _SentCodeState();
}

class _SentCodeState extends State<SentCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(36.0),
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'images/bg.png',
              ))),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 90,
            child: Image.asset(
              'images/gfimage.png',
            ),
          ),
          Image.asset(
            'images/gfblack.png',
            scale: 4,
          ),
          Spacer(),
          Text(
            'SENT',
            style: TextStyle(
                color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Container(
            height: 200,
            child: Text(
              'Your password reset instructions have now been sent. If you have not received this, then please check. your junk emails before contacting us.',
              style: TextStyle(
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Spacer(),
          Container(
              padding: EdgeInsets.only(left: 5, right: 5),
              height: 60,
              width: double.infinity,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                textColor: Colors.black,
                color: Color(0xff09F2BC),
                child: Text(
                  'LOGIN',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SignIn())),
              )),
        ],
      ),
    ));
  }
}
