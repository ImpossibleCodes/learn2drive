import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:learn2drive/services/drive.dart';
import 'package:learn2drive/screens/edit_drive_screen.dart';

class DriveWidget extends StatefulWidget {
  final Drive drive;

  DriveWidget(this.drive);

  @override
  _DriveWidgetState createState() => _DriveWidgetState();
}

class _DriveWidgetState extends State<DriveWidget> {
  bool _isFullView = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: () {
            setState(
              () {
                _isFullView = !_isFullView;
              },
            );
          },
          onLongPress: () {
            setState(
              () {
                _isFullView = false;
              },
            );
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return EditDriveScreen(widget.drive);
                },
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
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
                            (widget.drive.minutesDriven / 60)
                                .toStringAsFixed(1),
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
                            (widget.drive.minutesDrivenNight / 60)
                                .toStringAsFixed(1),
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
                            (widget.drive.milesDriven).toStringAsFixed(1),
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
                if (_isFullView && widget.drive.skills != null)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Skills: ',
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width /
                                  (6 * 4 + 1),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              widget.drive.skills,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: MediaQuery.of(context).size.width /
                                    (6 * 4 + 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (_isFullView && widget.drive.comments != null)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Comments: ',
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width /
                                  (6 * 4 + 1),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              widget.drive.comments,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: MediaQuery.of(context).size.width /
                                    (6 * 4 + 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: Text(
                    DateFormat.yMMMMd("en_US").format(widget.drive.date),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / (6 * 5 + 1),
                    ),
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
