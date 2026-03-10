import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HumorApp()),
  );
}

class HumorApp extends StatefulWidget {
  @override
  _HumorAppState createState() => _HumorAppState();
}

class _HumorAppState extends State<HumorApp> {
  
  // Estados de humor: 0 = neutro, 1 = feliz, 2 = bravo
  int humorAtual = 0;

  void alternarHumor() {
    setState(() {
      // Avança para o próximo humor (0 -> 1 -> 2 -> 0)
      humorAtual = (humorAtual + 1) % 3;
    });
  }

  // Função para obter o ícone baseado no humor atual
  IconData getIcon() {
    switch(humorAtual) {
      case 0: // Neutro
        return Icons.sentiment_neutral;
      case 1: // Feliz
        return Icons.sentiment_satisfied;
      case 2: // Bravo
        return Icons.sentiment_very_dissatisfied;
      default:
        return Icons.sentiment_neutral;
    }
  }

  // Função para obter a cor baseada no humor atual
  Color getBackgroundColor() {
    switch(humorAtual) {
      case 0: // Neutro
        return Colors.grey.shade300;
      case 1: // Feliz
        return Colors.yellow.shade100;
      case 2: // Bravo
        return Colors.red.shade100;
      default:
        return Colors.grey.shade300;
    }
  }

  // Função para obter a cor do ícone baseada no humor atual
  Color getIconColor() {
    switch(humorAtual) {
      case 0: // Neutro
        return Colors.grey.shade700;
      case 1: // Feliz
        return Colors.amber.shade800;
      case 2: // Bravo
        return Colors.red.shade900;
      default:
        return Colors.grey.shade700;
    }
  }

  // Função para obter o texto do humor atual
  String getHumorText() {
    switch(humorAtual) {
      case 0:
        return "Neutro";
      case 1:
        return "Feliz";
      case 2:
        return "Bravo";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColor(),

      appBar: AppBar(
        backgroundColor: getBackgroundColor(),
        // elevation: 40, // Remove a sombra da AppBar
        title: Text(
          "App de Humor", 
          style: TextStyle(
            color: getIconColor(),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ícone de humor
            Icon(
              getIcon(),
              size: 150,
              color: getIconColor(),
            ),

            SizedBox(height: 20),

            // Texto do humor atual
            Text(
              getHumorText(),
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: getIconColor(),
              ),
            ),

            SizedBox(height: 40),

            // Botão para alternar humor
            ElevatedButton(
              onPressed: alternarHumor,
              style: ElevatedButton.styleFrom(
                backgroundColor: getIconColor(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                "Mudar Humor",
                style: TextStyle(
                  fontSize: 20,
                  color: getBackgroundColor(),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 20),

            // Instrução
            Text(
              "Clique no botão para alternar\nentre os humores",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: getIconColor(),
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}