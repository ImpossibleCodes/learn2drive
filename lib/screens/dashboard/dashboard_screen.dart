import 'package:flutter/material.dart';

import 'package:learn2drive/default_app_bar.dart';
import 'package:learn2drive/screens/add_drive/add_drive_button.dart';
import 'package:learn2drive/screens/dashboard/drives_list.dart';
import 'package:learn2drive/screens/dashboard/overview_widget.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Overview(),
            DrivesList(),
          ],
        ),
      ),
      floatingActionButton: AddDriveButton(),
    );
  }
}
