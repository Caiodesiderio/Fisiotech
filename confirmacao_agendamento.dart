import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'paciente_home_page.dart';

class ConfirmacaoAgendamentoPage extends StatelessWidget {
  final DateTime data;
  final TimeOfDay horario;

  const ConfirmacaoAgendamentoPage(
      {super.key, required this.data, required this.horario});

  Future<void> _salvarAgendamento() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Carregar agendamentos salvos
    String? dataSalva = prefs.getString('solicitacoes');
    List<Map<String, String>> agendamentos = dataSalva != null
        ? (jsonDecode(dataSalva) as List)
            .map((item) => (item as Map<String, dynamic>)
                .map((key, value) => MapEntry(key, value.toString())))
            .toList()
        : [];

    // Adicionar novo agendamento
    agendamentos.add({
      "data": "${data.day}/${data.month}/${data.year}",
      "status": "Solicitado"
    });

    // Salvar novamente
    await prefs.setString('solicitacoes', jsonEncode(agendamentos));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDCDCDC),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 28),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Confirmação de Agendamento',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 25, 105, 180),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(20.0),
              child: const Text(
                "Agendamento solicitado com sucesso",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: const Text(
                "Aguardando resposta do profissional",
                style: TextStyle(fontSize: 16),
              ),
            ),
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 100,
            ),
            const SizedBox(height: 20),
            Text(
              'Data: ${data.day}/${data.month}/${data.year}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            ElevatedButton.icon(
              onPressed: () async {
                await _salvarAgendamento();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const PacienteHomePage(nomePaciente: 'Kimura')));
              },
              icon: const Icon(Icons.arrow_back, size: 24),
              label: const Text('Voltar', style: TextStyle(fontSize: 28)),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
