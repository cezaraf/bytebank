import 'package:bytebank/models/transferencia.model.dart';
import 'package:bytebank/screens/transferencia/formulario.screen.dart';
import 'package:flutter/material.dart';

const _appBarTitle = 'Transferências';

class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> _transferencias = List();

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
              return FormularioTransferencia();
            }),
          ).then((value) => _atualizarLista(value));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _atualizarLista(Transferencia value) {
    this.setState(() {
      if (value != null) {
        this.widget._transferencias.add(value);
      }
    });
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia transferencia;

  const ItemTransferencia({Key key, this.transferencia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(this.transferencia.valor.toString()),
        subtitle: Text(this.transferencia.numeroConta?.toString()),
      ),
    );
  }
}
