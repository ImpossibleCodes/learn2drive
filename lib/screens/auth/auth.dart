import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'dart:async';

String _username;
String _email;
String _imageurl;

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email'],
);

Future<String> signInWithGoogle() async {
  await Firebase.initializeApp();

  final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult = await _auth.signInWithCredential(credential);
  final User user = authResult.user;

  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    _username = user.displayName;
    _email = user.email;
    _imageurl = user.photoURL;

    print('signInWithGoogle succeeded: $user');

    return '$user';
  }

  return null;
}

Future<void> signOutGoogle() async {
  await _googleSignIn.signOut();

  print("User Signed Out");
}

void signOut(BuildContext ctx) async {
  User user = _auth.currentUser;
  if (user.providerData[1].providerId == 'google.com') {
    signOutGoogle();
  }
  _auth.signOut();
}

Future<User> getCurrentUser() async {
  User _user = _auth.currentUser;

  return _user;
}

String getUsername() {
  return _username;
}

String getEmail() {
  return _email;
}

String getImageURL() {
  return _imageurl;
}
