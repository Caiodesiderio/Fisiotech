import 'package:flutter/material.dart';

class ContaPage extends StatefulWidget {
  const ContaPage({super.key});

  @override
  _ContaPageState createState() => _ContaPageState();
}

class _ContaPageState extends State<ContaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Conta'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Adicionar ação para editar perfil
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          // Foto de Perfil
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(
                      'assets/user_profile.png'), // Troque pelo caminho da imagem do perfil
                ),
                SizedBox(width: 16),
                Text('Usuário', style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
          const Divider(),

          // Editar Foto de Perfil
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Editar Foto de Perfil'),
            onTap: () {
              // Adicionar ação para editar foto de perfil
            },
          ),
          const Divider(),

          // Editar Usuário
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Editar Usuário'),
            onTap: () {
              // Adicionar ação para editar nome de usuário
            },
          ),
          const Divider(),

          // Editar Email
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Editar Email'),
            onTap: () {
              // Adicionar ação para editar email
            },
          ),
          const Divider(),

          // Trocar Senha
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Trocar Senha'),
            onTap: () {
              // Adicionar ação para trocar senha
            },
          ),
          const Divider(),

          // Logout
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sair'),
            onTap: () {
              // Adicionar ação para logout
            },
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ContaPage(),
  ));
}
