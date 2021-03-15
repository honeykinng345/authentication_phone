import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geekfleet/screens/dashboard/dashboard.dart';
import 'package:geekfleet/utils/constants.dart';
import 'package:geekfleet/utils/firebaseCredentials.dart';
import 'package:geekfleet/widgets/arrowBackWidget.dart';
import 'package:geekfleet/widgets/progressWidget.dart';

class AddDevice extends StatefulWidget {
  @override
  _AddDeviceState createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  List<String> itemList = [
    'PC/Laptop',
    'Networking',
    'Mobile Devices',
    'Home Devices'
  ];

  String type;

  final deviceName = TextEditingController();
  final serialNumber = TextEditingController();
  final notes = TextEditingController();
  bool isCategory = true;
  bool _status = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Container(
              height: MediaQuery.of(context).size.height / 1.04,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
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
                    height: 15,
                  ),
                  Text(
                    'Add Device',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          child: TextFormField(
                              controller: deviceName,
                              validator: (input) {
                                if (input.isEmpty)
                                  return 'Required Field';
                                else
                                  return null;
                              },
                              cursorColor: primary,
                              decoration: InputDecoration(
                                labelText: 'Device Name',
                                labelStyle: TextStyle(
                                  color: Color(0xff9400D3),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color(0xff9400D3),
                                )),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide()),
                              )),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  color: !isCategory
                                      ? Theme.of(context).errorColor
                                      : Colors.grey)),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Center(
                            child: DropdownButton(
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: primary,
                                ),
                                hint: Text(
                                  'Category',
                                  style: TextStyle(
                                      color: Color(0xff9400D3),
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                                elevation: 5,
                                isExpanded: true,
                                underline: Container(
                                  color: Colors.transparent,
                                ),
                                focusColor: Color(0xff9400D3),
                                value: type,
                                isDense: true,
                                items: itemList.map((value) {
                                  return DropdownMenuItem(
                                      value: value,
                                      child: Text(
                                        value,
                                        style:
                                            TextStyle(color: Color(0xff9400D3)),
                                      ));
                                }).toList(),
                                onChanged: (input) {
                                  setState(() {
                                    type = input;
                                  });
                                }),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        !isCategory
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Select your Device Category',
                                    style: TextStyle(
                                        fontSize: 12.5,
                                        color: Theme.of(context).errorColor),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: TextFormField(
                              controller: serialNumber,
                              keyboardType: TextInputType.phone,
                              validator: (input) {
                                if (input.isEmpty)
                                  return 'Required Field';
                                else
                                  return null;
                              },
                              cursorColor: primary,
                              decoration: InputDecoration(
                                labelText: 'Serial Number',
                                labelStyle: TextStyle(
                                  color: Color(0xff9400D3),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color(0xff9400D3),
                                )),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide()),
                              )),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: TextFormField(
                              controller: notes,
                              validator: (input) {
                                if (input.isEmpty)
                                  return 'Required Field';
                                else
                                  return null;
                              },
                              cursorColor: primary,
                              decoration: InputDecoration(
                                labelText: 'Notes',
                                labelStyle: TextStyle(
                                  color: Color(0xff9400D3),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color(0xff9400D3),
                                )),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide()),
                              )),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  _status
                      ? ProgressIndicatorWidget()
                      : Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            textColor: Colors.white,
                            color: Color(0xff9400D3),
                            child: Text(
                              'Submit',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              submit();
                            },
                          )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void submit() async {
    if (type == null) {
      setState(() {
        isCategory = false;
      });
    }
    if (_formKey.currentState.validate()) {
      setState(() {
        _status = true;
      });
      String currentUserId = FirebaseCredentials().auth.currentUser.uid;
      String documentId = FirebaseCredentials()
          .firebaseFirestore
          .collection('devices')
          .doc()
          .id;
      FirebaseCredentials()
          .firebaseFirestore
          .collection('devices')
          .doc(documentId)
          .set({
        'deviceName': deviceName.text,
        'serialNumber': serialNumber.text,
        'notes': notes.text,
        'deviceUserId': currentUserId,
        'deviceCategory': type,
        'documentId': documentId
      });
      setState(() {
        _status = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    }
  }
}
