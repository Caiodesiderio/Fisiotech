import 'dart:convert';
import 'package:fisiotech/parametros_realizados.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoricoPage extends StatefulWidget {
  @override
  State<HistoricoPage> createState() => _HistoricoPageState();
}

class _HistoricoPageState extends State<HistoricoPage> {
  DateTime? _selectedDate;
  DateTime firstDay = DateTime(2023);
  DateTime lastDay = DateTime(2030);
  DateTime _focusedDay = DateTime.now(); // Ajustado no initState
  List<Map<String, dynamic>> _historico = [];

  @override
  void initState() {
    super.initState();
    _loadHistorico();
    // Se _focusedDay for maior que lastDay, corrigimos para lastDay
    if (_focusedDay.isAfter(lastDay)) {
      _focusedDay = lastDay;
    }
  }

  Future<void> _loadHistorico() async {
    List<Map<String, dynamic>> historicoCarregado = await carregarCronometro();
    setState(() {
      _historico = historicoCarregado;
    });
  }

  Future<List<Map<String, dynamic>>> carregarCronometro() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? cronometroJson = prefs.getString('cronometro');

      if(cronometroJson != null){
        print('Dados do Shared $cronometroJson');
        List<dynamic> decodedList = jsonDecode(cronometroJson);
        return decodedList.map((item) {
          item['start'] = DateTime.parse(item['start']);
          item['end'] = DateTime.parse(item['end']);
          return item as Map<String, dynamic>;
        }).toList();
      }
      return [];
  }

  void _onDaySelected(DateTime selectedDay) {
    setState(() {
      _selectedDate = selectedDay;
      _focusedDay = selectedDay.isAfter(lastDay) ? lastDay : selectedDay;
    });

    // Filtrando os dados do histórico para o dia selecionado
    Map<String, dynamic>? selectedData = _historico.firstWhere(
      (item) =>
          item['start'].day == selectedDay.day &&
          item['start'].month == selectedDay.month &&
          item['start'].year == selectedDay.year,
      orElse: () => {},
    );

    if (selectedData.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ParametrosRealizados(dados: selectedData),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDCDCDC),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Histórico',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              // Ação de configuração
            },
          ),
        ],
        backgroundColor: const Color(0xFF2B3A67),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 10),
            _buildCalendarWithBackground(),
            _buildLegend(),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarWithBackground() {
    return Container(
      padding: EdgeInsets.all(10),
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

      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, data, events){
          //Verificar se a data está no histórico

          for(var item in _historico){

            if(isSameDay(data, item['start'])){
              return Container(
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                 margin: EdgeInsets.all(4.0),
                  width: 40,
                  height: 40,
              );
            }
          }
          return SizedBox();
        }
      ),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDate = selectedDay;
          // Garante que o novo focusedDay não ultrapasse lastDay
          _focusedDay = focusedDay.isAfter(lastDay) ? lastDay : focusedDay;
           _onDaySelected(selectedDay);
        });
      },
      calendarStyle: CalendarStyle(
        defaultTextStyle: TextStyle(color: Colors.black),
        weekendTextStyle: TextStyle(color: Colors.redAccent),
        todayTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        selectedTextStyle: TextStyle(color: Colors.white),
        outsideTextStyle: TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget _buildLegend() {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
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

        ],
      ),
    );
  }
}
