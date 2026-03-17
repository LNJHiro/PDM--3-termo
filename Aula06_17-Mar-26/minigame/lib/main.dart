import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: JogoApp(),
  ));
}

class JogoApp extends StatefulWidget {
  // Adicionado o construtor com key para remover o aviso azul da sua imagem
  const JogoApp({super.key});

  @override
  State<JogoApp> createState() => _JogoAppState();
}

class _JogoAppState extends State<JogoApp> {
  // Variáveis do jogo
  IconData iconeComputador = Icons.help_outline;
  String resultado = "Escolha uma opção para começar";
  int pontosJogador = 0;
  int pontosComputador = 0;
  
  final List<String> opcoes = ["pedra", "papel", "tesoura"];

  void jogar(String escolhaUsuario) {
    var numero = Random().nextInt(3);
    var escolhaComputador = opcoes[numero];

    setState(() {
      // Atualiza ícone do PC (usando o ! para o grey[800] se necessário)
      if (escolhaComputador == "pedra") {
        iconeComputador = Icons.landscape;
      } else if (escolhaComputador == "papel") {
        iconeComputador = Icons.pan_tool;
      } else {
        iconeComputador = Icons.content_cut;
      }

      // Lógica de disputa
      if (escolhaUsuario == escolhaComputador) {
        resultado = "Empate!";
      } else if (
        (escolhaUsuario == "pedra" && escolhaComputador == "tesoura") ||
        (escolhaUsuario == "papel" && escolhaComputador == "pedra") ||
        (escolhaUsuario == "tesoura" && escolhaComputador == "papel")
      ) {
        pontosJogador++;
        resultado = "Você venceu!";
      } else {
        pontosComputador++;
        resultado = "Computador venceu!";
      }

      // Regra do Campeonato (Reseta ao chegar em 5)
      if (pontosJogador == 5) {
        resultado = "🏆 Parabéns! Você ganhou o campeonato!";
        _resetarTudo();
      } else if (pontosComputador == 5) {
        resultado = "💻 Que pena! O PC ganhou o campeonato!";
        _resetarTudo();
      }
    });
  }

  void _resetarTudo() {
    pontosJogador = 0;
    pontosComputador = 0;
  }

  void resetarBotao() {
    setState(() {
      _resetarTudo();
      resultado = "Placar zerado!";
      iconeComputador = Icons.help_outline;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pedra Papel Tesoura"),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Escolha do Computador", style: TextStyle(fontSize: 18)),
            Icon(iconeComputador, size: 100, color: Colors.blueGrey),
            const SizedBox(height: 30),
            Text(
              resultado,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              "Você: $pontosJogador | PC: $pontosComputador",
              style: const TextStyle(fontSize: 20, color: Colors.blue),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _botaoOpcao("pedra", Icons.landscape, Colors.brown),
                const SizedBox(width: 15),
                _botaoOpcao("papel", Icons.pan_tool, Colors.blue),
                const SizedBox(width: 15),
                _botaoOpcao("tesoura", Icons.content_cut, Colors.red),
              ],
            ),
            const SizedBox(height: 50),
            ElevatedButton.icon(
              onPressed: resetarBotao,
              icon: const Icon(Icons.refresh),
              label: const Text("Resetar Placar"),
            )
          ],
        ),
      ),
    );
  }

  // Função auxiliar para criar os botões redondos
  Widget _botaoOpcao(String escolha, IconData icone, Color cor) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => jogar(escolha),
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
            backgroundColor: cor.withOpacity(0.2),
            foregroundColor: cor,
            elevation: 0,
          ),
          child: Icon(icone, size: 40),
        ),
        const SizedBox(height: 8),
        Text(escolha.toUpperCase(), style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}