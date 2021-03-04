import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireStoreExaple extends StatefulWidget {
  @override
  _FireStoreExapleState createState() => _FireStoreExapleState();
}

class _FireStoreExapleState extends State<FireStoreExaple> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FireStore'),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('newticket').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text('Loading Data ...Please Wait ');
          return Container(
            height: 70,
            width: double.infinity,
            color: Colors.red,
            child: Card(
              child: Column(
                children: [
                  Text(snapshot.data.documents[0]['summary']),
                  Text(snapshot.data.documents[0]['description'])
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
