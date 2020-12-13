import 'package:flutter/material.dart';
import 'package:learn2drive/screens/auth/auth.dart';
import 'package:learn2drive/screens/auth/auth_screen.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Learn2Drive",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: <Widget>[
          DropdownButton(
            icon: Padding(
              padding: EdgeInsets.only(top: 8, right: 8),
              child: CircleAvatar(
                backgroundImage: NetworkImage(getImageURL()),
              ),
            ),
            items: [
              DropdownMenuItem(
                value: "logout",
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8),
                      Text("Log out")
                    ],
                  ),
                ),
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == "logout") {
                signOutGoogle();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return AuthScreen();
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
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
                children: <Widget>[Text("Logged In")],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
