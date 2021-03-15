import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geekfleet/screens/dashboard/dashboard.dart';
import 'package:geekfleet/utils/constants.dart';
import 'package:geekfleet/utils/firebaseCredentials.dart';
import 'package:geekfleet/widgets/arrowBackWidget.dart';
import 'package:geekfleet/widgets/progressWidget.dart';
import 'package:stripe_native/stripe_native.dart';
import 'package:stripe_payment/stripe_payment.dart';

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
  String deviceCategory;
  List<String> devicesList = [
    'Pc/Laptops',
    'Mobiles',
    'Networking ',
    'Home Devices',
  ];

  ScrollController _controller = ScrollController();

  final GlobalKey<ScaffoldState> _scaffoldKeyHome =
      new GlobalKey<ScaffoldState>();

  String currentUserId;
  QuerySnapshot devices;
  DocumentSnapshot userData;
  bool isGenerateTicket = false;
  Token _paymentToken;

  @override
  void initState() {
    currentUserId = FirebaseCredentials().auth.currentUser.uid;
    super.initState();
    getUserData().then((result) {
      setState(() {
        userData = result;
      });
    });
    getMobiles().then((data) {
      setState(() {
        devices = data;
      });
    });
    StripePayment.setOptions(StripeOptions(
        publishableKey:
            "pk_test_51HUqDKIOz6hSecjswpcnZpmHBghJBoLWe8KezsgCagQLF5PwkUe0h94WrF5hHyL08KkPOY4OmbJjf09YeMlYWPRI001667QONe",
        merchantId: "Your_Merchant_id",
        androidPayMode: 'test'));
    // StripeNative.setPublishableKey(
    //     'pk_test_51HUqDKIOz6hSecjswpcnZpmHBghJBoLWe8KezsgCagQLF5PwkUe0h94WrF5hHyL08KkPOY4OmbJjf09YeMlYWPRI001667QONe');
  }

  getUserData() async {
    return await FirebaseCredentials()
        .firebaseFirestore
        .collection('user')
        .doc(currentUserId)
        .get();
  }

  getMobiles() async {
    return await FirebaseCredentials()
        .firebaseFirestore
        .collection('devices')
        .where('deviceUserId', isEqualTo: currentUserId)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKeyHome,
        body: devices != null
            ? Container(
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
                          'Submit a New Ticket',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
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
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide()),
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
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide()),
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
                                  hintStyle:
                                      TextStyle(color: Color(0xff9400D3)),
                                  labelText: 'Your Devices',
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
                                items: devices.docs
                                    .map((DocumentSnapshot document) {
                                  return DropdownMenuItem(
                                    child: Text(document.data()['deviceName'],
                                        style: TextStyle(color: Colors.black)),
                                    value: document.data()['documentId'],
                                    //document.data()['deviceCategory']
                                    //],
                                  );
                                }).toList()
                                /*devicesList
                                    .map<DropdownMenuItem<String>>(
                                        (String value) => DropdownMenuItem(
                                              child: Text(value,
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                              value: value,
                                            ))
                                    .toList()*/
                                ,
                                onChanged: (value) {
                                  // setState(() {
                                  selectedDevice = value;
                                  var x = devices.docs.firstWhere((element) {
                                    return element.data()['documentId'] ==
                                        value;
                                  });
                                  deviceCategory = x.data()['deviceCategory'];
                                  // deviceCategory = input;
                                  // });
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
                                onPressed: () => dialog(),
                              )),
                    ]),
                  ),
                ),
              )
            : ProgressIndicatorWidget());
  }

  void dialog() {
    if (_formKey.currentState.validate()) {
      showGeneralDialog(
          barrierLabel: "Label",
          barrierDismissible: true,
          barrierColor: Colors.black.withOpacity(0.5),
          transitionDuration: Duration(milliseconds: 500),
          context: context,
          pageBuilder: (context, anim1, anim2) {
            return SafeArea(
              child: Align(
                alignment: Alignment.center,
                child: Material(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 1.2,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                'images/grouptwo.png',
                                height: 30,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(userData.data()['firstName'] +
                                ' ' +
                                userData.data()['lastName']),
                            Text(userData.data()['email']),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Summary',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                            Text(summaryController.text),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Description',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                            Text(descriptionController.text),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Device',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                            Text(selectedDevice != null
                                ? selectedDevice
                                : 'Not Listed'),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Plan',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                            Text(userData.data()['subscriptionType']),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Preferred Method of Contact',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                            Text(userData.data()['contactMethod']),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 2,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Service Fee',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                Text(userData.data()['subscriptionType'] ==
                                        'PAYG'
                                    ? '\$15.00'
                                    : userData.data()['subscriptionType'] ==
                                            'Nerd Herd'
                                        ? '\$5.00'
                                        : '\$0.00'),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tax',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                Text(userData.data()['subscriptionType'] ==
                                        'PAYG'
                                    ? '\$0.90'
                                    : userData.data()['subscriptionType'] ==
                                            'Nerd Herd'
                                        ? '\$0.90'
                                        : '\$0.00'),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                Text(userData.data()['subscriptionType'] ==
                                        'PAYG'
                                    ? '\$15.90'
                                    : userData.data()['subscriptionType'] ==
                                            'Nerd Herd'
                                        ? '\$5.90'
                                        : '\$0.00'),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                                '*The service fee is not the final sale price. You will be contacted prior to any change pertaining to the amount shown above. By clicking submit you agree to the terms and conditions of the Geek Fleet service'),
                            SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width / 2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  color: purple,
                                  onPressed: () => submit(),
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
            );
          });
    }
  }

  Future<String> get receiptPayment async {
    if (userData.data()['subscriptionType'] == 'PAYG') {
      const receipt = <String, double>{
        "Generate Ticket Cost": 15,
      };
      var aReceipt = Receipt(receipt, "Geek Fleet");
      return await StripeNative.useReceiptNativePay(aReceipt);
    } else if (userData.data()['subscriptionType'] == 'Nerd Herd') {
      const receipt = <String, double>{
        "Generate Ticket Cost": 5,
      };
      var aReceipt = Receipt(receipt, "Geek Fleet");
      return await StripeNative.useReceiptNativePay(aReceipt);
    }
    return null;
  }

  Future<String> get orderPayment async {
    // subtotal, tax, tip, merchant name
    var order = Order(5.50, 1.0, 2.0, "Some Store");
    return await StripeNative.useNativePay(order);
  }

  void submit() async {
    if (_formKey.currentState.validate()) {
      if (await userData.data()['subscriptionType'] != 'Full Geek') {
        try {
          if (Platform.isIOS) _controller.jumpTo(450);
          StripePayment.paymentRequestWithNativePay(
            androidPayOptions: AndroidPayPaymentRequest(
              totalPrice:
                  userData.data()['subscriptionType'] == 'PAYG' ? '15' : '5',
              currencyCode: "EUR",
            ),
            applePayOptions: ApplePayPaymentOptions(
              countryCode: 'DE',
              currencyCode: 'EUR',
              items: [
                ApplePayItem(
                  label: 'Test',
                  amount: userData.data()['subscriptionType'] == 'PAYG'
                      ? '15'
                      : '5',
                )
              ],
            ),
          ).then((token) {
            print('Main Half Geek hn.');
            setState(() {
              _scaffoldKeyHome.currentState.showSnackBar(
                  SnackBar(content: Text('Received ${token.tokenId}')));
              _paymentToken = token;
              setState(() {
                _status = true;
              });
              String currentUserId = FirebaseCredentials().auth.currentUser.uid;
              FirebaseCredentials()
                  .firebaseFirestore
                  .collection('tickets')
                  .doc()
                  .set({
                'ticketStatus': 'Open',
                'summary': summaryController.text,
                'description': descriptionController.text,
                'selectedDevice': selectedDevice,
                'ticketUserId': currentUserId,
                'deviceCategory': deviceCategory
              });
              setState(() {
                _status = false;
              });
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Dashboard()));
            });
          }).catchError((setError) {});
        } catch (e) {
          print(e.message);
        }
      } else {
        print('Main Full Geek Hn');
        setState(() {
          _status = true;
        });
        String currentUserId = FirebaseCredentials().auth.currentUser.uid;
        FirebaseCredentials()
            .firebaseFirestore
            .collection('tickets')
            .doc()
            .set({
          'ticketStatus': 'Open',
          'summary': summaryController.text,
          'description': descriptionController.text,
          'selectedDevice': selectedDevice,
          'ticketUserId': currentUserId,
          'deviceCategory': deviceCategory
        });
        setState(() {
          _status = false;
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Dashboard()));
      }
    }
  }
}
