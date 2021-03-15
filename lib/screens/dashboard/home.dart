import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geekfleet/screens/addDevice.dart';
import 'package:geekfleet/widgets/deviceWidget.dart';
import 'package:geekfleet/screens/drawer.dart';
import 'package:geekfleet/utils/constants.dart';
import 'package:geekfleet/utils/firebaseCredentials.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKeyHome =
      new GlobalKey<ScaffoldState>();

  bool isSearch = false;
  QuerySnapshot laptops, mobiles, networking, homeDevices;
  String currentUserId;

  @override
  void initState() {
    super.initState();
    currentUserId = FirebaseCredentials().auth.currentUser.uid;
    getLaptops().then((data) {
      setState(() {
        laptops = data;
      });
    });
    getMobiles().then((data) {
      setState(() {
        mobiles = data;
      });
    });
    getNetworking().then((data) {
      setState(() {
        networking = data;
      });
    });
    getHomeDevices().then((data) {
      setState(() {
        homeDevices = data;
      });
    });
  }

  getLaptops() async {
    return await FirebaseCredentials()
        .firebaseFirestore
        .collection('devices')
        .where('deviceUserId', isEqualTo: currentUserId)
        .where('deviceCategory', isEqualTo: 'PC/Laptop')
        .get();
  }

  getMobiles() async {
    return await FirebaseCredentials()
        .firebaseFirestore
        .collection('devices')
        .where('deviceUserId', isEqualTo: currentUserId)
        .where('deviceCategory', isEqualTo: 'Mobile Devices')
        .get();
  }

  getNetworking() async {
    return await FirebaseCredentials()
        .firebaseFirestore
        .collection('devices')
        .where('deviceUserId', isEqualTo: currentUserId)
        .where('deviceCategory', isEqualTo: 'Networking')
        .get();
  }

  getHomeDevices() async {
    return await FirebaseCredentials()
        .firebaseFirestore
        .collection('devices')
        .where('deviceUserId', isEqualTo: currentUserId)
        .where('deviceCategory', isEqualTo: 'Home Devices')
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKeyHome,
      drawer: LeftDrawer(),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'images/secondBG.png',
                ))),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right: 15, left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Devices',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    isSearch
                        ? Flexible(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(0, 0),
                                        blurRadius: 3,
                                        spreadRadius: 3)
                                  ]),
                              child: TextField(
                                autofocus: true,
                                decoration: InputDecoration(
                                    hintText: 'Search',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                    ),
                                    suffix: InkWell(
                                      onTap: () {
                                        setState(() {
                                          isSearch = !isSearch;
                                        });
                                      },
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                    )),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              setState(() {
                                isSearch = !isSearch;
                              });
                            },
                            child: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                          ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DeviceWidget(
                      image: 'images/laptopes.png',
                      tittle: 'PC/Laptops',
                      subTittle: '',
                      totalDevices: laptops != null
                          ? '${laptops.docs.length} Devices'
                          : '',
                      objects: laptops,
                    ),
                    DeviceWidget(
                      image: 'images/mobiles.png',
                      tittle: 'Mobile Devices',
                      subTittle: 'Phone / Tablets',
                      totalDevices: mobiles != null
                          ? '${mobiles.docs.length} Devices'
                          : '',
                      objects: mobiles,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DeviceWidget(
                      image: 'images/modem.png',
                        tittle: 'Networking',
                      subTittle: 'Equipments',
                      totalDevices: networking != null
                          ? '${networking.docs.length} Devices'
                          : '',
                      objects: networking,
                    ),
                    DeviceWidget(
                      image: 'images/house.png',
                      tittle: 'Home Devices',
                      subTittle: '',
                      totalDevices: homeDevices != null
                          ? '${homeDevices.docs.length} Devices'
                          : '',
                      objects: homeDevices,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddDevice()));
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 0),
                          blurRadius: 3,
                          spreadRadius: 3)
                    ], color: purple, borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
