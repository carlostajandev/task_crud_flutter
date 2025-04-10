import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/task_viewmodel.dart';
import '../../domain/entities/task.dart'; // Adjust the path based on your project structure

class CreateTaskScreen extends StatefulWidget {
  final Task? existingTask;

  CreateTaskScreen({super.key, this.existingTask});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.existingTask?.title ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.existingTask?.description ?? '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingTask != null;
    final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Task' : 'Create Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator:
                    (value) => value!.isEmpty ? 'Title is required' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator:
                    (value) =>
                        value!.isEmpty ? 'Description is required' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final updatedTask = Task(
                      id:
                          widget.existingTask?.id ??
                          DateTime.now().millisecondsSinceEpoch,
                      title: _titleController.text,
                      description: _descriptionController.text,
                      isDone: widget.existingTask?.isDone ?? false,
                      isCompleted: widget.existingTask?.isCompleted ?? false,
                      date: DateTime.now(),
                    );

                    if (isEditing) {
                      taskViewModel.editTask(updatedTask);
                    } else {
                      taskViewModel.addTask(updatedTask);
                    }

                    Navigator.pop(context);
                  }
                },
                child: Text(isEditing ? 'Save Changes' : 'Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
