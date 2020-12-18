import 'package:bytebank/components/transaction_auth_dialog.component.dart';
import 'package:bytebank/screens/dashboard/dashboard.screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BytebankApp());
}

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.green[900],
          accentColor: Colors.deepPurple[700],
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.deepPurple[700],
            textTheme: ButtonTextTheme.primary,
          )),
      home: Dashboard(),
    );
  }
}
