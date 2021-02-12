import 'package:flutter/material.dart';

void main() {
  runApp(HealthyApp());
}

class HealthyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healthy App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        backgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Healthy App"),
        ),
        body: Container(),
      ),
    );
  }
}