import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geekfleet/screens/updateProfile.dart';
import 'package:geekfleet/utils/firebaseCredentials.dart';
import 'package:geekfleet/widgets/arrowBackWidget.dart';
import 'package:geekfleet/widgets/progressWidget.dart';

class Profile extends StatefulWidget {
  static const String profileScreenRoute = 'ProfileScreen';

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  DocumentSnapshot document;
  QuerySnapshot userDevices;

  @override
  void initState() {
    super.initState();
    getUserData().then((data) {
      setState(() {
        document = data;
      });
    });
    getUserDevices().then((result) {
      setState(() {
        userDevices = result;
      });
    });
  }

  getUserDevices() async {
    return FirebaseCredentials()
        .firestore
        .collection('devices')
        .where('deviceUserId',
            isEqualTo: FirebaseCredentials().auth.currentUser.uid)
        .get();
  }

  getUserData() async {
    return FirebaseCredentials()
        .firestore
        .collection('user')
        .doc(FirebaseCredentials().auth.currentUser.uid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'images/bg2.png',
                  ))),
          child: document != null
              ? ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 40, left: 15, right: 15, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ArrowBackWidget(),
                          Text(
                            'Profile',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateProfile())),
                            child: Image.asset(
                              'images/edit.png',
                              height: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            maxRadius: 60,
                            backgroundImage: NetworkImage(document
                                        .data()['userImage'] ==
                                    ''
                                ? 'https://i.pinimg.com/originals/ed/c7/5e/edc75e41888082aa8323c725540624f5.jpg'
                                : document.data()['userImage'].toString()),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            FirebaseCredentials().auth.currentUser.displayName,
                            style: TextStyle(
                                color: Color(0xff9400D3),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            FirebaseCredentials().auth.currentUser.email,
                            style: TextStyle(
                                color: Color(0xff9400D3),
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ]),
                    SizedBox(
                      height: 40,
                    ),
                    Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Color(0xff9400D3),
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                              )),
                          title: Text(
                            FirebaseCredentials().auth.currentUser.displayName,
                            style:
                                TextStyle(color: Colors.grey[12], fontSize: 16),
                          ),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Color(0xff9400D3),
                              child: Icon(
                                Icons.phone,
                                color: Colors.white,
                              )),
                          title: Text(
                            document.data()['contact'].toString(),
                            style:
                                TextStyle(color: Colors.grey[12], fontSize: 16),
                          ),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Color(0xff9400D3),
                              child: Icon(
                                Icons.home,
                                color: Colors.white,
                              )),
                          title: Text(
                            document.data()['address'].toString(),
                            style:
                                TextStyle(color: Colors.grey[12], fontSize: 16),
                          ),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Color(0xff9400D3),
                              child: Icon(
                                Icons.laptop,
                                color: Colors.white,
                              )),
                          title: Text(
                            userDevices != null
                                ? '${userDevices.docs.length}' ' Devices'
                                : 'Device',
                            style:
                                TextStyle(color: Colors.grey[12], fontSize: 16),
                          ),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Color(0xff9400D3),
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                              )),
                          title: Text(
                            "PAYG plan ",
                            style:
                                TextStyle(color: Colors.grey[12], fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Container(
                              width: double.infinity,
                              height: 150,
                              child: Card(
                                color: Color(0xff707070),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 20, left: 30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'PAYG',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Free',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '\$15',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            'More',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10),
                                          ),
                                          IconButton(
                                              icon: Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {})
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              )),
                        ),
                      ],
                    )
                  ],
                )
              : ProgressIndicatorWidget()),
    );
  }
}
