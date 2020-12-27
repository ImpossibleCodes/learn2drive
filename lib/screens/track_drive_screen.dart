import 'package:flutter/material.dart';

import 'package:learn2drive/widgets/default_app_bar.dart';

class TrackDriveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(context),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: double.infinity,
            color: Colors.blue,
          ),
          Expanded(
            child: Container(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
