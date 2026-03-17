import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: SemaforoApp()));
}

class SemaforoApp extends StatefulWidget {
  @override
  _SemaforoAppState createState() => _SemaforoAppState();
}

class _SemaforoAppState extends State<SemaforoApp> {
  int estado = 0; // 0 = Verde, 1 = Amarelo, 2 = Vermelho

  void mudarSemaforo() {
    setState(() {
      estado = (estado + 1) % 3;
    });
  }

  // --- O MÉTODO BUILD DEFINE A INTERFACE ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Semáforo Inteligente"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SEMÁFORO DE CARROS
            Container(
              width: 120,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  _luzSemaforo(estado == 2 ? Colors.red : Colors.grey[800]!),
                  SizedBox(height: 10),
                  _luzSemaforo(estado == 1 ? Colors.yellow : Colors.grey[800]!),
                  SizedBox(height: 10),
                  _luzSemaforo(estado == 0 ? Colors.green : Colors.grey[800]!),
                ],
              ),
            ),
            SizedBox(height: 40),
            // SEMÁFORO DE PEDESTRES
            Column(
              children: [
                Icon(
                  estado == 2 ? Icons.directions_walk : Icons.pan_tool,
                  size: 80,
                  color: estado == 2 ? Colors.green : Colors.red,
                ),
                Text(
                  estado == 2 ? "PEDESTRE: ATRAVESSE" : "PEDESTRE: AGUARDE",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 40),
            // BOTÃO
            ElevatedButton(
              onPressed: mudarSemaforo,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text("Mudar Semáforo", style: TextStyle(fontSize: 18)),
            ),
          ], // Fim dos children da Column
        ),
      ),
    );
  } // Fim do método build

  // --- MÉTODO AUXILIAR (FORA DO BUILD, DENTRO DA CLASS) ---
  Widget _luzSemaforo(Color cor) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: cor,
        shape: BoxShape.circle,
        boxShadow: [
          if (cor != Colors.grey[800])
            BoxShadow(
              color: cor.withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 2,
            ),
        ],
      ),
    );
  }
} // Fim da Classe
