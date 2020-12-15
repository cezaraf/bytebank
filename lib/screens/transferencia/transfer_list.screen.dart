import 'package:bytebank/models/transfer.model.dart';
import 'package:bytebank/screens/transferencia/transfer_form.screen.dart';
import 'package:flutter/material.dart';

const _appBarTitle = 'Transferências';

class ListaTransferencias extends StatefulWidget {
  final List<Transfer> _transferencias = List();

  @override
  State<StatefulWidget> createState() {
    return _ListaTransferenciaState();
  }
}

class _ListaTransferenciaState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: ListView.builder(
        itemCount: this.widget._transferencias.length,
        itemBuilder: (context, index) {
          return ItemTransferencia(
            key: UniqueKey(),
            transferencia: this.widget._transferencias[index],
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
        this.widget._transferencias.add(value);
      }
    });
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transfer transferencia;

  const ItemTransferencia({Key key, this.transferencia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(this.transferencia.value.toString()),
        subtitle: Text(this.transferencia.accountNumber?.toString()),
      ),
    );
  }
}
