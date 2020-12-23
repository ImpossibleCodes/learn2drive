import "package:flutter/material.dart";
import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'package:learn2drive/default_app_bar.dart';
import 'package:learn2drive/models/drive.dart';
import 'package:learn2drive/screens/auth/auth.dart';

class EditDrive extends StatefulWidget {
  final Drive drive;

  EditDrive(this.drive);

  @override
  _EditDriveState createState() => _EditDriveState();
}

class _EditDriveState extends State<EditDrive> {
  final _formKey = GlobalKey<FormState>();
  String _id;
  DateTime _date;
  String _skills;
  double _minutesDriven;
  double _milesDriven;
  double _minutesDrivenNight;
  String _comments;

  void _onEditComplete() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
      Drive drive = Drive(
        id: _id,
        date: _date,
        skills: _skills,
        minutesDriven: _minutesDriven,
        milesDriven: _milesDriven,
        minutesDrivenNight: _minutesDrivenNight,
        comments: _comments,
      );
      try {
        FirebaseFirestore.instance
            .collection("users")
            .doc(getUID())
            .collection("drives")
            .doc(_id)
            .set(drive.toJson());
      } catch (e) {
        print(e.toString());
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    _id = widget.drive.id;
    _date = widget.drive.date;
    _skills = widget.drive.skills;
    _minutesDriven = widget.drive.minutesDriven;
    _milesDriven = widget.drive.milesDriven;
    _minutesDrivenNight = widget.drive.minutesDrivenNight;
    _comments = widget.drive.comments;

    return Scaffold(
      appBar: DefaultAppBar(context),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              key: ValueKey('date'),
                              initialValue:
                                  DateFormat.yMMMMd("en_US").format(_date),
                              validator: (value) {
                                if (_date == null) return "Select a date!";
                                return null;
                              },
                              autocorrect: false,
                              enabled: false,
                              enableSuggestions: false,
                              keyboardType: TextInputType.datetime,
                              textCapitalization: TextCapitalization.none,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          IconButton(
                            icon: Icon(Icons.insert_invitation),
                            onPressed: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: _date,
                                      firstDate: DateTime(2016),
                                      lastDate: DateTime.now())
                                  .then(
                                (d) {
                                  setState(() => _date = d);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: TextFormField(
                              key: ValueKey('skills'),
                              decoration: InputDecoration(
                                labelText: 'Skills',
                              ),
                              initialValue: _skills,
                              validator: (value) {
                                if (_skills == null)
                                  return "Enter skills worked on!";
                                return null;
                              },
                              onChanged: (value) => _skills = value,
                              autocorrect: false,
                              enabled: true,
                              enableSuggestions: true,
                              inputFormatters: [
                                FilteringTextInputFormatter.singleLineFormatter,
                              ],
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.none,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Flexible(
                            flex: 1,
                            child: TextFormField(
                              key: ValueKey('minutes-driven'),
                              decoration: InputDecoration(
                                labelText: 'Minutes Driven',
                              ),
                              initialValue: _minutesDriven.toString(),
                              validator: (value) {
                                if (_minutesDriven == null)
                                  return "Enter the # of minutes!";
                                return null;
                              },
                              onChanged: (value) =>
                                  _minutesDriven = double.parse(value),
                              autocorrect: false,
                              enabled: true,
                              enableSuggestions: false,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: TextInputType.number,
                              textCapitalization: TextCapitalization.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: TextFormField(
                              key: ValueKey('miles-driven'),
                              decoration: InputDecoration(
                                labelText: 'Miles Driven',
                              ),
                              initialValue: _milesDriven.toString(),
                              validator: (value) {
                                if (_milesDriven == null)
                                  return "Enter the # of miles driven!";
                                return null;
                              },
                              onChanged: (value) =>
                                  _milesDriven = double.parse(value),
                              autocorrect: false,
                              enabled: true,
                              enableSuggestions: false,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: TextInputType.number,
                              textCapitalization: TextCapitalization.none,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Flexible(
                            flex: 1,
                            child: TextFormField(
                              key: ValueKey('minutes-driven-at-night'),
                              decoration: InputDecoration(
                                labelText: 'Minutes at Night',
                              ),
                              initialValue: _minutesDrivenNight.toString(),
                              validator: (value) {
                                if (_minutesDrivenNight == null)
                                  return "Enter the # of minutes!";
                                else if (_minutesDrivenNight > _minutesDriven)
                                  return "Enter a valid # of minutes!";
                                return null;
                              },
                              onChanged: (value) =>
                                  _minutesDrivenNight = double.parse(value),
                              autocorrect: false,
                              enabled: true,
                              enableSuggestions: false,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: TextInputType.number,
                              textCapitalization: TextCapitalization.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TextFormField(
                        key: ValueKey('comments'),
                        decoration: InputDecoration(
                          labelText: "Comments",
                        ),
                        initialValue: _comments,
                        onChanged: (value) => _comments = value,
                        autocorrect: true,
                        enabled: true,
                        enableSuggestions: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.singleLineFormatter,
                        ],
                        keyboardType: TextInputType.multiline,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                    RaisedButton(
                      onPressed: _onEditComplete,
                      child: Text('Save Drive'),
                      elevation: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
