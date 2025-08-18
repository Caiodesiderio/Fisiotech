import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class DetalhesSolicitacaoPage extends StatelessWidget {
  final DateTime data;
  final String status;
  final Function(DateTime) onDelete; // Função para remover a consulta

  DetalhesSolicitacaoPage({
    required this.data,
    required this.status,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDCDCDC),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Detalhes da Solicitação",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),

        actions: [
          IconButton(
            icon: Icon(Icons.settings,
            color: Colors.white,
            ),

            onPressed:() {

            }
          ),
        ],
        backgroundColor: const Color(0xFF2B3A67),
        elevation: 0,
      ),


      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),

              child: Text(
                "Confira os dados do agendamento:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
              )
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 80,),

              decoration: BoxDecoration(
                color: const Color(0xFF2B3A67),
                borderRadius: BorderRadius.circular(10),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                      "Data: ${data != null ? DateFormat('dd/MM/yyyy').format(data) : 'Data inválida'}",
                      style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                    ),

                    Text(
                      "Hora: ${data != null ? DateFormat('HH:mm').format(data) : 'Hora inválida'}",
                      style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                ],
              ),
            ),

            SizedBox(height: 30),
            Text(
              "Status: $status",
              style: TextStyle(fontSize: 24),
            ),

            Container(
              margin: EdgeInsets.only(top: 40),
                child: Text(
                  "Aguardando resposta do profissional...",
                  style: TextStyle(fontSize: 18)
                )
            ),

            SizedBox(height: 30),
            Spacer(),

            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  _mostrarDialogoConfirmacao(context);
                },
                child: Text(
                  "Cancelar Consulta",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogoConfirmacao(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Cancelar Consulta"),
        content: Text("Tem certeza que deseja cancelar esta consulta?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Não"),
          ),
          TextButton(
            onPressed: () {
              onDelete(data); // Remove do SharedPreferences e do calendário
              Navigator.pop(context);
              Navigator.pop(context, true); // Retorna true para atualizar a lista
            },
            child: Text("Sim", style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}

}
