import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TemperaturaApp(), // Passo 2: Completa com o nome da classe
  ));
}

// Passo 2: StatefulWidget pois a temperatura vai mudar na tela
class TemperaturaApp extends StatefulWidget {
  @override
  _TemperaturaAppState createState() => _TemperaturaAppState();
}

class _TemperaturaAppState extends State<TemperaturaApp> {
  int temperatura = 20;

  // Passo 3: Função para aumentar
  void aumentar() {
    setState(() {
      temperatura++;
    });
  }

  // Passo 4: Função para diminuir
  void diminuir() {
    setState(() {
      temperatura--;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Passo 6: Lógica de definição visual
    Color corFundo;
    IconData icone;
    String status;

    if (temperatura < 15) {
      corFundo = Colors.blue;
      icone = Icons.ac_unit;
      status = "Frio";
    } else if (temperatura < 30) {
      corFundo = Colors.green;
      icone = Icons.wb_cloudy; // Agradável
      status = "Agradável";
    } else {
      corFundo = Colors.red;
      icone = Icons.local_fire_department;
      status = "Quente";
    }

    return Scaffold(
      backgroundColor: corFundo, // Passo 7: Cor dinâmica
      appBar: AppBar(
        title: Text("Controle de Temperatura"),
        backgroundColor: Colors.black26,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icone, size: 100, color: Colors.white), // Passo 7: Ícone dinâmico
            Text(
              status,
              style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              "$temperatura °C",
              style: TextStyle(fontSize: 60, color: Colors.white, fontWeight: FontWeight.w900),
            ),
            SizedBox(height: 40),
            // Passo 5: Botões de controle
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: diminuir,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white24),
                  child: Text("-", style: TextStyle(fontSize: 30, color: Colors.white)),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: aumentar,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white24),
                  child: Text("+", style: TextStyle(fontSize: 30, color: Colors.white)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}