import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'detalhes_solicitacao.dart';
import 'agendemento.dart'; // Tela do calendário

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  List<Map<String, String>> agendamentos = [];

  @override
  void initState() {
    super.initState();
    _loadAgendamentos();
  }

  Future<void> _loadAgendamentos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('solicitacoes');
    print("Dados carregados do Shared: ${data ?? 'Sem dados'}"); // Corrigido

    setState(() {
      agendamentos = (jsonDecode(data ?? '[]') as List) // Evitar erro de nulo
          .map((item) => (item as Map<String, dynamic>)
              .map((key, value) => MapEntry(key, value.toString())))
          .toList();
    });
  }

  void _removerAgendamento(DateTime data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      String dataFormatada = "${data.day}/${data.month}/${data.year}";
      agendamentos
          .removeWhere((agendamento) => agendamento["data"] == dataFormatada);
    });

    await prefs.setString('solicitacoes', jsonEncode(agendamentos));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 240, 240),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Solicitações",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 236, 238, 241),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87, size: 28),
            onPressed: () {
              // Ação do botão de pesquisa
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: agendamentos.isEmpty
                  ? const Center(
                      child: Text("Nenhuma solicitação encontrada.",
                          style:
                              TextStyle(fontSize: 18, color: Colors.black54)))
                  : ListView.builder(
                      itemCount: agendamentos.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            String? dataString = agendamentos[index]["data"];

                            if (dataString == null ||
                                dataString.trim().isEmpty) {
                              print("Erro: A data está vazia ou inválida");
                              return;
                            }

                            dataString = dataString.trim();

                            List<String> partesDataHora =
                                dataString.contains(" ")
                                    ? dataString.split(" ")
                                    : [dataString, "00:00"];
                            List<String> partesData =
                                partesDataHora[0].split("/");
                            List<String> partesHora =
                                partesDataHora[1].split(":");

                            if (partesData.length < 3) {
                              print(
                                  "Erro: A data não está no formato esperado");
                              return;
                            }

                            int dia = int.tryParse(partesData[0]) ?? 1;
                            int mes = int.tryParse(partesData[1]) ?? 1;
                            int ano = int.tryParse(partesData[2]) ?? 2000;
                            int hora = int.tryParse(partesHora[0]) ?? 0;
                            int minuto = int.tryParse(partesHora[1]) ?? 0;

                            DateTime dataFormatada =
                                DateTime(ano, mes, dia, hora, minuto);

                            print("Data formatada: $dataFormatada");

                            bool? resultado = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetalhesSolicitacaoPage(
                                  data: dataFormatada,
                                  status: agendamentos[index]["status"]!,
                                  onDelete: _removerAgendamento,
                                ),
                              ),
                            );

                            if (resultado == true) {
                              _loadAgendamentos();
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 65, 95, 151),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Dia ${agendamentos[index]['data']}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Status: ${agendamentos[index]['status']}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 57, 109, 179),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    bool? atualizou = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AgendamentoPage(),
                      ),
                    );

                    if (atualizou == true) {
                      _loadAgendamentos();
                    }
                  },
                  child: const Text(
                    "Solicitar consulta",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
