import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Overview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CircularPercentIndicator(
                  radius: MediaQuery.of(context).size.width / 3,
                  animation: true,
                  animationDuration: 1200,
                  lineWidth: MediaQuery.of(context).size.width / (3 * 8),
                  percent: 18 / 45,
                  center: Text(
                    "18/45",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / (3 * 6)),
                  ),
                  footer: Text(
                    "Total Hours",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / (3 * 6),
                    ),
                  ),
                  circularStrokeCap: CircularStrokeCap.butt,
                ),
                CircularPercentIndicator(
                  radius: MediaQuery.of(context).size.width / 3,
                  animation: true,
                  animationDuration: 1200,
                  lineWidth: MediaQuery.of(context).size.width / (3 * 8),
                  percent: 8 / 15,
                  center: Text(
                    "8/15",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / (3 * 6)),
                  ),
                  footer: Text(
                    "Night Hours",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / (3 * 6),
                    ),
                  ),
                  circularStrokeCap: CircularStrokeCap.butt,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
