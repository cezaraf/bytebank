import 'dart:async';

import 'package:bytebank/components/progress.component.dart';
import 'package:bytebank/components/response_dialog.component.dart';
import 'package:bytebank/components/transaction_auth_dialog.component.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/models/contact.model.dart';
import 'package:bytebank/models/transaction.model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();
  final String transactionId = Uuid().v4();

  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Progress(
                    message: 'Sending',
                  ),
                ),
                visible: _sending,
              ),
              Text(
                widget.contact.fullName,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('Transfer'),
                    onPressed: () {
                      final double value = double.tryParse(_valueController.text);
                      final transactionCreated = Transaction(this.transactionId, value, widget.contact);
                      showDialog(
                        context: context,
                        builder: (contextDialog) {
                          return TransactionDialogAuth(
                            onConfirm: (password) {
                              this._save(transactionCreated, password, context);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _save(Transaction transactionCreated, String password, BuildContext context) async {
    try {
      setState(() => this._sending = true);
      final Transaction transaction = await this._webClient.save(transactionCreated, password).whenComplete(() => setState(() => this._sending = false));
      if (transaction != null) {
        await showDialog(context: context, builder: (contextDialog) => SuccessDialog('successful transaction!'));
        Navigator.of(context).pop(transaction);
      }
    } on TimeoutException catch (e) {
      _showFailureDialog(context, 'timeout submitting the transaction');
    } on HttpException catch (e) {
      _showFailureDialog(context, e.message);
    } catch (e) {
      _showFailureDialog(context, 'Unkown error');
    }
  }

  _showFailureDialog(BuildContext context, String message) => showDialog(context: context, builder: (contextDialog) => FailureDialog(message));
}
