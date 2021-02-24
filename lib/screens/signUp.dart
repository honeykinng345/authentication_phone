import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geekfleet/screens/dashboard/dashboard.dart';
import 'package:geekfleet/screens/signIn.dart';
import 'package:geekfleet/utils/firebaseCredentials.dart';
import 'package:geekfleet/widgets/progressWidget.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  static const String signUpScreenRoute = 'SignUpScreen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isPassVisible = false;
  bool isConfirmPassVisible = false;
  bool _status = false;
  String contactMethod;
  File _image;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(36.0),
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'images/bg.png',
                  ))),
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: Image.asset(
                  'images/gfimage.png',
                ),
              ),
              Image.asset(
                'images/gfblack.png',
                scale: 3,
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () => getImage(),
                child: Container(
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
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              size: 40,
                              color: Colors.grey,
                            ),
                            Text(
                              'Add Pic',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: GestureDetector(
                              onTap: () => getImage(),
                              child: Image.file(
                                _image,
                                fit: BoxFit.cover,
                              ))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: firstNameController,
                      validator: (input) {
                        if (input.isEmpty)
                          return 'Required Field';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                          ),
                          contentPadding:
                              EdgeInsets.fromLTRB(30.0, 20.0, 20.0, 20.0),
                          hintText: "First Name",
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: lastNameController,
                      validator: (input) {
                        if (input.isEmpty)
                          return 'Required Field';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                          ),
                          contentPadding:
                              EdgeInsets.fromLTRB(30.0, 20.0, 20.0, 20.0),
                          hintText: "Last Name",
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (input) {
                        Pattern pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regex = new RegExp(pattern);
                        if (input.trim().isEmpty || !regex.hasMatch(input)) {
                          return 'Please enter valid email address';
                        }
                        return null;
                      },
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                          ),
                          contentPadding:
                              EdgeInsets.fromLTRB(30.0, 20.0, 20.0, 20.0),
                          hintText: "Email",
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (input) {
                        if (input.isEmpty)
                          return 'Required Field';
                        else
                          return null;
                      },
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone,
                          ),
                          contentPadding:
                              EdgeInsets.fromLTRB(30.0, 20.0, 20.0, 20.0),
                          hintText: "Phone",
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (input) {
                        if (input.isEmpty)
                          return 'Required Field';
                        else
                          return null;
                      },
                      controller: addressController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.location_city,
                          ),
                          contentPadding:
                              EdgeInsets.fromLTRB(30.0, 20.0, 20.0, 20.0),
                          hintText: "Address",
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (input) {
                        if (input.isEmpty)
                          return 'Required Field';
                        else if (input.length < 8)
                          return 'Password should be 8 character long';
                        else
                          return null;
                      },
                      obscureText: isPassVisible ? false : true,
                      controller: passController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.vpn_key,
                          ),
                          suffixIcon: isPassVisible
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isPassVisible = !isPassVisible;
                                    });
                                  },
                                  child: Icon(Icons.visibility_off))
                              : GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isPassVisible = !isPassVisible;
                                    });
                                  },
                                  child: Icon(Icons.visibility)),
                          contentPadding:
                              EdgeInsets.fromLTRB(30.0, 20.0, 20.0, 20.0),
                          hintText: "Password",
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: isConfirmPassVisible ? false : true,
                      controller: confirmPasswordController,
                      validator: (input) {
                        if (input.isEmpty)
                          return 'Required Field';
                        else if (passController.text !=
                            confirmPasswordController.text)
                          return 'Passwords should be matched';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.vpn_key,
                          ),
                          suffixIcon: isConfirmPassVisible
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isConfirmPassVisible =
                                          !isConfirmPassVisible;
                                    });
                                  },
                                  child: Icon(Icons.visibility_off))
                              : GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isConfirmPassVisible =
                                          !isConfirmPassVisible;
                                    });
                                  },
                                  child: Icon(Icons.visibility)),
                          contentPadding:
                              EdgeInsets.fromLTRB(30.0, 20.0, 20.0, 20.0),
                          hintText: "Confirm Password",
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: DropdownButtonFormField(
                        validator: (input) {
                          if (input != null) return null;
                          return 'Select your Payment Method';
                        },
                        isDense: true,
                        style: TextStyle(color: Colors.greenAccent),
                        dropdownColor: Colors.white,
                        decoration: InputDecoration(
                            hintText: 'Select Method of Payment',
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.transparent),
                            )),
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _status
                        ? ProgressIndicatorWidget()
                        : Container(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            height: 60,
                            width: double.infinity,
                            // width: MediaQuery.of(context).size.width*3.5,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              textColor: Colors.black,
                              color: Color(0xff09F2BC),
                              child: Text(
                                'SIGN UP',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                signUp();
                              },
                            )),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'or ',
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(color: Colors.black)),
                          TextSpan(text: 'with social media'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Image.asset(
                            'images/google.png',
                            scale: 3,
                          ),
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: const Color(0x00000000),
                            border:
                                Border.all(width: 0.75, color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Image.asset(
                            'images/apple.png',
                            scale: 3,
                          ),
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: const Color(0x00000000),
                            border:
                                Border.all(width: 0.75, color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Image.asset(
                            'images/microsoft.png',
                            scale: 3,
                          ),
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: const Color(0x00000000),
                            border:
                                Border.all(width: 0.75, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account ',
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Sign In',
                              style: TextStyle(color: Colors.black),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignIn()))),
                          TextSpan(text: 'here'),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void signUp() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _status = true;
      });
      await FirebaseCredentials()
          .auth
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passController.text)
          .then((value) async {
        String downUrl;
        if (_image != null) {
          Reference ref = FirebaseStorage.instance.ref();
          TaskSnapshot addImg = await ref.child(value.user.uid).putFile(_image);
          downUrl = await addImg.ref.getDownloadURL();
        }
        FirebaseCredentials().auth.currentUser.updateProfile(
              displayName:
                  firstNameController.text + ' ' + lastNameController.text,
            );
        FirebaseCredentials()
            .auth
            .currentUser
            .updateEmail(emailController.text);
        FirebaseCredentials()
            .firestore
            .collection('user')
            .doc(value.user.uid)
            .set({
          'firstName': firstNameController.text,
          'lastName': lastNameController.text,
          'email': emailController.text,
          'contact': phoneController.text,
          'address': addressController.text,
          'userImage': _image != null ? downUrl : '',
          'contactMethod': contactMethod
        });
      });
      setState(() {
        _status = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    }
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
}
