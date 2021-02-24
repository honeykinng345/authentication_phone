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
                    return Container(
                        width: double.infinity,
                        child: Card(
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              child: ListTile(
                                title: Text(
                                  list.queryList[i].summary,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    list.queryList[i].description,
                                    style: TextStyle(
                                        color: purple,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ));
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
