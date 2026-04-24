import 'package:copelefrontend/modules/meeting/controllers/meetings_controller.dart';
import 'package:copelefrontend/modules/meeting/models/meeting_model.dart';
import 'package:copelefrontend/modules/meeting/widgets/meeting_form_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:copelefrontend/theme/app_theme.dart';

class MeetingsPage extends StatefulWidget {
  @override
  _MeetingsPageState createState() => _MeetingsPageState();
}

class _MeetingsPageState extends State<MeetingsPage> {
  final controller = Modular.get<MeetingsController>();

  @override
  void initState() {
    super.initState();
    controller.loadMeetings();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Minhas Reuniões'),
            elevation: 0,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  _showSearchDialog(context);
                },
              ),
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {},
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                // Header com estatísticas
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bem-vindo!',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Gerencie suas reuniões de forma eficiente',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              context,
                              title: 'Próximas',
                              value: controller.futureMeetingsCount.toString(),
                              icon: Icons.calendar_today,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              context,
                              title: 'Concluídas',
                              value: controller.completedMeetingsCount.toString(),
                              icon: Icons.check_circle,
                              color: AppTheme.successColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Lista de Reuniões
                Expanded(
                  child: controller.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : controller.futureMeetings.isEmpty
                          ? _buildEmptyState(context)
                          : Container(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Próximos Eventos',
                                    style: Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const SizedBox(height: 16),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: controller.futureMeetings.length,
                                      itemBuilder: (context, index) {
                                        final meeting = controller.futureMeetings[index];
                                        return _buildMeetingCard(context, meeting);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                ),
                // Empty State
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
_showMeetingForm(context);
            },
            icon: const Icon(Icons.add),
            label: const Text('Nova Reunião'),
          ),
        );
      },
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.dividerColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: color,
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  void _showMeetingForm(BuildContext context, [MeetingModel? meeting]) {
    showDialog(
      context: context,
      builder: (context) => MeetingFormDialog(
        meeting: meeting,
        onSave: (newMeeting) {
          if (meeting != null) {
            controller.updateMeeting(meeting.id, newMeeting);
          } else {
            controller.createMeeting(newMeeting);
          }
        },
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String query = '';
        return AlertDialog(
          title: const Text('Pesquisar Reuniões'),
          content: TextField(
            onChanged: (value) {
              query = value;
            },
            decoration: const InputDecoration(
              hintText: 'Digite o título ou descrição',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                controller.searchMeetings(query);
                Navigator.pop(context);
              },
              child: const Text('Pesquisar'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(
              Icons.calendar_month,
              size: 50,
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Nenhuma reunião agendada',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Crie sua primeira reunião',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildMeetingCard(BuildContext context, MeetingModel meeting) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          Modular.to.pushNamed('/meeting-detail/${meeting.id}');
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          meeting.title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${DateFormat('dd/MM/yyyy').format(meeting.date)} • ${meeting.startTime} - ${meeting.endTime}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        if (meeting.location.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              meeting.location,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.primaryColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      PopupMenuButton(
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                            child: const Text('Editar'),
                            onTap: () {
                              Future.delayed(Duration.zero, () {
                                _showMeetingForm(context, meeting);
                              });
                            },
                          ),
                          PopupMenuItem(
                            child: const Text('Ver Detalhes'),
                            onTap: () {
                              Modular.to.pushNamed('/meeting-detail/${meeting.id}');
                            },
                          ),
                          PopupMenuItem(
                            child: const Text('Concluir'),
                            onTap: () {
                              controller.completeMeeting(meeting.id);
                            },
                          ),
                          PopupMenuItem(
                            child: const Text('Deletar'),
                            onTap: () {
                              controller.deleteMeeting(meeting.id);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              if (meeting.description.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    meeting.description,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}