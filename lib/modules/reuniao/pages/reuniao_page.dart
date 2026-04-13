import 'package:copelefrontend/modules/reuniao/controllers/reuniao_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ReuniaoPage extends StatefulWidget {
  @override
  _ReuniaoPageState createState() => _ReuniaoPageState();
}

class _ReuniaoPageState extends State<ReuniaoPage> {
  final controller = Modular.get<ReuniaoController>();

  @override
  void initState() {
    super.initState();
    controller.fetchMeets().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final reunioes = controller.reunioes;

    if (reunioes.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Reuniões')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Reuniões')),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: reunioes.length,
        itemBuilder: (context, index) {
          final reuniao = reunioes[index];

          return Card(
            margin: EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Data: ${reuniao.data}'),
                  Text('Hora: ${reuniao.horaInicio}'),
                  Text('Secretário: ${reuniao.secretario}'),

                  SizedBox(height: 10),

                  Text('Participantes:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  ...reuniao.participantes.map((p) => Text('- $p')),

                  SizedBox(height: 10),

                  Text('Pautas:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  ...reuniao.pautas.map((p) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(p.descricao),
                        subtitle: Text(p.status),
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}