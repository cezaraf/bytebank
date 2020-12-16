import 'package:bytebank/models/transfer.model.dart';
import 'package:bytebank/screens/transfer/transfer_form.screen.dart';
import 'package:flutter/material.dart';

const _appBarTitle = 'Transferências';

class TransferList extends StatefulWidget {
  final List<Transfer> _transfers = List();

  @override
  State<StatefulWidget> createState() {
    return _TransferListState();
  }
}

class _TransferListState extends State<TransferList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: ListView.builder(
        itemCount: this.widget._transfers.length,
        itemBuilder: (context, index) {
          return TransferItem(
            key: UniqueKey(),
            transfer: this.widget._transfers[index],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return TransferForm();
            }),
          ).then((value) => _atualizarLista(value));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _atualizarLista(Transfer value) {
    this.setState(() {
      if (value != null) {
        this.widget._transfers.add(value);
      }
    });
  }
}

class TransferItem extends StatelessWidget {
  final Transfer transfer;

  const TransferItem({Key key, this.transfer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(this.transfer.value.toString()),
        subtitle: Text(this.transfer.accountNumber?.toString()),
      ),
    );
  }
}
