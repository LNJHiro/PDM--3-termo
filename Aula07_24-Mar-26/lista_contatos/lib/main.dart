import 'package:flutter/material.dart';

void main() {
  runApp(const AppContatos());
}

// ─────────────────────────────────────────────
// Classe raiz do app
// ─────────────────────────────────────────────
class AppContatos extends StatelessWidget {
  const AppContatos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meus Contatos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const TelaListaContatos(), // Tela inicial
    );
  }
}

// ─────────────────────────────────────────────
// Modelo de dados para um Contato
// ─────────────────────────────────────────────
class Contato {
  final String nome;
  final String telefone;
  final IconData icone;
  final Color cor;

  const Contato({
    required this.nome,
    required this.telefone,
    required this.icone,
    required this.cor,
  });
}

// ─────────────────────────────────────────────
// TELA 1 – Lista de Contatos
// ─────────────────────────────────────────────
class TelaListaContatos extends StatelessWidget {
  const TelaListaContatos({super.key});

  // Lista fixa de contatos
  final List<Contato> contatos = const [
    Contato(
      nome: 'Machado de Assis',
      telefone: '(11) 91234-5678',
      icone: Icons.person,
      cor: Colors.teal,
    ),
    Contato(
      nome: 'Lima Barreto',
      telefone: '(21) 98765-4321',
      icone: Icons.person_2,
      cor: Colors.indigo,
    ),
    Contato(
      nome: 'Clarice Lispector',
      telefone: '(31) 99876-5432',
      icone: Icons.person_3,
      cor: Colors.pink,
    ),
    Contato(
      nome: 'Conceição Evaristo',
      telefone: '(41) 97654-3210',
      icone: Icons.person_4,
      cor: Colors.orange,
    ),
    Contato(
      nome: 'José Paulo Paes',
      telefone: '(51) 96543-2109',
      icone: Icons.person_outline,
      cor: Colors.purple,
    ),
   ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Meus Contatos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: contatos.length,
        itemBuilder: (context, index) {
          final contato = contatos[index];
          return _ItemContato(contato: contato);
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Widget para cada item da lista
// ─────────────────────────────────────────────
class _ItemContato extends StatelessWidget {
  final Contato contato;

  const _ItemContato({required this.contato});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: contato.cor,
          child: Icon(contato.icone, color: Colors.white),
        ),
        title: Text(
          contato.nome,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(contato.telefone),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),

        // Ao clicar: navega para a Tela 2 passando os dados
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TelaDetalheContato(
                nome: contato.nome,
                telefone: contato.telefone,
                icone: contato.icone,
                cor: contato.cor,
              ),
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────
// TELA 2 – Detalhes do Contato
// Recebe os dados como parâmetros (passagem de dados)
// ─────────────────────────────────────────────
class TelaDetalheContato extends StatefulWidget {
  final String nome;
  final String telefone;
  final IconData icone;
  final Color cor;

  const TelaDetalheContato({
    super.key,
    required this.nome,
    required this.telefone,
    required this.icone,
    required this.cor,
  });

  @override
  State<TelaDetalheContato> createState() => _TelaDetalheContatoState();
}

class _TelaDetalheContatoState extends State<TelaDetalheContato> {
  // DESAFIO EXTRA: controla a mensagem "Ligando para..."
  String _mensagem = '';

  void _ligar() {
    setState(() {
      _mensagem = 'Ligando para ${widget.nome}...';
    });

    // A mensagem some após 3 segundos
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => _mensagem = '');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('👤 Detalhes'),
        backgroundColor: widget.cor.withOpacity(0.3),
        // Botão de voltar é adicionado automaticamente pelo Navigator
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),

            // Avatar grande com cor do contato
            CircleAvatar(
              radius: 60,
              backgroundColor: widget.cor,
              child: Icon(widget.icone, size: 60, color: Colors.white),
            ),

            const SizedBox(height: 24),

            // Nome do contato
            Text(
              widget.nome,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            // Card com o telefone
            Card(
              elevation: 2,
              child: ListTile(
                leading: Icon(Icons.phone, color: widget.cor),
                title: const Text('Telefone'),
                subtitle: Text(
                  widget.telefone,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // DESAFIO EXTRA: Botão "Ligar"
            ElevatedButton.icon(
              onPressed: _ligar,
              icon: const Icon(Icons.phone_in_talk),
              label: const Text('Ligar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.cor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 20),

            // DESAFIO EXTRA: Mensagem "Ligando para..."
            if (_mensagem.isNotEmpty)
              AnimatedOpacity(
                opacity: _mensagem.isNotEmpty ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 400),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: widget.cor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: widget.cor.withOpacity(0.4)),
                  ),
                  child: Text(
                    _mensagem,
                    style: TextStyle(
                      fontSize: 15,
                      color: widget.cor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

            const Spacer(),

            // Botão para voltar (requisito obrigatório)
            OutlinedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Voltar para lista'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
