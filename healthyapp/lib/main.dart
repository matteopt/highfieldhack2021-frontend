import 'package:flutter/material.dart';
import 'package:healthyapp/home.dart';
import 'package:healthyapp/leaderboard.dart';
import 'package:healthyapp/login.dart';
import 'package:healthyapp/progress.dart';

void main() {
  runApp(HealthyApp());
}

class HealthyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Healthy App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LeaderboardPage()
      );
  }
}
