import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'horario_agenda.dart';

class AgendamentoPage extends StatefulWidget {
  const AgendamentoPage({super.key});

  @override
  State<AgendamentoPage> createState() => _AgendamentoPageState();
}

class _AgendamentoPageState extends State<AgendamentoPage> {
  DateTime? _selectedDate;
  Map<DateTime, List<TimeOfDay>> _agendados = {};
  DateTime firstDay = DateTime(2023);
  DateTime lastDay = DateTime(2030);
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences();
    _loadAgendamentos();
    if (_focusedDay.isAfter(lastDay)) {
      _focusedDay = lastDay;
    }
  }

  Future<void> limparSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print(" SharedPreferences foi completamente limpo!");
  }

  void _initializeSharedPreferences() async {
    try {
      await _loadAgendamentos();
    } catch (e) {
      print('Erro ao carregar SharedPreferences: $e');
    }
  }

  Future<void> _saveAgendamentos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, List<String>> stringAgendados = {};

    _agendados.forEach((key, value) {
      stringAgendados[key.toIso8601String()] =
          value.map((time) => '${time.hour}:${time.minute}').toList();
    });

    await prefs.setString('agendamentos', jsonEncode(stringAgendados));
  }

  Future<void> _loadAgendamentos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('agendamentos');

    print("dados carregados do shared: ${data ?? 'Sem dados'}");

    Map<String, dynamic> decoded = jsonDecode(data ?? '{}');
    Map<DateTime, List<TimeOfDay>> loadedAgendados = {};

    decoded.forEach((key, value) {
      List<TimeOfDay> times = (value as List).map((time) {
        List<String> parts = time.split(':');
        return TimeOfDay(
            hour: int.parse(parts[0]), minute: int.parse(parts[1]));
      }).toList();

      loadedAgendados[DateTime.parse(key)] = times;
    });

    setState(() {
      _agendados = loadedAgendados;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDCDCDC),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Agendamento',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              // Ação de configuração
            },
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 250, 250, 250),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildCalendarWithBackground(),
            const SizedBox(height: 20),
            _buildLegend(),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 59, 115, 189),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                if (_selectedDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Por favor, selecione uma data.')),
                  );
                  return;
                }

                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HorarioAgendamentoPage(data: _selectedDate!),
                  ),
                );

                if (result != null) {
                  setState(() {
                    if (_agendados.containsKey(_selectedDate)) {
                      _agendados[_selectedDate]!.add(result);
                    } else {
                      _agendados[_selectedDate!] = [result];
                    }
                  });
                  _saveAgendamentos();
                }
              },
              child: const Text(
                'Agendar Data',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 199, 198, 198),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                limparSharedPreferences();
                setState(() {});
              },
              child: const Text(
                "Limpar",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarWithBackground() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: _buildCalendar(),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: firstDay,
      lastDay: lastDay,
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) {
        return _selectedDate != null && isSameDay(_selectedDate, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDate = selectedDay;
          _focusedDay = focusedDay.isAfter(lastDay) ? lastDay : focusedDay;
        });
      },
      calendarStyle: const CalendarStyle(
        defaultTextStyle: TextStyle(color: Colors.black),
        weekendTextStyle: TextStyle(color: Color.fromARGB(255, 231, 14, 14)),
        todayTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        selectedTextStyle: TextStyle(color: Colors.white),
        outsideTextStyle: TextStyle(color: Colors.grey),
      ),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          bool temAgendamento = _agendados.keys.any((data) =>
              data.year == day.year &&
              data.month == day.month &&
              data.day == day.day);

          if (temAgendamento) {
            return Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 52, 103, 170),
                shape: BoxShape.circle,
              ),
              margin: const EdgeInsets.all(4.0),
              width: 35,
              height: 35,
              child: Center(
                child: Text(
                  '${day.day}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          }
          return null;
        },
      ),
    );
  }

  Widget _buildLegend() {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(backgroundColor: Colors.green, radius: 6),
              SizedBox(width: 8),
              Text("Dias com terapia realizada.",
                  style: TextStyle(color: Colors.black)),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 235, 7, 7), radius: 6),
              SizedBox(width: 8),
              Text("Dias agendados.", style: TextStyle(color: Colors.black)),
            ],
          ),
        ],
      ),
    );
  }
}
