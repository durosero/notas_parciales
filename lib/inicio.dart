import 'package:flutter/material.dart';
import 'dart:math';

class Inicio extends StatefulWidget {
  Inicio({Key key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  TextEditingController p1 = new TextEditingController();
  TextEditingController p2 = new TextEditingController();
  TextEditingController p3 = new TextEditingController();

  double tp1 = 0.0;
  double tp2 = 0.0;
  double tp3 = 0.0;

  double definitiva = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Caca'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              _crearInputs(),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => _mostrarAlert(context),
                      color: Colors.blue,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _crearInputs() {
    return Column(
      children: <Widget>[
        TextField(
            controller: p1,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                hintText: "Nota primer corte",
                labelText: "Parcial 1 - 30%",
                suffixIcon: Icon(Icons.note)),
            keyboardType: TextInputType.number),
        Container(
          height: 10.0,
        ),
        TextField(
            controller: p2,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                hintText: "Nota segundo corte",
                labelText: "Parcial 2 - 30%",
                suffixIcon: Icon(Icons.note)),
            keyboardType: TextInputType.number),
        Container(
          height: 10.0,
        ),
        TextField(
            controller: p3,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                hintText: "Nota segundo corte",
                labelText: "Parcial 3 - 40%",
                suffixIcon: Icon(Icons.note)),
            keyboardType: TextInputType.number),
        Container(
          height: 10.0,
        ),
      ],
    );
  }

  void _mostrarAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (contex) {
          return AlertDialog(
            title: Text("Definitiva: " + calcularDef().toString()),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
              _tabla(),
              Text("Debe sacar: " + calculaFinal(calcularDef()).toString())
            ],),
            actions: <Widget>[
              FlatButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              FlatButton(
                child: Text("Guardar"),
                onPressed: () {},
              )
            ],
          );
        });
  }

  Widget _tabla() {
    calcularDef();
    return DataTable(
      columnSpacing: 30.0,
      columns: <DataColumn>[
        DataColumn(label: Text("Parcial"), numeric: true),
        DataColumn(label: Text("%")),
        DataColumn(label: Text("Valor")),
      ],
      rows: <DataRow>[
        DataRow(cells: [
          DataCell(Text(p1.text)),
          DataCell(Text("30%")),
          DataCell(Text("$tp1"))
        ]),
        DataRow(cells: [
          DataCell(Text(p2.text)),
          DataCell(Text("30%")),
          DataCell(Text("$tp2"))
        ]),
        DataRow(cells: [
          DataCell(Text(p3.text)),
          DataCell(Text("40%")),
          DataCell(Text("$tp3"))
        ]),
      ],
    );
  }

  double calcularDef() {
    p1.text = (p1.text.isEmpty) ? "0.0" : p1.text;
    p2.text = (p2.text.isEmpty) ? "0.0" : p2.text;
    p3.text = (p3.text.isEmpty) ? "0.0" : p3.text;
    tp1 = roundDouble((double.parse(p1.text) * 0.3), 2);
    tp2 = roundDouble((double.parse(p2.text) * 0.3), 2);
    tp3 = roundDouble((double.parse(p3.text) * 0.4), 2);
    return roundDouble((tp1 + tp2 + tp3),2);
  }

  double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }


  double calculaFinal(double def){
    double total = 0.0;
    double aux = 3.0 - def;
    double contador = 0.0;
    while(total<3.0){
      contador = contador + 0.1;
      total = def +(contador*0.4);
    }
    return roundDouble(contador,2);

  }
}
