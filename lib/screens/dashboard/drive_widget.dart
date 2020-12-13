import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:learn2drive/models/drive.dart';

class DriveWidget extends StatelessWidget {
  final Drive drive;

  DriveWidget(this.drive);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Center(
        child: Card(
          margin: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Column(
                        children: [
                          Text(
                            (drive.minutesDriven / 60).toStringAsFixed(1),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width / 9,
                            ),
                          ),
                          Text(
                            'Hours\nDriven',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: MediaQuery.of(context).size.width /
                                  (6 * 4 + 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Column(
                        children: [
                          Text(
                            (drive.minutesDrivenNight / 60).toStringAsFixed(1),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width / 9,
                            ),
                          ),
                          Text(
                            'Hours\nat Night',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: MediaQuery.of(context).size.width /
                                  (6 * 4 + 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Column(
                        children: [
                          Text(
                            (drive.milesDriven).toStringAsFixed(1),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width / 9,
                            ),
                          ),
                          Text(
                            'Miles\nDriven',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: MediaQuery.of(context).size.width /
                                  (6 * 4 + 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Text(
                  DateFormat.yMMMMd("en_US").format(drive.date),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width / (6 * 5 + 1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
