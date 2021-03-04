import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geekfleet/utils/constants.dart';
import 'package:geekfleet/utils/firebaseCredentials.dart';
import 'package:geekfleet/widgets/arrowBackWidget.dart';
import 'package:geekfleet/widgets/progressWidget.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  static const String userProfileScreenRoute = 'UserProfileScreen';

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();
  final contactController = TextEditingController();
  String contactMethod;

  bool _status = false;
  DocumentSnapshot document;

  @override
  void initState() {
    super.initState();
    getUserData().then((data) {
      setState(() {
        document = data;
        firstNameController.text = document.data()['firstName'];
        lastNameController.text = document.data()['lastName'];
        addressController.text = document.data()['address'];
        contactController.text = document.data()['contact'];
        contactMethod = document.data()['contactMethod'];
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File _image;

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'images/bg2.png',
                  ))),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 30, right: 15),
            child: Container(
              height: MediaQuery.of(context).size.height / 1.03,
              child: Column(children: [
                SizedBox(
                  height: 10,
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
                  height: 30,
                ),
                Text(
                  'User Profile',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                Stack(
                  overflow: Overflow.visible,
                  children: [
                    document != null
                        ? Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0, 0),
                                    blurRadius: 3,
                                    spreadRadius: 3)
                              ],
                            ),
                            child: _image == null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                        document.data()['userImage'] == ''
                                            ? 'https://i.pinimg.com/originals/ed/c7/5e/edc75e41888082aa8323c725540624f5.jpg'
                                            : document.data()['userImage'],
                                        fit: BoxFit.cover),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      _image,
                                      fit: BoxFit.cover,
                                    ),
                                  ))
                        : ProgressIndicatorWidget(),
                    Positioned(
                        bottom: -5,
                        right: -5,
                        child: InkWell(
                          onTap: () => _showPicker(context),
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: primary),
                            child: Icon(
                              Icons.edit,
                              size: 17,
                            ),
                          ),
                        ))
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: Column(children: [
                    TextFormField(
                        controller: firstNameController,
                        validator: (input) {
                          if (input.isEmpty)
                            return 'Required Field';
                          else
                            return null;
                        },
                        cursorColor: primary,
                        decoration: InputDecoration(
                          labelText: 'First Name',
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
                      height: 15,
                    ),
                    TextFormField(
                        controller: lastNameController,
                        validator: (input) {
                          if (input.isEmpty)
                            return 'Required Field';
                          else
                            return null;
                        },
                        cursorColor: primary,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
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
                      height: 15,
                    ),
                    TextFormField(
                        controller: addressController,
                        validator: (input) {
                          if (input.isEmpty)
                            return 'Required Field';
                          else
                            return null;
                        },
                        cursorColor: primary,
                        decoration: InputDecoration(
                          labelText: 'ADDRESS',
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
                      height: 15,
                    ),
                    TextFormField(
                        controller: contactController,
                        validator: (input) {
                          if (input.isEmpty)
                            return 'Required Field';
                          else
                            return null;
                        },
                        cursorColor: primary,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Phone',
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
                          labelText: 'Preferred Method of Contact',
                          labelStyle: TextStyle(
                            color: Color(0xff9400D3),
                          ),

                          filled: true,
                          // fillColor: Colors.white.withOpacity(0.1),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(
                              color: Color(0xff9400D3),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xff9400D3),
                          )),
                        ),
                        value: contactMethod,
                        items: [
                          'Phone',
                          'Email',
                        ]
                            .map<DropdownMenuItem<String>>((String value) =>
                                DropdownMenuItem(
                                  child: Text(value,
                                      style: TextStyle(color: Colors.black)),
                                  value: value,
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            contactMethod = value;
                          });
                        },
                      ),
                    )
                  ]),
                ),
                Spacer(),
                _status
                    ? ProgressIndicatorWidget()
                    : Container(
                        padding: EdgeInsets.only(left: 0, right: 0),
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
                            update();
                          },
                        )),
                SizedBox(
                  height: 10,
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void update() async {
    setState(() {
      _status = true;
    });
    String downUrl;
    if (_image != null) {
      Reference ref = FirebaseStorage.instance.ref();
      TaskSnapshot addImg = await ref
          .child(FirebaseCredentials().auth.currentUser.uid)
          .putFile(_image);
      downUrl = await addImg.ref.getDownloadURL();
    }
    FirebaseCredentials()
        .firebaseFirestore
        .collection("user")
        .doc(FirebaseCredentials().auth.currentUser.uid)
        .update({
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "address": addressController.text,
      "contact": contactController.text,
      if (_image != null) "userImage": downUrl,
      "contactMethod": contactMethod
    }).then((_) {
      FirebaseCredentials().auth.currentUser.updateProfile(
            displayName:
                firstNameController.text + ' ' + lastNameController.text,
          );
      setState(() {
        _status = false;
      });
      Navigator.pop(context);
    });
  }
}
