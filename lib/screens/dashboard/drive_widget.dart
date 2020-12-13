import 'package:flutter/material.dart';

import 'package:learn2drive/models/drive.dart';

class DriveWidget extends StatelessWidget {
  Drive drive;

  DriveWidget(this.drive);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                decoration:
                    InputDecoration(hintText: "Test", border: InputBorder.none),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
