import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final Icon icon;

  const Editor({Key key, this.controller, this.label, this.hint, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: this.controller,
        style: TextStyle(
          fontSize: 16.0,
        ),
        decoration: InputDecoration(
          labelText: this.label,
          hintText: this.hint,
          icon: this.icon,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
