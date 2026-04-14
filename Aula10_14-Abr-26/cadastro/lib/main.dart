import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart'; // Para o SQLite 
import 'package:path/path.dart' as buidcontext; // Para gerenciar caminhos de arquivos

void main() => runApp(MaterialApp(
      home: AppCadastro(),
      debugShowCheckedModeBanner: false,
    ));

class AppCadastro extends StatefulWidget {
  const AppCadastro({super.key});

  @override
  AppCadastroState createState() => AppCadastroState();
}

class AppCadastroState extends State<AppCadastro> {
  Database? _db; // Instância do banco de dados 
  List<Map<String, dynamic>> _itens = []; // Lista para armazenar dados da tabela 
  
  // Controladores para capturar o que o usuário digita 
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initDb(); // Inicia o banco assim que o app abre 
  }

  // --- REQUISITO 5: PERSISTÊNCIA ---
  Future<void> _initDb() async {
    // Define o caminho do banco de dados
    String path = buidcontext.join(await getDatabasesPath(), 'cadastro_inteligente.db');
    
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        // REQUISITO: Tabela obrigatória 
        return db.execute(
          "CREATE TABLE dados(id INTEGER PRIMARY KEY AUTOINCREMENT, titulo TEXT, descricao TEXT)",
        );
      },
    );
    _atualizarLista();
  }

  // REQUISITO 2 e BÔNUS: Listar e Ordenar 
  Future<void> _atualizarLista() async {
    // DESAFIO EXTRA: Ordenar por título ASC 
    final List<Map<String, dynamic>> res = await _db!.query('dados', orderBy: "titulo ASC");
    setState(() {
      _itens = res; // Uso correto de setState para atualizar a UI 
    });
  }

  // REQUISITO 1 e 4: Criar e Atualizar 
  Future<void> _salvar({int? id, required BuildContext context}) async {
    Map<String, dynamic> dados = {
      'titulo': _tituloController.text,
      'descricao': _descController.text,
    };

    if (id == null) {
      await _db!.insert('dados', dados); // Inserir no banco 
    } else {
      await _db!.update('dados', dados, where: 'id = ?', whereArgs: [id]); // Atualizar no banco 
    }

    _tituloController.clear();
    _descController.clear();
    _atualizarLista();
    Navigator.pop(context); // Fecha o formulário
  }

  // REQUISITO 3: Remoção 
  Future<void> _remover(int id) async {
    await _db!.delete('dados', where: 'id = ?', whereArgs: [id]); // Remover pelo ID 
    _atualizarLista(); // Atualizar lista 
  }

  // Função para abrir o formulário (Serve para Cadastro e Edição)
  void _mostrarFormulario({Map<String, dynamic>? item}) {
    if (item != null) {
      _tituloController.text = item['titulo']; // Preenche para edição 
      _descController.text = item['descricao'];
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 15, right: 15, top: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _tituloController, decoration: InputDecoration(labelText: 'Título')), // Campo título 
            TextField(controller: _descController, decoration: InputDecoration(labelText: 'Descrição')), // Campo descrição 
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _salvar(id: item?['id'], context: context), // Salvar ou Editar 
              child: Text(item == null ? "Salvar" : "Atualizar"),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro Inteligente")), // Tema 
      
      // DESAFIO EXTRA: Mostrar mensagem se estiver vazio 
      body: _itens.isEmpty
          ? Center(child: Text("Nenhum item cadastrado")) 
          : ListView.builder( // REQUISITO 2: Listagem 
              itemCount: _itens.length,
              itemBuilder: (context, index) {
                final item = _itens[index];
                return ListTile(
                  title: Text(item['titulo']), // Mostrar título 
                  subtitle: Text(item['descricao']), // Mostrar descrição 
                  onTap: () => _mostrarFormulario(item: item), // REQUISITO 4: Abrir edição 
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _remover(item['id']), // Botão excluir 
                  ),
                );
              },
            ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _tituloController.clear();
          _descController.clear();
          _mostrarFormulario();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}