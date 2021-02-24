import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geekfleet/screens/drawer.dart';

class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  final GlobalKey<ScaffoldState> _scaffoldKeyHome =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKeyHome,
      drawer: LeftDrawer(),
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'images/secondBG.png',
                ))),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => _scaffoldKeyHome.currentState.openDrawer(),
                  child: Icon(
                    Icons.menu,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    Image.asset(
                      'images/gb_primary.png',
                      height: 60,
                      width: 60,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      'images/gfblack.png',
                      height: 90,
                      width: 90,
                    ),
                  ],
                ),
                Visibility(
                  visible: false,
                  child: Icon(Icons.check),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Events',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              height: 210,
              child: Card(
                color: Color(0xffFFFFFF),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('AARON FISHER'),
                          Text('(11/02/2020)'),
                          Text('4pm-8:30pm'),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('System Service (1 hour)'),
                          Text('\$15'),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Laptop Repair (2.5 hour)'),
                          Text('\$150'),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('System Repair (1 hour)'),
                          Text('\$30'),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Flexible(
                        child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width / 2,
                            // width: MediaQuery.of(context).size.width*3.5,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              textColor: Colors.white,
                              color: Color(0xff9400D3),
                              child: Text(
                                'REGISTER',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {},
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
