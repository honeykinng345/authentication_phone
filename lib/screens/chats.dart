import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geekfleet/modals/routeArgumentModal.dart';
import 'package:geekfleet/screens/specificUserChat.dart';
import 'package:geekfleet/utils/constants.dart';
import 'package:geekfleet/utils/firebaseCredentials.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  String currentUserId = FirebaseCredentials().auth.currentUser.uid;

  var chattedWith;
  String userId;

  DocumentSnapshot document;

  @override
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

  getChatHistory() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('user')
        .doc(currentUserId)
        .get();
    Map<String, dynamic> data = snap.data();
    chattedWith = data.containsKey('chattedWith') ? data['chattedWith'] : [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.25,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10, left: 16, bottom: 10),
            child: Text(
              'My Chats',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          StreamBuilder(
            stream: FirebaseCredentials()
                .firebaseFirestore
                .collection('user')
                // .where('chattedWith', arrayContains: userId)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                int length = snapshot.data.docs.length;
                print("Chat History Length : $length");
                return Expanded(
                  child: ListView.builder(
                    itemCount: length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          DocumentSnapshot doc = await FirebaseFirestore
                              .instance
                              .collection('user')
                              .doc(currentUserId)
                              .get();
                          // var ownerImage = doc['images'];
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SpecificUserChat(
                                  routeArgument: RouteArgumentModal(
                                      param1: currentUserId,
                                      param2: document.data()['userImage'],
                                      param3: document.data()['firstName']))));
                        },
                        child: Container(
                          width: double.infinity,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              child: ListTile(
                                title: Text(
                                  snapshot.data.docs[index]['firstName'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                leading: SizedBox(
                                  height: 100,
                                  width: 55,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: primary, width: 2),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: CircleAvatar(
                                      radius: 60,
                                      backgroundImage: NetworkImage(
                                          snapshot.data.docs[index]
                                                      ['userImage'] ==
                                                  ""
                                              ? 'https://i.pinimg.com/originals/ed/c7/5e/edc75e41888082aa8323c725540624f5.jpg'
                                              : snapshot.data.docs[index]
                                                  ['userImage'],
                                          scale: 4),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.pink,
                    strokeWidth: 2,
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
