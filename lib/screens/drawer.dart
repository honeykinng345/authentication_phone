import 'package:flutter/material.dart';
import 'package:geekfleet/screens/signIn.dart';
import 'package:geekfleet/screens/profile.dart';
import 'package:geekfleet/utils/firebaseCredentials.dart';

class LeftDrawer extends StatefulWidget {
  @override
  _LeftDrawerState createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.8,
      child: Drawer(
        child: Container(
          color: Color(0xff9400D3),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Image.asset(
                          'images/backWhiteIcon.png',
                          height: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ListTile(
                leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: Color(0xff9400D3),
                    )),
                title: Text(
                  "Profile",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                },
              ),
              ListTile(
                  leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.logout,
                        color: Color(0xff9400D3),
                      )),
                  title: Text(
                    "Logout",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onTap: () {
                    FirebaseCredentials().auth.signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => SignIn()),
                        (route) => false);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
