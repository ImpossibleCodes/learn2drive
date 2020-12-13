import 'package:flutter/material.dart';

import 'package:learn2drive/screens/auth/auth_screen.dart';
import 'package:learn2drive/screens/loading/loading_screen.dart';

import 'package:learn2drive/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '45 Hours',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: Loading(),
    );
  }
}