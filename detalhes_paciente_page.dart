import 'package:flutter/material.dart';
import '../models/paciente.dart'; // Importe a classe Paciente corretamente
import 'criar_parametros_page.dart'; // Importe a página CriarParametrosPage corretamente

class DetalhesPacientePage extends StatelessWidget {
  final Paciente paciente; // Definindo o parâmetro paciente

  const DetalhesPacientePage({super.key, required this.paciente});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Detalhes do Paciente",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF2B3A67),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exibindo os detalhes do paciente
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nome: ${paciente.nome} ${paciente.sobrenome}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "CPF: ${paciente.cpf}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Email: ${paciente.email}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Data de Nascimento: ${paciente.dataNascimento}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "ID: ${paciente.id}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF333333),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Botão "Criar Parâmetros" com imagem de fundo
            GestureDetector(
              onTap: () {
                // Navegar para a página CriarParametrosPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CriarParametrosPage(paciente: paciente),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                height: 120, // Altura do botão
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/back_fisiotech.png'), // Caminho da imagem de fundo
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Criar Parâmetros',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: Colors.black.withOpacity(0.5),
                          offset: Offset(3.0, 3.0),
                        ),
                      ],
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
