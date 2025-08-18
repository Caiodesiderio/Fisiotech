import 'package:fisiotech/components/decoracao_campo_autenticacao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/paciente_provider.dart';
import '../models/paciente.dart';

class AdicionarPacientePage extends StatefulWidget {
  const AdicionarPacientePage({super.key});

  @override
  State<AdicionarPacientePage> createState() => _AdicionarPacientePageState();
}

class _AdicionarPacientePageState extends State<AdicionarPacientePage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _sobrenomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _observacoesController = TextEditingController();
  final _cpfController = TextEditingController();
  final _idController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  @override
  void _cadastrarPaciente() {
    print(_formKey.currentState);
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final paciente = Paciente(
        nome: _nomeController.text,
        sobrenome: _sobrenomeController.text,
        email: _emailController.text,
        cpf: _cpfController.text,
        id: _idController.text,
        dataNascimento: _dataNascimentoController.text,
        observacoes: _observacoesController.text,
      );

      Provider.of<PacienteProvider>(context, listen: false)
          .adicionarPaciente(paciente);
      Navigator.pop(context);

      print("paciente cadastrado! $paciente");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            const Color.fromARGB(255, 236, 239, 241), // Fundo cinza claro
        appBar: AppBar(
          backgroundColor:
              const Color.fromARGB(255, 55, 95, 128), // Cabeçalho cinza escuro
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Adicionar paciente',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.white),
              onPressed: () {
                // Função para acessar configurações
              },
            ),
          ], // Fundo cinza claro
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 248, 248, 248),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            decoration: getInputDecoration("Nome"),
                            controller: _nomeController,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: getInputDecoration("Sobrenome"),
                            controller: _sobrenomeController,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                              decoration: getInputDecoration("Email"),
                              controller: _emailController),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _cpfController,
                            decoration: getInputDecoration("CPF"),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: getInputDecoration("ID"),
                            controller: _idController,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration:
                                getInputDecoration("Data de Nascimento"),
                            controller: _dataNascimentoController,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          TextFormField(
                            controller: _observacoesController,
                            decoration: const InputDecoration(
                              label: Text(
                                'Observações...',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            maxLines: 5,
                          )
                        ],
                      ),
                    ),
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                      onPressed: _cadastrarPaciente,
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 68, 102, 146),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Text(
                        "Cadastrar",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )))
            ],
          ),
        )));
  }
}
