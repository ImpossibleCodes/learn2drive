import 'package:flutter/material.dart';

import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:learn2drive/fix_docs_screen.dart';
import 'package:learn2drive/screens/auth/auth.dart';
import 'package:learn2drive/screens/dashboard/dashboard_screen.dart';

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
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.height / 5,
                    child: Image.asset(
                        MediaQuery.of(context).platformBrightness ==
                                Brightness.dark
                            ? 'assets/logoDark.png'
                            : 'assets/logoLight.png'),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Learn2Drive",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "To get started, please sign in!",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SignInButton(
                    MediaQuery.of(context).platformBrightness == Brightness.dark
                        ? Buttons.GoogleDark
                        : Buttons.Google,
                    onPressed: () {
                      signInWithGoogle().then((result) {
                        if (result != null) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) {
                                return FixDocs();
                              },
                            ),
                          );
                        }
                      });
                    },
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
