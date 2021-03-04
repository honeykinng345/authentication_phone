import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geekfleet/controllers/chatController.dart';
import 'package:geekfleet/modals/routeArgumentModal.dart';
import 'package:geekfleet/utils/constants.dart';
import 'package:geekfleet/utils/firebaseCredentials.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SpecificUserChat extends StatefulWidget {
  final RouteArgumentModal routeArgument;

  SpecificUserChat({Key key, @required this.routeArgument}) : super(key: key);

  @override
  _SpecificUserChatState createState() => _SpecificUserChatState();
}

class _SpecificUserChatState extends State<SpecificUserChat> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'images/secondBG.png',
              ))),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Material(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  clipBehavior: Clip.hardEdge,
                  child: CachedNetworkImage(
                    height: 50,
                    width: 50,
                    placeholder: (context, url) => Container(
                      child: CircularProgressIndicator(
                        strokeWidth: 1.0,
                        valueColor: AlwaysStoppedAnimation<Color>(primary),
                      ),
                      padding: EdgeInsets.all(15.0),
                    ),
                    imageUrl: widget.routeArgument.param2 == ""
                        ? 'https://i.pinimg.com/originals/ed/c7/5e/edc75e41888082aa8323c725540624f5.jpg'
                        : widget.routeArgument.param2,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                widget.routeArgument.param3,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Expanded(
            child: ChatScreen(
              peerId: widget.routeArgument.param1,
              peerAvatar: widget.routeArgument.param2,
              peerName: widget.routeArgument.param3,
            ),
          ),
        ],
      ),
    ));
  }
}

class ChatScreen extends StatefulWidget {
  final String peerId;
  final String peerAvatar;
  final String peerName;

  ChatScreen(
      {Key key,
      @required this.peerId,
      @required this.peerAvatar,
      @required this.peerName})
      : super(key: key);

  @override
  State createState() => ChatScreenState(
      peerId: peerId, peerAvatar: peerAvatar, peerName: peerName);
}

class ChatScreenState extends StateMVC<ChatScreen> {
  String peerId;
  String peerAvatar;
  final String peerName;
  ChatController _con;

  ChatScreenState(
      {Key key,
      @required this.peerId,
      @required this.peerAvatar,
      @required this.peerName})
      : super(ChatController()) {
    this._con = controller;
  }

  updateStatus(status) async {
    await FirebaseCredentials()
        .firebaseFirestore
        .collection('token')
        .doc(FirebaseCredentials().auth.currentUser.uid)
        .set({
      "isOnline": status,
    }, SetOptions(merge: true));
  }

  @override
  void initState() {
    super.initState();
    _con.focusNode.addListener(_con.onFocusChange);
    _con.listScrollController.addListener(_con.scrollListener);
    _con.init(peerId);
    updateStatus(true);
  }

  @override
  void dispose() {
    super.dispose();
    updateStatus(false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            // List of messages
            _con.buildListMessage(peerAvatar),
            _con.buildInput(peerId),
          ],
        ),
        _con.buildLoading()
      ],
    );
  }
}
