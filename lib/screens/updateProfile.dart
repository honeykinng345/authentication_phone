import 'package:flutter/material.dart';
import 'package:geekfleet/screens/addDevice.dart';
import 'package:geekfleet/screens/profile.dart';
import 'package:geekfleet/screens/subscription.dart';
import 'package:geekfleet/screens/editProfile.dart';

class UpdateProfile extends StatefulWidget {
  static const String updateProfileScreenRoute = 'UpdateProfileScreen';

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => Profile())),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'images/bg2.png',
                  ))),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 30, right: 15),
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile())),
                    child: Image.asset(
                      'images/arrow.png',
                      height: 20,
                    ),
                  ),
                  Image.asset(
                    'images/grouptwo.png',
                    height: 30,
                  ),
                  Visibility(
                    visible: false,
                    child: Text('ll'),
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Update Profile',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  height: 50,
                  width: double.infinity,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    textColor: Color(0xff9400D3),
                    color: Color(0xffFFFFFF),
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(fontSize: 15),
                    ),
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EditProfile())),
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  height: 50,
                  width: double.infinity,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    textColor: Color(0xff9400D3),
                    color: Color(0xffFFFFFF),
                    child: Text(
                      'Add More Devices',
                      style: TextStyle(fontSize: 15),
                    ),
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddDevice())),
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  height: 50,
                  width: double.infinity,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    textColor: Color(0xff9400D3),
                    color: Color(0xffFFFFFF),
                    child: Text(
                      'Change Plan',
                      style: TextStyle(fontSize: 15),
                    ),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Subscription())),
                  )),
            ]),
          ),
        ),
      ),
    );
  }
}

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular((15)),
    borderSide: BorderSide(color: Color(0xFF757575)),
  );
}
