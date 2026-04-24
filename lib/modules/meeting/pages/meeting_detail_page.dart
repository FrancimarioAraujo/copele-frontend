import 'package:copelefrontend/modules/meeting/controllers/meetings_controller.dart';
import 'package:copelefrontend/modules/meeting/models/meeting_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:copelefrontend/theme/app_theme.dart';
import 'package:intl/intl.dart';

class MeetingDetailPage extends StatefulWidget {
  final String meetingId;

  const MeetingDetailPage({Key? key, required this.meetingId}) : super(key: key);

  @override
  State<MeetingDetailPage> createState() => _MeetingDetailPageState();
}

class _MeetingDetailPageState extends State<MeetingDetailPage> {
  final controller = Modular.get<MeetingsController>();
  MeetingModel? meeting;

  @override
  void initState() {
    super.initState();
    _loadMeeting();
  }

  Future<void> _loadMeeting() async {
    meeting = await controller.getMeetingById(widget.meetingId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (meeting == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Reunião não encontrada')),
        body: const Center(child: Text('Reunião não encontrada')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(meeting!.title),
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                meeting!.title,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 8),
              Text(
                '${DateFormat('dd/MM/yyyy').format(meeting!.date)} • ${meeting!.startTime} - ${meeting!.endTime}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (meeting!.location.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    meeting!.location,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
              if (meeting!.description.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    meeting!.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
