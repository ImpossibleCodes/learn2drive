import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Overview extends StatelessWidget {
  final double totalMinutes;
  final double totalNightMinutes;
  final double totalMiles;
  Overview(this.totalMinutes, this.totalNightMinutes, this.totalMiles);
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
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CircularPercentIndicator(
                      radius: MediaQuery.of(context).size.width / 3,
                      animation: true,
                      animationDuration: 1200,
                      lineWidth: MediaQuery.of(context).size.width / (3 * 8),
                      percent: ((totalMinutes / 60) / 45) >= 1
                          ? 1
                          : ((totalMinutes / 60) / 45),
                      center: Text(
                        (totalMinutes / 60).toStringAsFixed(1) + " / 45",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.of(context).size.width / (3 * 6)),
                      ),
                      footer: Text(
                        "Total Hours\nDriven",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
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
                      percent: ((totalNightMinutes / 60) / 45) >= 1
                          ? 1
                          : ((totalNightMinutes / 60) / 45),
                      center: Text(
                        (totalNightMinutes / 60).toStringAsFixed(1) + " / 45",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.of(context).size.width / (3 * 6)),
                      ),
                      footer: Text(
                        "Total Hours\nat Night",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width / (3 * 6),
                        ),
                      ),
                      circularStrokeCap: CircularStrokeCap.butt,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Total Miles Driven: " + totalMiles.toStringAsFixed(1),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width / (3 * 8),
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
