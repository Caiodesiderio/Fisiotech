import 'package:flutter/material.dart';
import '../models/paciente.dart'; // Importe a classe Paciente corretamente

class CriarParametrosPage extends StatefulWidget {
  final Paciente paciente; // Recebe o paciente selecionado

  const CriarParametrosPage({super.key, required this.paciente});

  @override
  _CriarParametrosPageState createState() => _CriarParametrosPageState();
}

class _CriarParametrosPageState extends State<CriarParametrosPage> {
  // Controladores para os ângulos inicial e final dos 5 servos
  TextEditingController servo1InicioController = TextEditingController();
  TextEditingController servo1FinalController = TextEditingController();
  TextEditingController servo2InicioController = TextEditingController();
  TextEditingController servo2FinalController = TextEditingController();
  TextEditingController servo3InicioController = TextEditingController();
  TextEditingController servo3FinalController = TextEditingController();
  TextEditingController servo4InicioController = TextEditingController();
  TextEditingController servo4FinalController = TextEditingController();
  TextEditingController servo5InicioController = TextEditingController();
  TextEditingController servo5FinalController = TextEditingController();

  // Controlador para o tempo da sessão
  TextEditingController tempoController = TextEditingController();

  // Função para abrir o campo de entrada para o ângulo de cada servo
  void _showServoInputDialog(
      String servoName,
      TextEditingController inicioController,
      TextEditingController finalController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ajuste para $servoName'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: inicioController,
                decoration: InputDecoration(
                  labelText: '$servoName - Ângulo Inicial (0° a 180°)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: finalController,
                decoration: InputDecoration(
                  labelText: '$servoName - Ângulo Final (0° a 180°)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Parâmetros'),
        backgroundColor: const Color(0xFF2B3A67),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Usar SingleChildScrollView para evitar overflow
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Texto com o nome do paciente
              Text(
                'Criando parâmetros para o paciente ${widget.paciente.nome} ${widget.paciente.sobrenome}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Campo de texto para o tempo da sessão
              TextField(
                controller: tempoController,
                decoration: InputDecoration(
                  labelText: 'Tempo da Sessão (minutos)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),

              // Título para os campos dos servomotores
              const Text(
                'Ajuste as posições dos servomotores:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Layout com os ícones em forma de quadrado (usando Row)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildServoButton('Servo 1', Icons.settings),
                  _buildServoButton('Servo 2', Icons.settings),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildServoButton('Servo 3', Icons.settings),
                  _buildServoButton('Servo 4', Icons.settings),
                ],
              ),
              const SizedBox(height: 10),
              // O servo 5 agora será corretamente alinhado
              Center(
                child: _buildServoButton('Servo 5', Icons.settings),
              ),

              const SizedBox(height: 20),

              // Centralizando o botão de salvar parâmetros
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    final tempo = tempoController.text;
                    print('Tempo da sessão: $tempo');
                    print(
                        'Servo 1 - Início: ${servo1InicioController.text}, Final: ${servo1FinalController.text}');
                    print(
                        'Servo 2 - Início: ${servo2InicioController.text}, Final: ${servo2FinalController.text}');
                    print(
                        'Servo 3 - Início: ${servo3InicioController.text}, Final: ${servo3FinalController.text}');
                    print(
                        'Servo 4 - Início: ${servo4InicioController.text}, Final: ${servo4FinalController.text}');
                    print(
                        'Servo 5 - Início: ${servo5InicioController.text}, Final: ${servo5FinalController.text}');
                    // Lógica para salvar os dados ou enviar para o banco de dados
                  },
                  child: const Text('Salvar Parâmetros'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A90E2), // Azul Cinzelado
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método para criar um botão para cada servo (com ícone e clique)
  Widget _buildServoButton(String servoName, IconData icon) {
    return GestureDetector(
      onTap: () {
        // Ao clicar, abre o diálogo para digitar os valores
        _showServoInputDialog(
            servoName,
            _getControllerForServo(servoName, 'inicio'),
            _getControllerForServo(servoName, 'final'));
      },
      child: Container(
        width: 100, // Aumentar a largura das caixas
        height: 100, // Aumentar a altura das caixas
        decoration: BoxDecoration(
          color: Colors.white, // Box branca
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                color: const Color(0xFF4A90E2), size: 40), // Ícone azul maior
            Text(
              servoName,
              style: const TextStyle(
                  color: Color(0xFF4A90E2), fontSize: 16), // Texto azul
            ),
          ],
        ),
      ),
    );
  }

  // Função para retornar o controlador correto com base no nome do servo
  TextEditingController _getControllerForServo(
      String servoName, String angleType) {
    switch (servoName) {
      case 'Servo 1':
        return angleType == 'inicio'
            ? servo1InicioController
            : servo1FinalController;
      case 'Servo 2':
        return angleType == 'inicio'
            ? servo2InicioController
            : servo2FinalController;
      case 'Servo 3':
        return angleType == 'inicio'
            ? servo3InicioController
            : servo3FinalController;
      case 'Servo 4':
        return angleType == 'inicio'
            ? servo4InicioController
            : servo4FinalController;
      case 'Servo 5':
        return angleType == 'inicio'
            ? servo5InicioController
            : servo5FinalController;
      default:
        return TextEditingController();
    }
  }
}
