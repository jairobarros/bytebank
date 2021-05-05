import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: FormularioTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumero =
      new TextEditingController();
  final TextEditingController _controladorCampoConta =
      new TextEditingController();

  void _criaTransferencia() {
    debugPrint('Clicou aqui');
    debugPrint('Número ' + _controladorCampoNumero.text);
    debugPrint('Valor ' + _controladorCampoConta.text);
    double _valor = double.tryParse(_controladorCampoNumero.text);
    int _numeroConta = int.tryParse(_controladorCampoConta.text);

    if (_valor != null && _numeroConta != null) {
      final Transferencia transferencia = Transferencia(_valor, _numeroConta);
      debugPrint('Transferência criada: $transferencia');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Criando Transferência'),
          leading: Icon(Icons.account_balance),
        ),
        body: Column(
          children: <Widget>[
            CampoTexto(
              'Numero da Conta',
              '0000',
              _controladorCampoNumero,
            ),
            CampoTexto(
              'Valor',
              '0.00',
              _controladorCampoConta,
              icone: Icons.monetization_on,
            ),
            ElevatedButton(
              onPressed: () => _criaTransferencia(),
              child: Text('Confirmar'),
            )
          ],
        ));
  }
}

class CampoTexto extends StatelessWidget {
  TextEditingController _controlador;
  String _rotulo;
  String _dica;
  IconData icone;

  CampoTexto(this._rotulo, this._dica, this._controlador, {this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: TextField(
        keyboardType: TextInputType.number,
        controller: this._controlador,
        style: TextStyle(fontSize: 16),
        decoration: InputDecoration(
          labelText: _rotulo,
          hintText: _dica,
          icon: icone != null ? Icon(icone) : null,
        ),
      ),
    );
  }
}

class Transferencia {
  final double _valor;
  final int _numeroConta;
  Transferencia(this._valor, this._numeroConta);

  get valor {
    return _valor;
  }

  get numeroConta {
    return _numeroConta;
  }

  String toString() {
    return 'Transferência valor: $_valor, Conta: $_numeroConta';
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Card(
        child: ListTile(
          leading: Icon(Icons.monetization_on),
          title: Text(_transferencia.valor.toString()),
          subtitle: Text(_transferencia.numeroConta.toString()),
        ),
      ),
    ]);
  }
}

class ListaTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Transferências'),
          backgroundColor: Colors.green,
        ),
        body: Column(
          children: <Widget>[
            ItemTransferencia(Transferencia(101.0, 1000)),
            ItemTransferencia(Transferencia(250.0, 2000)),
            ItemTransferencia(Transferencia(300.0, 3000)),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          backgroundColor: Colors.green,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
