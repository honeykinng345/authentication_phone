import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geekfleet/modals/myDeviceListModal.dart';
import 'package:geekfleet/utils/constants.dart';
import 'package:geekfleet/widgets/arrowBackWidget.dart';
import 'package:provider/provider.dart';

class ShowDevice extends StatefulWidget {
  final QuerySnapshot object;

  ShowDevice({this.object});

  @override
  _ShowDeviceState createState() => _ShowDeviceState();
}

class _ShowDeviceState extends State<ShowDevice> {
  bool isSearch = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MyDeviceList list = Provider.of<MyDeviceList>(context, listen: false);
    list.setDocuments(widget.object.docs);
    list.update();
    return Consumer<MyDeviceList>(builder: (context,c,v){
      return Scaffold(
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
                padding: const EdgeInsets.only(right: 15, left: 15, top: 20),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ArrowBackWidget(),
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
                          widget.object.docs[0]['deviceCategory'],
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                              onChanged: (input) {
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
                  itemBuilder: (context, i) {
                    return Container(
                        width: double.infinity,
                        child: Card(
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: ListTile(
                                title: Text(
                                  list.queryList[i].deviceName,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    list.queryList[i].deviceCategory,
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
                )
                  ],
                ),
              ),
            ),
          ));
    });
  }
}
