import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'dart:async';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email'],
);

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  final User user = authResult.user;

  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    print('signInWithGoogle succeeded: $user');

    return '$user';
  }

  return null;
}

Future<void> signOutGoogle() async {
  await _googleSignIn.signOut();

  print("User Signed Out Google");
}

void signOut(BuildContext ctx) async {
  signOutGoogle();
  _auth.signOut();
  print("User Signed Out");
}

bool isLoggedIn() {
  if (_auth.currentUser == null) return false;
  return !_auth.currentUser.isAnonymous &&
      _auth.currentUser.getIdToken() != null;
}

Future<User> getCurrentUser() async {
  return _auth.currentUser;
}

String getUsername() {
  return _auth.currentUser.displayName;
}

String getEmail() {
  return _auth.currentUser.email;
}

String getImageURL() {
  return _auth.currentUser.photoURL;
}

String getUID() {
  return _auth.currentUser.uid;
}
