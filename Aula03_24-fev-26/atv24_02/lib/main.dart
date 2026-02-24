import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(home: PaginaContador()));
}

class PaginaContador extends StatefulWidget {
  @override
  _PaginaContadorState createState() => _PaginaContadorState();
}

class _PaginaContadorState extends State<PaginaContador> {

  int contador = 0;
  Random random = Random();

  void gerarNumero() {
    setState(() {
      contador = random.nextInt(11);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gerador de Nº Aleatório")),
      body: Center(
        child: Text(
          "Número: $contador",
          style: TextStyle(fontSize: 30.0),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: gerarNumero,
        child: Icon(Icons.casino),
      ),
    );
  }
}