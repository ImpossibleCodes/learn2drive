import 'package:flutter/material.dart';
import 'package:learn2drive/models/drive.dart';

import 'package:learn2drive/screens/auth/auth.dart';
import 'package:learn2drive/screens/auth/auth_screen.dart';
import 'package:learn2drive/screens/dashboard/add_drive_button.dart';
import 'package:learn2drive/screens/dashboard/drive_widget.dart';
import 'package:learn2drive/screens/dashboard/overview_widget.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Overview(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DriveWidget(
                  Drive(
                    minutesDriven: 90,
                    minutesDrivenNight: 30,
                    milesDriven: 10,
                    skillsWorkedOn: "parking",
                    date: DateTime.now(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: AddDriveButton(),
    );
  }
}
