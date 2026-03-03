import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: PaginaTarefas(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.teal,
      fontFamily: 'Roboto',
    ),
  ));
}

class PaginaTarefas extends StatefulWidget {
  @override
  _PaginaTarefasState createState() => _PaginaTarefasState();
}

class _PaginaTarefasState extends State<PaginaTarefas> {
  List<String> tarefas = [];
  TextEditingController controller = TextEditingController();

  void adicionarTarefa() {
    if (controller.text.isNotEmpty) {
      setState(() {
        tarefas.add(controller.text);
      });
      controller.clear();
    }
  }

  void removerTarefa(int index) {
    setState(() {
      tarefas.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Check List",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.teal.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.teal.shade50,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            // Header animado
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(
                    Icons.checklist_rounded,
                    size: 50,
                    color: Colors.teal.shade700,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Gerencie suas tarefas",
                    style: TextStyle(
                      color: Colors.teal.shade800,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Campo de entrada estilizado
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withOpacity(0.1),
                      blurRadius: 20,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: "O que você precisa fazer?",
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.teal,
                        width: 2,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.task_alt,
                      color: Colors.teal.shade400,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.send_rounded,
                        color: controller.text.isEmpty 
                            ? Colors.grey.shade400 
                            : Colors.teal,
                      ),
                      onPressed: adicionarTarefa,
                    ),
                  ),
                  onSubmitted: (_) => adicionarTarefa(),
                ),
              ),
            ),

            SizedBox(height: 20),

            // Lista de tarefas
            Expanded(
              child: tarefas.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.inbox_rounded,
                            size: 80,
                            color: Colors.teal.shade100,
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Nenhuma tarefa ainda",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.teal.shade300,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Adicione uma tarefa para começar",
                            style: TextStyle(
                              color: Colors.teal.shade200,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.all(20),
                      itemCount: tarefas.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 12),
                          child: Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Colors.teal.shade50.withOpacity(0.3),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.teal.shade400,
                                        Colors.teal.shade600,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                title: Text(
                                  tarefas[index],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.teal.shade900,
                                  ),
                                ),
                                subtitle: Text(
                                  "Tarefa #${index + 1}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.teal.shade300,
                                  ),
                                ),
                                trailing: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade50,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.close_rounded,
                                      color: Colors.red.shade400,
                                      size: 20,
                                    ),
                                    onPressed: () => removerTarefa(index),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),

            // Rodapé com contador
            if (tarefas.isNotEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total: ${tarefas.length} tarefas",
                      style: TextStyle(
                        color: Colors.teal.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "${tarefas.length} pendente${tarefas.length > 1 ? 's' : ''}",
                        style: TextStyle(
                          color: Colors.teal.shade700,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}