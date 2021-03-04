import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geekfleet/modals/routeArgumentModal.dart';
import 'package:geekfleet/screens/addTicket.dart';
import 'package:geekfleet/screens/dashboard/events.dart';
import 'package:geekfleet/screens/dashboard/home.dart';
import 'package:geekfleet/screens/dashboard/liveChat.dart';
import 'package:geekfleet/screens/dashboard/myTickets.dart';
import 'package:geekfleet/utils/constants.dart';
import 'package:geekfleet/utils/firebaseCredentials.dart';

class Dashboard extends StatefulWidget {
  static const String HomeScreenRoute = 'HomeScreen';

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int i = 0;

  String currentUserId = FirebaseCredentials().auth.currentUser.uid;

  List<Widget> _items;
  DocumentSnapshot document;

  void initState() {
    super.initState();
    getUserData().then((data) {
      setState(() {
        document = data;
      });
    });
  }

  getUserData() {
    return FirebaseCredentials()
        .firebaseFirestore
        .collection('user')
        .doc(FirebaseCredentials().auth.currentUser.uid)
        .get();
  }

  void _updateTab(int index) {
    setState(() {
      i = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // UserDataModal user = bloc.fetchUserData();
    // // UserDataModal user = Provider.of<UserDataModal>(context,listen: false);
    _items = [
      Home(),
      MyTickets(),
      Events(),
      document != null
          ? LiveChat(
             /* routeArgumentModal: RouteArgumentModal(
                  param1: currentUserId,
                  param2: document.data()['userImage'],
                  param3: document.data()['firstName']),*/
            )
          : Container()
    ];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'Tag',
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddTicket())),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: document != null ? _items[i] : Container(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: i,
        onTap: _updateTab,
        selectedItemColor: secondary,
        showUnselectedLabels: true,
        backgroundColor: Colors.white,
        showSelectedLabels: true,
        unselectedIconTheme: IconThemeData(opacity: 0.8, color: Colors.grey),
        selectedIconTheme: IconThemeData(opacity: 1, color: secondary),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.stay_current_portrait,
              size: 25,
            ),
            label: 'My Devices',
          ),
          BottomNavigationBarItem(
              icon: i != 1
                  ? Image.asset(
                      'images/ticket.png',
                      height: 25,
                    )
                  : Image.asset(
                      'images/ticketGreen.png',
                      height: 25,
                    ),
              label: 'My Tickets'),
          BottomNavigationBarItem(
              icon: i != 2
                  ? Image.asset(
                      'images/date.png',
                      height: 25,
                    )
                  : Image.asset(
                      'images/dateGreen.png',
                      height: 25,
                    ),
              label: 'Date'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.mark_chat_read_outlined,
              size: 25,
            ),
            label: 'Live Chat',
          ),
        ],
      ),
    );
  }
}
