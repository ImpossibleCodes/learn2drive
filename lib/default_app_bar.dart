import 'package:flutter/material.dart';

import 'package:learn2drive/screens/auth/auth.dart';
import 'package:learn2drive/screens/auth/auth_screen.dart';

class DefaultAppBar extends AppBar {
  DefaultAppBar(ctx)
      : super(
          title: Text(
            "Learn2Drive",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          actions: <Widget>[
            DropdownButton(
              underline: SizedBox(),
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
                  signOut(ctx);
                  Navigator.of(ctx).pushReplacement(
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
        );
}
