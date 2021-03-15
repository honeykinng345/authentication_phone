import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geekfleet/bloc/fetchDataFromFirebase.dart';
import 'package:geekfleet/modals/myTicketListModal.dart';
import 'package:geekfleet/screens/drawer.dart';
import 'package:geekfleet/utils/constants.dart';
import 'package:provider/provider.dart';

class MyTickets extends StatefulWidget {
  static const String ticketListScreenRoute = 'TicketListScreen';

  @override
  _MyTicketsState createState() => _MyTicketsState();
}

class _MyTicketsState extends State<MyTickets> {
  final GlobalKey<ScaffoldState> _scaffoldKeyHome =
      new GlobalKey<ScaffoldState>();

  bool isSearch = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllTickets();
    MyTicketList list = Provider.of<MyTicketList>(context, listen: false);
    bloc.allTickets.listen((event) {
      list.setDocuments(event);
      list.update();
    });
    return Consumer<MyTicketList>(builder: (context, a, v) {
      return Scaffold(
        key: _scaffoldKeyHome,
        drawer: LeftDrawer(),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'images/bg2.png',
                  ))),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Column(children: [
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Tickets',
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
                                onChanged: (input) async {
                                  print(input);
                                  list.filterSearchResults(input);
                                },
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
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.queryList.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, i) {
                    return Card(
                      child: Column(
                        children: [
                          Container(
                            height: 25,
                            color: list.queryList[i].ticketStatus == 'Open'
                                ? Colors.blue
                                : list.queryList[i].ticketStatus == 'Assigned'
                                    ? purple
                                    : primary,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Text(list.queryList[i].description,style: TextStyle(color: Colors.white),),
                                Text('Waiting',
                                    style: TextStyle(color: Colors.white)),
                                Text(
                                    list.queryList[i].ticketStatus == 'Open'
                                        ? 'Assigning'
                                        : list.queryList[i].ticketStatus ==
                                                'Assigned'
                                            ? 'Assigned'
                                            : 'Closed',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: ListTile(
                                leading: Container(
                                  width: 40,
                                  child: Image.asset(
                                    list.queryList[i].deviceCategory ==
                                            "PC/Laptops"
                                        ? 'images/laptopes.png'
                                        : list.queryList[i].deviceCategory ==
                                                'Mobile Devices'
                                            ? 'images/mobiles.png'
                                            : list.queryList[i]
                                                        .deviceCategory ==
                                                    'Networking'
                                                ? 'images/modem.png'
                                                : 'images/house.png',
                                  ),
                                ),
                                title: Container(
                                  height: 20,
                                  child: Text(
                                    list.queryList[i].summary,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                subtitle: Container(
                                  height: 20,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      list.queryList[i].description,
                                      style: TextStyle(
                                          color: purple,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0)),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ]),
            ),
          ),
        ),
      );
    });
  }
}
