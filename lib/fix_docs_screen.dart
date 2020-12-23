import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn2drive/screens/auth/auth.dart';
import 'package:learn2drive/screens/dashboard/dashboard_screen.dart';

class FixDocs extends StatelessWidget {
  void _addIDs(ctx) {
    final collectionRef = FirebaseFirestore.instance
        .collection(
          'users',
        )
        .doc(
          getUID(),
        )
        .collection(
          'drives',
        );
    collectionRef.snapshots().forEach(
      (c) {
        c.docs.forEach(
          (doc) {
            var id = doc.id;
            collectionRef.doc(id).update({'id': id});
            print(id);
          },
        );
      },
    );
    Navigator.of(ctx).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return DashboardScreen();
        },
      ),
    );
  }

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
              child: RaisedButton(
                onPressed: () => _addIDs(context),
                child: Text("Add IDs"),
                elevation: 8,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
