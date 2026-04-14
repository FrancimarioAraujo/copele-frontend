import 'package:copelefrontend/modules/reuniao/controllers/reuniao_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class MeetingsPage extends StatefulWidget {
  @override
  _MeetingsPageState createState() => _MeetingsPageState();
}

class _MeetingsPageState extends State<MeetingsPage> {
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
    final meetings = controller.reunioes;

    if (meetings.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Reuniões'),
          backgroundColor: Colors.black,
          elevation: 4,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade50, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                ),
                SizedBox(height: 16),
                Text(
                  'Carregando reuniões...',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Reuniões'),
        backgroundColor: Colors.blueAccent,
        elevation: 4,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              controller.fetchMeets().then((_) {
                setState(() {});
              });
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: meetings.length,
          itemBuilder: (context, index) {
            final meeting = meetings[index];

            return InkWell(
              onTap: () {
               Modular.to.pushNamed('/reuniao');
              },
              child: Card(
                margin: EdgeInsets.only(bottom: 16),
                elevation: 8,
                shadowColor: Colors.blueAccent.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_today, color: Colors.blueAccent),
                          SizedBox(width: 8),
                          Text(
                            'Data: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(meeting.date))}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[800],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.access_time, color: Colors.blueAccent),
                          SizedBox(width: 8),
                          Text(
                            'Hora: ${meeting.startTime}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blueGrey[700],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.person, color: Colors.blueAccent),
                          SizedBox(width: 8),
                          Text(
                            'Secretário(a): ${meeting.secretary}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blueGrey[700],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        '${meeting.participants.length} participante(s), ${meeting.topics.length} pauta(s)',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blueGrey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        
        },
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add),
      ),
    );
  }
}