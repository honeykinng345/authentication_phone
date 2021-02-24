import 'package:flutter/material.dart';

class SubscrptionScreen2 extends StatefulWidget {
  static const String subscription2ScreenRoute = 'Subscription2Screen';

  @override
  _SubscrptionScreen2State createState() => _SubscrptionScreen2State();
}

class _SubscrptionScreen2State extends State<SubscrptionScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'images/bg.png',
                ))),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
          child: Column(
            children: [
              ListTile(
                leading: Image.asset(
                  'images/arrow.png',
                  height: 30,
                ),
                title: Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Center(
                    child: Image.asset(
                      'images/grouptwo.png',
                      height: 30,
                    ),
                  ),
                ),
              ),
              Text(
                'Subscription',
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: double.infinity,
                  height: 200,
                  child: Card(
                    color: Color(0xff707070),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, left: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PAYG',
                            style: TextStyle(color: Colors.white, fontSize: 20),
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
                          RichText(
                            text: TextSpan(
                              text: '1. ',
                              style: TextStyle(color: Colors.grey),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Individuals User',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: '2. ',
                              style: TextStyle(color: Colors.grey),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '\$15 service fee per request',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: '3. ',
                              style: TextStyle(color: Colors.grey),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '\$15 interacting training',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Less',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 10),
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
              Container(
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
                            style: TextStyle(color: Colors.white, fontSize: 20),
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
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'More',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 10),
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
              Container(
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
                            style: TextStyle(color: Colors.white, fontSize: 20),
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
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'More',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 10),
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
            ],
          ),
        ),
      ),
    );
  }
}
