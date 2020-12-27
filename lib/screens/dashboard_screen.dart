import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:learn2drive/widgets/default_app_bar.dart';
import 'package:learn2drive/widgets/drive/add_drive_button.dart';
import 'package:learn2drive/services/auth.dart';
import 'package:learn2drive/widgets/drive/drives_list.dart';
import 'package:learn2drive/widgets/overview_widget.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(context),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(
                    'users',
                  )
                  .doc(
                    getUID(),
                  )
                  .collection(
                    'drives',
                  )
                  .orderBy(
                    'date',
                    descending: true,
                  )
                  .snapshots(),
              builder: (ctx, drivesSnapshot) {
                if (drivesSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final drives = drivesSnapshot.data.documents;
                double totalMinutes = 0;
                double totalNightMinutes = 0;
                double totalMiles = 0;
                for (var i = 0; i < drives.length; i++) {
                  totalMinutes += drives[i].data()['minutes-driven'] as double;
                  totalNightMinutes +=
                      drives[i].data()['minutes-driven-at-night'] as double;
                  totalMiles += drives[i].data()['miles-driven'] as double;
                }
                return Overview(totalMinutes, totalNightMinutes, totalMiles);
              },
            ),
            Expanded(
              child: DrivesList(),
            ),
          ],
        ),
      ),
      floatingActionButton: AddDriveButton(),
    );
  }
}
