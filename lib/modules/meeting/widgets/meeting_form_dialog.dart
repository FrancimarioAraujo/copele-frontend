import 'package:copelefrontend/modules/meeting/models/meeting_model.dart';
import 'package:flutter/material.dart';
import 'package:copelefrontend/theme/app_theme.dart';


class MeetingFormDialog extends StatefulWidget {
  final MeetingModel? meeting;
  final Function(MeetingModel) onSave;

  const MeetingFormDialog({
    Key? key,
    this.meeting,
    required this.onSave,
  }) : super(key: key);

  @override
  State<MeetingFormDialog> createState() => _MeetingFormDialogState();
}

class _MeetingFormDialogState extends State<MeetingFormDialog> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController locationController;
  late TextEditingController startTimeController;
  late TextEditingController endTimeController;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.meeting?.title ?? '');
    descriptionController = TextEditingController(text: widget.meeting?.description ?? '');
    locationController = TextEditingController(text: widget.meeting?.location ?? '');
    startTimeController = TextEditingController(text: widget.meeting?.startTime ?? '09:00');
    endTimeController = TextEditingController(text: widget.meeting?.endTime ?? '10:00');
    selectedDate = widget.meeting?.date ?? DateTime.now();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    super.dispose();
  }

  void _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _selectTime(TextEditingController controller) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      controller.text = picked.format(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      insetPadding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.meeting != null ? 'Editar Reunião' : 'Nova Reunião',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 24),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Título',
                  hintText: 'Ex: Reunião de Planejamento',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  hintText: 'Descreva o objetivo da reunião',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: locationController,
                decoration: InputDecoration(
                  labelText: 'Local',
                  hintText: 'Ex: Sala 101 ou Google Meet',
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _selectDate,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Data',
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                  child: Text(
                    '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectTime(startTimeController),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Início',
                          suffixIcon: const Icon(Icons.access_time),
                        ),
                        child: Text(startTimeController.text),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectTime(endTimeController),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Fim',
                          suffixIcon: const Icon(Icons.access_time),
                        ),
                        child: Text(endTimeController.text),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      final meeting = MeetingModel(
                        id: widget.meeting?.id ?? '',
                        title: titleController.text,
                        description: descriptionController.text,
                        date: selectedDate,
                        startTime: startTimeController.text,
                        endTime: endTimeController.text,
                        location: locationController.text,
                        isCompleted: widget.meeting?.isCompleted ?? false,
                        createdAt: widget.meeting?.createdAt ?? DateTime.now(),
                        updatedAt: DateTime.now(),
                      );
                      widget.onSave(meeting);
                      Navigator.pop(context);
                    },
                    child: const Text('Salvar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
