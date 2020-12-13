import 'package:flutter/material.dart';

import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:learn2drive/screens/loading/loading_screen.dart';

class AuthScreen extends StatelessWidget {
  @override
  bool loading = false;
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      body: Center(
        child: Card(
          margin: EdgeInsets.all(24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SignInButton(
                    MediaQuery.of(context).platformBrightness ==
                        Brightness.dark
                        ? Buttons.GoogleDark
                        : Buttons.Google,
                    onPressed: () {loading = true;}
                  ),
                  SignInButton(
                    Buttons.FacebookNew,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
