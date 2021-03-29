import 'package:flutter/material.dart';

class DriveTrackerInfo extends StatelessWidget {
  final int _duration;
  final double _distance;

  DriveTrackerInfo(this._duration, this._distance);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Column(
              children: [
                Text(
                  _duration.toString(),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width / 9,
                  ),
                ),
                Text(
                  'Minutes\nDriven',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: MediaQuery.of(context).size.width / (6 * 4 + 1),
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
                  _duration.toString(),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width / 9,
                  ),
                ),
                Text(
                  'Minutes\nat Night',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: MediaQuery.of(context).size.width / (6 * 4 + 1),
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
                  _distance.toStringAsFixed(1),
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
                    fontSize: MediaQuery.of(context).size.width / (6 * 4 + 1),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
