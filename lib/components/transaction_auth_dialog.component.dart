import 'package:flutter/material.dart';

class TransactionDialogAuth extends StatefulWidget {
  final Function(String password) onConfirm;

  TransactionDialogAuth({this.onConfirm});

  @override
  _TransactionDialogAuthState createState() => _TransactionDialogAuthState();
}

class _TransactionDialogAuthState extends State<TransactionDialogAuth> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Authenticate'),
      content: TextField(
        controller: this._passwordController,
        obscureText: true,
        maxLength: 4,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(border: OutlineInputBorder()),
        style: TextStyle(
          fontSize: 64,
          letterSpacing: 24,
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        FlatButton(
          onPressed: () {
            widget.onConfirm(this._passwordController.text);
            Navigator.of(context).pop();
          },
          child: Text('Confirm'),
        )
      ],
    );
  }
}
