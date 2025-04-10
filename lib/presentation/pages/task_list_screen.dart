import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/task_viewmodel.dart';
import 'create_task_screen.dart'; // Ensure this file contains the CreateTaskScreen class

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TaskViewModel>(context, listen: false).loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body:
          taskViewModel.tasks.isEmpty
              ? const Center(child: Text('No tasks yet'))
              : ListView.builder(
                itemCount: taskViewModel.tasks.length,
                itemBuilder: (context, index) {
                  final task = taskViewModel.tasks[index];
                  return Dismissible(
                    key: Key(task.id.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (_) {
                      taskViewModel.removeTask(task.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Task deleted')),
                      );
                    },
                    child: ListTile(
                      title: Text(task.title),
                      subtitle: Text(task.description),
                      trailing: Checkbox(
                        value: task.isDone,
                        onChanged: (value) {
                          taskViewModel.toggleTaskStatus(index);
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => CreateTaskScreen(existingTask: task),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CreateTaskScreen()),
            ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
