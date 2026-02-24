import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: PaginaContador()));
}

class PaginaContador extends StatefulWidget {
  @override
  _PaginaContadorState createState() => _PaginaContadorState();
}

class _PaginaContadorState extends State<PaginaContador> {
  int contador = 0;

  void increment(){
    setState((){
      contador++;

    });
  }

  void decrement(){
    setState((){
      contador--;

    });
  }

  void reset(){
    setState((){
      contador = 0;

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(title: Text("Meu App Interativo")),
      body: Center(
        child: Text("Contador: $contador", 
        style: TextStyle(fontSize: 24.0))
      ),

      floatingActionButton: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
      FloatingActionButton(
      onPressed: increment,
      child: Icon(Icons.add),
      ),
      
      SizedBox(width: 10.0), // Espaçamento entre os botões
      FloatingActionButton(
      onPressed: decrement,
      child: Icon(Icons.remove),
        
      ),
      SizedBox(width: 10.0), // Espaçamento entre os botões
      FloatingActionButton(
      onPressed: reset,
      child: Icon(Icons.refresh),
      ), // FloatingActionButton
      ], // Children      
      ), // Row
    ); // Scaffold
  }

}