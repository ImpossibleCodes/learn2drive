import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Loading...',
              style: TextStyle(
                  color: Colors.blueAccent, decoration: TextDecoration.none),
              textAlign: TextAlign.center,
            ),
            SpinKitCircle(
              color: Colors.white,
              size: 70.0,
            ),
            Image.asset('assets/logo.png'),
          ],
        ),
      ),
    );
  }
}
