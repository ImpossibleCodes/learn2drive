import 'package:flutter/material.dart';

import 'package:flutter_signin_button/flutter_signin_button.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    onPressed: () {}
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
