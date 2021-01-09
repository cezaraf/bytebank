import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final Icon icon;
  final TextInputType textInputType;

  const Editor({Key key, this.controller, this.label, this.hint, this.icon, this.textInputType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this.controller,
      style: TextStyle(
        fontSize: 16.0,
      ),
      decoration: InputDecoration(
        labelText: this.label,
        hintText: this.hint,
        icon: this.icon,
      ),
      keyboardType: this.textInputType,
    );
  }
}
