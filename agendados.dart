import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'parametros_iniciados.dart';

class AgendadosPage extends StatefulWidget {
  const AgendadosPage({super.key});

  @override
  State<AgendadosPage> createState() => _AgendadosPageState();
}

class _AgendadosPageState extends State<AgendadosPage> {
  // Variáveis de instância
  DateTime? _selectedDate;
  DateTime firstDay = DateTime(2023);
  DateTime lastDay = DateTime(2030);
  final DateTime _focusedDay = DateTime.now();

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
            'Agendados',
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.black87),
              onPressed: () => [
                // ação aqui
              ],
            )
          ],
          backgroundColor: const Color.fromARGB(255, 248, 247, 247),
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 247, 238, 238),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                              "Confira os dias agendados com seu fisioterapeuta:",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ))),

                      const SizedBox(height: 20),
                      // Passando as variáveis necessárias para o _buildCalendar()
                      _buildCalendar(firstDay, lastDay, _focusedDay),

                      Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2B3A67),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ParametrosIniciados()));
                            },
                            child: const Text(
                              "Visualizar parâmetros do dia",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ))
                    ]))));
  }

  //criar o calendário
  Widget _buildCalendar(
      DateTime firstDay, DateTime lastDay, DateTime focusedDay) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TableCalendar(
        firstDay: firstDay,
        lastDay: lastDay,
        focusedDay: focusedDay,
        selectedDayPredicate: (day) {
          return _selectedDate != null && isSameDay(_selectedDate, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDate = selectedDay;
            focusedDay = focusedDay.isAfter(lastDay) ? lastDay : focusedDay;
          });
        },
        calendarStyle: const CalendarStyle(
          defaultTextStyle: TextStyle(color: Colors.black),
          weekendTextStyle: TextStyle(color: Colors.redAccent),
          todayTextStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          selectedTextStyle: TextStyle(color: Colors.white),
          outsideTextStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
