import 'package:bytebank/components/editor.dart';
import 'package:bytebank/dao/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatelessWidget {
  final ContactDao _dao = ContactDao();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Editor(
              label: 'Full name',
              controller: this._fullNameController,
            ),
            Editor(
              label: 'Account number',
              controller: this._accountNumberController,
              textInputType: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: RaisedButton(
                  child: Text('Create'),
                  onPressed: () {
                    final String fullName = this._fullNameController.text;
                    final int accountNumber = int.tryParse(this._accountNumberController.text);
                    if (fullName != null && accountNumber != null) {
                      this._dao.save(Contact(0, fullName, accountNumber)).then((value) => Navigator.pop(context));
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
