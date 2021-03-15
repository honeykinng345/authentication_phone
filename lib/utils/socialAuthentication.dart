import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geekfleet/screens/dashboard/dashboard.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'firebaseCredentials.dart';

GoogleSignIn googleSignIn = GoogleSignIn();

Future<bool> checkEmailExist(String mail) async {
  print(mail);
  await FirebaseCredentials()
      .firebaseFirestore
      .collection('user')
      .where('email', isEqualTo: mail)
      .get()
      .then((value) {
    if (value.docs.length != 1) {
      print('FirstTrue');
      return false;
    } else {
      print('FirstFalse');
      return true;
    }
  });
  return false;
}

signUpGoogle(context) async {
  try {
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    String _googleUserEmail = googleUser.email;
    print(await checkEmailExist(_googleUserEmail));
    if (await checkEmailExist(_googleUserEmail)) {
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      User firebaseUser =
          (await FirebaseCredentials().auth.signInWithCredential(credential))
              .user;
      await firebaseUser.updateEmail(_googleUserEmail);
      print('if');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
          (route) => false);
    } else {
      print('else');
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      User firebaseUser =
          (await FirebaseCredentials().auth.signInWithCredential(credential))
              .user;
      await firebaseUser.updateEmail(_googleUserEmail);
      if (firebaseUser != null) {
        FirebaseCredentials()
            .firebaseFirestore
            .collection('user')
            .doc(firebaseUser.uid)
            .set({
          'firstName': firebaseUser.displayName,
          'lastName': '',
          'email': _googleUserEmail,
          'phone': firebaseUser.phoneNumber ?? "N/A",
          'userType': 'customer',
          'userImage': firebaseUser.photoURL ?? '',
        }, SetOptions(merge: true)).then((value) {
          print(firebaseUser.email);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Dashboard()),
              (route) => false);
        });
      }
    }
  } catch (error) {
    print(error.toString());
  }
}
