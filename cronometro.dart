import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fisiotech/tratamento_concluido.dart';

class CronometroPage extends StatefulWidget {
  const CronometroPage({super.key});

  @override
  CronometroPageState createState() => CronometroPageState();
}

class CronometroPageState extends State<CronometroPage> {
  int _seconds = 0;
  bool _isRunning = false;
  late Timer _timer;
  List<Map<String, dynamic>> _historico = [];

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _pauseTimer() {
    _timer.cancel();
  }

  void _resetTimer() {
    _timer.cancel();
    setState(() {
      _seconds = 0;
      _isRunning = false;
    });
  }

  void _toggleTimer() {
    if (_isRunning) {
      _pauseTimer();
    } else {
      _startTimer();
    }
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  Future<void> _addToHistorico() async {
    final endTime = DateTime.now();
    final startTime = endTime.subtract(Duration(seconds: _seconds));
    _historico.add({
      'start': startTime.toIso8601String(),
      'end': endTime.toIso8601String(),
      'duration': _seconds,
    });

    setState(() {
      _seconds = 0;
    });

    await salvarCronometro();
    await Future.delayed(const Duration(milliseconds: 600));
    _showTreatmentCompletedScreen();
  }

  void _showPauseConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Finalizar Sessão'),
          content: const Text('Deseja mesmo finalizar a sessão?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _addToHistorico();
              },
              child: const Text('Finalizar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> salvarCronometro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cronometroJson = jsonEncode(_historico);
    prefs.setString('cronometro', cronometroJson);
  }

  Future<void> carregarCronometro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cronometroJson = prefs.getString('cronometro');

    if (cronometroJson != null) {
      List<dynamic> decodedList = jsonDecode(cronometroJson);
      setState(() {
        _historico = decodedList.map((item) {
          item['start'] = DateTime.parse(item['start']);
          item['end'] = DateTime.parse(item['end']);
          return item as Map<String, dynamic>;
        }).toList();
      });
    }
  }

  void _showTreatmentCompletedScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TratamentoConcluidoPage(),
      ),
    );
  }

  @override
  void dispose() {
    if (_isRunning) _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    carregarCronometro();
  }

  @override
  Widget build(BuildContext context) {
    int minutes = _seconds ~/ 60;
    int seconds = _seconds % 60;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Iniciar tratamento',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFE8ECF3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  'assets/iniciar_tratamento.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 22),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
              decoration: BoxDecoration(
                color: const Color(0xFF1C1C1C),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$minutes:${seconds.toString().padLeft(2, '0')}',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _toggleTimer,
                  icon: Icon(
                    _isRunning ? Icons.pause_circle : Icons.play_circle,
                    color: Colors.white,
                    size: 26,
                  ),
                  label: Text(
                    _isRunning ? 'Pausar' : 'Iniciar',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 26, 76, 133),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 26, vertical: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _resetTimer,
                  icon: const Icon(Icons.restart_alt,
                      color: Colors.black, size: 26),
                  label: const Text(
                    'Resetar',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE0E0E0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 26, vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _showPauseConfirmationDialog,
              icon: const Icon(Icons.stop_circle_outlined,
                  size: 22, color: Colors.white),
              label: const Text(
                'Finalizar Sessão',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
