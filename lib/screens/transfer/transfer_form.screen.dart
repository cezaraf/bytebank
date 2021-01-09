import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/transfer.dart';
import 'package:flutter/material.dart';

const _appBarTitle = 'New Transfer';

const _editorLabelAccountNumber = 'Account Number';
const _editorHintAccountNumber = '0000';

const _editorLabelValue = 'Value';
const _editorHintValue = '0.00';

const _buttonConfirmText = 'Confirm';

class TransferForm extends StatefulWidget {
  @override
  _TransferFormState createState() => _TransferFormState();
}

class _TransferFormState extends State<TransferForm> {
  final TextEditingController _controllerAccountNumber = TextEditingController();
  final TextEditingController _controllerValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Editor(
                controller: this._controllerAccountNumber,
                label: _editorLabelAccountNumber,
                hint: _editorHintAccountNumber,
                textInputType: TextInputType.number,
              ),
              Editor(
                controller: this._controllerValue,
                label: _editorLabelValue,
                hint: _editorHintValue,
                textInputType: TextInputType.number,
                icon: Icon(Icons.monetization_on),
              ),
              RaisedButton(
                child: Text(_buttonConfirmText),
                onPressed: () {
                  this._createTransfer(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _createTransfer(BuildContext context) {
    final int accountNumber = int.tryParse(this._controllerAccountNumber.text);
    final double value = double.tryParse(this._controllerValue.text);
    if (accountNumber != null && value != null) {
      Navigator.pop(context, Transfer(value, accountNumber));
    }
  }
}
