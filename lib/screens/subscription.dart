import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geekfleet/utils/firebaseCredentials.dart';
import 'package:geekfleet/widgets/arrowBackWidget.dart';

class Subscription extends StatefulWidget {
  static const String subscription1ScreenRoute = 'SubscriptionScreen1';

  @override
  _SubscriptionState createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  List<String> _plans = [
    '-No Monthly Fee - only pay for what you use!',
    '-\$20 Service Fee per Request',
    '-\$15 per Live Event or Training',
    '-\$99.99 PC Part Picking and Building Service'
  ];
  String _selectedPlans;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'images/secondBG.png',
                ))),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ArrowBackWidget(),
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
                height: 20,
              ),
              Text(
                'Subscription',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () async {
                  await FirebaseCredentials()
                      .firebaseFirestore
                      .collection('user')
                      .doc(FirebaseCredentials().auth.currentUser.uid)
                      .set({'subscriptionType': 'PAYG'},
                          SetOptions(merge: true));
                },
                child: Container(
                    width: double.infinity,
                    height: 150,
                    child: Card(
                      color: Color(0xff707070),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, left: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PAYG',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'More',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                DropdownButton(
                                  iconSize: 10,
                                  value: _selectedPlans,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedPlans = newValue;
                                    });
                                  },
                                  items: _plans.map((plan) {
                                    return DropdownMenuItem(
                                      child: new Text(
                                        plan,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                      value: plan,
                                    );
                                  }).toList(),
                                ),
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
              GestureDetector(
                onTap: () async {
                  await FirebaseCredentials()
                      .firebaseFirestore
                      .collection('user')
                      .doc(FirebaseCredentials().auth.currentUser.uid)
                      .set({'subscriptionType': 'Nerd Herd'},
                          SetOptions(merge: true));
                },
                child: Container(
                    width: double.infinity,
                    height: 150,
                    child: Card(
                      color: Color(0xff9400D3),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, left: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nerd Herd',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              ' Monthly Fee',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '\$24.99 / month',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'More',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10),
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
              GestureDetector(
                onTap: () async {
                  await FirebaseCredentials()
                      .firebaseFirestore
                      .collection('user')
                      .doc(FirebaseCredentials().auth.currentUser.uid)
                      .set({'subscriptionType': 'Full Geek'},
                          SetOptions(merge: true));
                },
                child: Container(
                    width: double.infinity,
                    height: 150,
                    child: Card(
                      color: Color(0xff15D600),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, left: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Full Geek',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              ' Monthly Fee',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '\$49.99/month',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'More',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10),
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
          ),
        ),
      ),
    );
  }
}
