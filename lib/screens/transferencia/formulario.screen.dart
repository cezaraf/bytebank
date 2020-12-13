import 'package:bytebank/components/editor.component.dart';
import 'package:bytebank/models/transferencia.model.dart';
import 'package:flutter/material.dart';

const _appBarTitle = 'Criando transferência';

const _editorLabelNumeroConta = 'Número da conta';
const _editorHintNumeroConta = '0000';

const _editorLabelValor = 'Valor';
const _editorHintValor = '0.00';

const _buttonTextConfirmar = 'Confirmar';

class FormularioTransferencia extends StatefulWidget {
  @override
  _FormularioTransferenciaState createState() => _FormularioTransferenciaState();
}

class _FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controllerNumeroConta = TextEditingController();
  final TextEditingController _controllerValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
              controller: this._controllerNumeroConta,
              label: _editorLabelNumeroConta,
              hint: _editorHintNumeroConta,
            ),
            Editor(
              controller: this._controllerValor,
              label: _editorLabelValor,
              hint: _editorHintValor,
              icon: Icon(Icons.monetization_on),
            ),
            RaisedButton(
              child: Text(_buttonTextConfirmar),
              onPressed: () {
                this._criarTransferencia(context);
              },
            )
          ],
        ),
      ),
    );
  }

  void _criarTransferencia(BuildContext context) {
    final int numeroConta = int.tryParse(this._controllerNumeroConta.text);
    final double valor = double.tryParse(this._controllerValor.text);
    if (numeroConta != null && valor != null) {
      Navigator.pop(context, Transferencia(valor, numeroConta));
    }
  }
}
