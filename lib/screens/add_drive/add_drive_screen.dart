import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';

import 'package:learn2drive/default_app_bar.dart';
import 'package:learn2drive/models/drive.dart';
import 'package:learn2drive/screens/auth/auth.dart';
import 'package:learn2drive/screens/dashboard/dashboard_screen.dart';
import 'package:learn2drive/screens/loading/loading_screen.dart';

class AddDrive extends StatefulWidget {
  @override
  _AddDriveState createState() => _AddDriveState();
}

class _AddDriveState extends State<AddDrive> {
  double _minutesDriven;
  double _minutesDrivenNight;
  double _milesDriven;
  String _skillsWorkedOn;
  DateTime _date;

  @override
  Widget build(BuildContext context) {
    void _onSubmit() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return Loading();
          },
        ),
      );
      Drive drive = Drive(
        minutesDriven: _minutesDriven,
        minutesDrivenNight: _minutesDrivenNight,
        milesDriven: _milesDriven,
        skillsWorkedOn: _skillsWorkedOn,
        date: _date,
      );
      try {
        FirebaseFirestore.instance
            .collection("users")
            .doc(getUID())
            .collection("drives")
            .doc()
            .set(drive.toJson());
      } catch (e) {
        print(e.toString());
      }
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return DashboardScreen();
          },
        ),
      );
    }

    return Scaffold(
      appBar: DefaultAppBar(context),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Text(_date == null
                      ? "Pick a date: "
                      : DateFormat.yMMMMd("en_US").format(_date)),
                  RaisedButton(
                      child: Text('Pick a Date'),
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2019),
                                lastDate: DateTime(2024))
                            .then(
                          (d) {
                            setState(() => _date = d);
                          },
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Minutes Driven'),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) =>
                          _minutesDriven = double.parse(value),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      decoration:
                          InputDecoration(labelText: 'Minutes Driven at Night'),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) =>
                          _minutesDrivenNight = double.parse(value),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Miles Driven'),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) => _milesDriven = double.parse(value),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      decoration:
                          InputDecoration(labelText: 'Skills Worked On'),
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        FilteringTextInputFormatter.singleLineFormatter
                      ],
                      onChanged: (value) => _skillsWorkedOn = value,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  RaisedButton(
                    onPressed: _onSubmit,
                    child: Text('Submit'),
                    elevation: 8,
                  ),
                  SizedBox(
                    height: 20,
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
