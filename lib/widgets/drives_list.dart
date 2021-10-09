import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:learn2drive/helpers/auth.dart';
import 'package:learn2drive/models/drive.dart';
import 'package:learn2drive/widgets/drive_widget.dart';

class DrivesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
        final drives = drivesSnapshot.data.docs;
        return drives.length == 0
            ? Center(
                child: Card(
                  margin: EdgeInsets.all(24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "No drives added yet, click the + button to add a drive",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: drives.length,
                itemBuilder: (ctx, index) {
                  return DriveWidget(
                    Drive.fromJson(
                        drives[index].data().cast<String, dynamic>()),
                  );
                },
              );
      },
    );
  }
}
