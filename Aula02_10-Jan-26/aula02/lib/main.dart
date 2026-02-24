import 'package:flutter/material.dart';

void main() {
  runApp(meuapp());
}

class meuapp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.grey,
          appBar: AppBar(
          title: Text('Lista de Tarefas', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
         ),
        body: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.radio_button_unchecked),
              title: Text('Estudar Flutter'),
              trailing: Icon(Icons.delete),
              textColor: (Colors.white),
              ),

            ListTile(
              leading: Icon(Icons.radio_button_unchecked),
              title: Text('Praticar Dart'),
              trailing: Icon(Icons.delete),
              textColor: (Colors.white),
              ),
            ListTile(
              leading: Icon(Icons.radio_button_unchecked),
              title: Text('Criar um App'),
              trailing: Icon(Icons.delete),
              textColor: (Colors.white),
              ),
          ],
        ),
        
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Ação para adicionar uma nova tarefa
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.black,

        ),
      )
    );
  } 
}