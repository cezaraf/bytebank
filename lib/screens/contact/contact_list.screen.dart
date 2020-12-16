import 'package:bytebank/dao/contact.dao.dart';
import 'package:bytebank/models/contact.model.dart';
import 'package:bytebank/screens/contact/contact_form.screen.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {
  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer'),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: List(),
        future: this._dao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text('Loading'),
                  ],
                ),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              return ListView.builder(
                itemBuilder: (context, position) => _ContactItem(contact: snapshot.data[position]),
                itemCount: snapshot.data.length,
              );
              break;
          }
          return Text('Unkown error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ContactForm())).then((value) => setState(() {}));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;

  const _ContactItem({Key key, this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          this.contact.fullName,
          style: TextStyle(fontSize: 24),
        ),
        subtitle: Text(
          this.contact.accountNumber.toString(),
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
