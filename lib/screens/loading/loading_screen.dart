import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              'Loading...',
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
