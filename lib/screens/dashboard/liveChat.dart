// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:geekfleet/controllers/chatController.dart';
// import 'package:geekfleet/modals/choose.dart';
// import 'package:geekfleet/modals/routeArgumentModal.dart';
// import 'package:geekfleet/utils/constants.dart';
// import 'package:mvc_pattern/mvc_pattern.dart';
//
// class LiveChat extends StatelessWidget {
//   final RouteArgumentModal routeArgumentModal;
//
//   LiveChat({this.routeArgumentModal});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         titleSpacing: 1.0,
//         leading: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Material(
//             borderRadius: BorderRadius.all(Radius.circular(25.0)),
//             clipBehavior: Clip.hardEdge,
//             child: CachedNetworkImage(
//               placeholder: (context, url) => Container(
//                 child: CircularProgressIndicator(
//                   strokeWidth: 1.0,
//                   valueColor: AlwaysStoppedAnimation<Color>(primary),
//                 ),
//                 padding: EdgeInsets.all(15.0),
//               ),
//               imageUrl: routeArgumentModal.param2,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         title: Text(
//           routeArgumentModal.param3,
//           style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
//         ),
//         actions: <Widget>[
//           PopupMenuButton<Choice>(
//             onSelected: (Choice choice) {
//               if (choice.title == 'media') {
//                 Navigator.of(context).pushReplacementNamed('/media',
//                     arguments: routeArgumentModal);
//               } else {}
//             },
//             itemBuilder: (BuildContext context) {
//               return <Choice>[
//                 Choice(title: 'media', icon: Icons.more_vert),
//               ].map((Choice choice) {
//                 return PopupMenuItem<Choice>(
//                     value: choice,
//                     child: Row(
//                       children: <Widget>[
//                         Icon(
//                           choice.icon,
//                           color: primary,
//                         ),
//                         Container(
//                           width: 10.0,
//                         ),
//                         Text(
//                           choice.title,
//                         ),
//                       ],
//                     ));
//               }).toList();
//             },
//           ),
//         ],
//       ),
//       body: ChatScreen(
//         peerId: routeArgumentModal.param1,
//         peerAvatar: routeArgumentModal.param2,
//         peerName: routeArgumentModal.param3,
//       ),
//     );
//   }
// }
//
// class ChatScreen extends StatefulWidget {
//   final String peerId;
//   final String peerAvatar;
//   final String peerName;
//
//   ChatScreen(
//       {Key key,
//       @required this.peerId,
//       @required this.peerAvatar,
//       @required this.peerName})
//       : super(key: key);
//
//   @override
//   State createState() => ChatScreenState(
//       peerId: peerId, peerAvatar: peerAvatar, peerName: peerName);
// }
//
// class ChatScreenState extends StateMVC<ChatScreen> {
//   String peerId;
//   String peerAvatar;
//   final String peerName;
//   ChatController _con;
//
//   ChatScreenState(
//       {Key key,
//       @required this.peerId,
//       @required this.peerAvatar,
//       @required this.peerName})
//       : super(ChatController()) {
//     this._con = controller;
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _con.focusNode.addListener(_con.onFocusChange);
//     _con.listScrollController.addListener(_con.scrollListener);
//     _con.init(peerId);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         Column(
//           children: <Widget>[
//             _con.buildListMessage(peerAvatar),
//             _con.buildInput(peerId),
//           ],
//         ),
//         _con.buildLoading()
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:geekfleet/screens/chats.dart';

import '../drawer.dart';

class LiveChat extends StatefulWidget {
  static const String petChatScreenRoute = 'PetChatScreen';

  @override
  _LiveChatState createState() => _LiveChatState();
}

class _LiveChatState extends State<LiveChat> {
  final GlobalKey<ScaffoldState> _scaffoldKeyHome =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKeyHome,
        resizeToAvoidBottomPadding: false,
        drawer: LeftDrawer(),
        body: Container(
          height: double.infinity,
          width: double.infinity,
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
                  Chats()
                ],
              ),
            ),
          ),
        ));
  }
}
