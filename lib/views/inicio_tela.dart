//import 'package:app_gym/services/autenticacao_service.dart';

import 'package:flutter/material.dart';
import 'package:uatizap/services/autenticacao_service.dart';

class InicioTela extends StatelessWidget {
  const InicioTela({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela Inicial'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('deslogar'),
              leading: const Icon(Icons.logout),
              onTap: () {
                AutenticacaoService().deslogar();
              },
            ),
          ],
        ),
      ),
    );
  }
}
