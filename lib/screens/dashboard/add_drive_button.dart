import 'package:flutter/material.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:learn2drive/screens/dashboard/add_drive_screen.dart';

class AddDriveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.add_event,
      overlayColor: Theme.of(context).dialogBackgroundColor,
      children: [
        SpeedDialChild(
          child: Icon(Icons.add),
          label: "Add Drive",
          labelBackgroundColor: Theme.of(context).backgroundColor,
          onTap: () {
            print("Adding Drive...");
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return AddDrive();
                },
              ),
            );
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.drive_eta),
          label: "Track Drive",
          labelBackgroundColor: Theme.of(context).backgroundColor,
          onTap: () {
            print("Tracking Drive...");
          },
        )
      ],
    );
  }
}
