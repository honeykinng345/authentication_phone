import 'package:flutter/material.dart';
import 'package:geekfleet/screens/dashboard/dashboard.dart';
import 'package:geekfleet/utils/constants.dart';
import 'package:geekfleet/utils/firebaseCredentials.dart';
import 'package:geekfleet/widgets/arrowBackWidget.dart';
import 'package:geekfleet/widgets/progressWidget.dart';

class AddTicket extends StatefulWidget {
  @override
  _AddTicketState createState() => _AddTicketState();
}

class _AddTicketState extends State<AddTicket> {
  final summaryController = TextEditingController();
  final descriptionController = TextEditingController();

  bool _status = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String selectedDevice;
  List<String> devicesList = [
    'Pc/Laptops',
    'Mobiles',
    'Networking ',
    'Home Devices',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'images/bg2.png',
                ))),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height / 1.07,
            child: Column(children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ArrowBackWidget(),
                  Image.asset(
                    'images/grouptwo.png',
                    height: 30,
                  ),
                  Visibility(
                    visible: false,
                    child: Text('ll'),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'New Tickets',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                        controller: summaryController,
                        validator: (input) {
                          if (input.isEmpty)
                            return 'Required Filed';
                          else
                            return null;
                        },
                        cursorColor: primary,
                        decoration: InputDecoration(
                          labelText: 'Summary',
                          labelStyle: TextStyle(
                            color: Color(0xff9400D3),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xff9400D3),
                          )),
                          border: OutlineInputBorder(borderSide: BorderSide()),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        controller: descriptionController,
                        validator: (input) {
                          if (input.isEmpty)
                            return 'Required Field';
                          else
                            return null;
                        },
                        cursorColor: primary,
                        maxLines: 10,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: TextStyle(
                            color: Color(0xff9400D3),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xff9400D3),
                          )),
                          border: OutlineInputBorder(borderSide: BorderSide()),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: DropdownButtonFormField(
                        isDense: true,
                        style: TextStyle(color: Colors.greenAccent),
                        dropdownColor: Colors.white,
                        decoration: InputDecoration(
                          hintText: 'Select Method',
                          hintStyle: TextStyle(color: Color(0xff9400D3)),
                          labelText: 'User Device',
                          labelStyle: TextStyle(
                            color: Color(0xff9400D3),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xff9400D3),
                          )),
                        ),
                        value: selectedDevice,
                        items: devicesList
                            .map<DropdownMenuItem<String>>((String value) =>
                                DropdownMenuItem(
                                  child: Text(value,
                                      style: TextStyle(color: Colors.black)),
                                  value: value,
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedDevice = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              _status
                  ? ProgressIndicatorWidget()
                  : Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      height: 50,
                      width: double.infinity,
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
                          })),
            ]),
          ),
        ),
      ),
    );
  }

  void submit() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _status = true;
      });
      String currentUserId = FirebaseCredentials().auth.currentUser.uid;
      FirebaseCredentials().firestore.collection('tickets').doc().set({
        'summary': summaryController.text,
        'description': descriptionController.text,
        'selectedDevice': selectedDevice,
        'ticketUserId': currentUserId,
      });
      setState(() {
        _status = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    }
  }
}
