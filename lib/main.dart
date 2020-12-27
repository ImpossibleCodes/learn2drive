import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:learn2drive/services/theme.dart';
import 'package:learn2drive/services/auth.dart';
import 'package:learn2drive/screens/auth_screen.dart';
import 'package:learn2drive/screens/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TicTacToe',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: isLoggedIn() ? DashboardScreen() : AuthScreen(),
    );
  }
}
