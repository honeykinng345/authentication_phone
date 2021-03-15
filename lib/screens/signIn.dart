import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geekfleet/screens/dashboard/dashboard.dart';
import 'package:geekfleet/screens/resetPassword.dart';
import 'package:geekfleet/screens/signUp.dart';
import 'package:geekfleet/utils/firebaseCredentials.dart';
import 'package:geekfleet/utils/socialAuthentication.dart';
import 'package:geekfleet/widgets/progressWidget.dart';

class SignIn extends StatefulWidget {
  static const String logInScreenRoute = 'LoginScreen';

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  bool isPassVisible = false;
  bool status = false;

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
                  'images/bg.png',
                ))),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 100,
                  child: Image.asset(
                    'images/gfimage.png',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'images/gfblack.png',
                  scale: 3,
                ),
                SizedBox(
                  height: 100,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        validator: (input) {
                          if (input.isEmpty)
                            return 'Required Field';
                          else
                            return null;
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.email,
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(30.0, 20.0, 20.0, 20.0),
                            hintText: "Email",
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
                        obscureText: isPassVisible ? false : true,
                        validator: (input) {
                          if (input.isEmpty)
                            return 'Required Field';
                          else
                            return null;
                        },
                        controller: passController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
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
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResetPassword())),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Forgot password?',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      status
                          ? ProgressIndicatorWidget()
                          : Container(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              height: 60,
                              width: double.infinity,
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  textColor: Colors.black,
                                  color: Color(0xff09F2BC),
                                  child: Text(
                                    'LOGIN',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  onPressed: () async {
                                    try {
                                      await login();
                                    } catch (e) {
                                      setState(() {
                                        status = false;
                                      });
                                    }
                                  })),
                      SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'or ',
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Login ',
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
                          GestureDetector(
                            onTap: () => signUpGoogle(context),
                            child: Container(
                              child: Image.asset(
                                'images/google.png',
                                scale: 3,
                              ),
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: const Color(0x00000000),
                                border: Border.all(
                                    width: 0.75, color: Colors.white),
                              ),
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
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account ',
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Sign up ',
                                style: TextStyle(color: Colors.black),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SignUpScreen()))),
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
      ),
    );
  }

  login() async {
    if (_formKey.currentState.validate()) {
      setState(
        () => status = true,
      );

      await FirebaseCredentials()
          .auth
          .signInWithEmailAndPassword(
              email: emailController.text, password: passController.text)
          .then((value) async {
        await FirebaseCredentials()
            .firebaseFirestore
            .collection('user')
            .where('email', isEqualTo: emailController.text)
            .where('userType', isEqualTo: 'customer')
            .get()
            .then((value) async {
          if (value.docs.length == 1)
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Dashboard()));
          else {
            await FirebaseCredentials().auth.signOut();
            setState(() => status = false);
          }
        });
      });
    }
  }
}
