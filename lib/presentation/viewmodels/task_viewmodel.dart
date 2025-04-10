import 'package:flutter/material.dart';

import '../../domain/entities/task.dart';
import '../../application/usecases/get_all_tasks.dart';
import '../../application/usecases/create_task.dart';
import '../../application/usecases/update_task.dart';
import '../../application/usecases/delete_task.dart';

class TaskViewModel extends ChangeNotifier {
  final GetAllTasks getAllTasks;
  final CreateTask createTask;
  final UpdateTask updateTask;
  final DeleteTask deleteTask;

  List<Task> tasks = [];

  TaskViewModel({
    required this.getAllTasks,
    required this.createTask,
    required this.updateTask,
    required this.deleteTask,
  });

  Future<void> loadTasks() async {
    tasks = await getAllTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await createTask(task);
    await loadTasks();
  }

  Future<void> editTask(Task task) async {
    await updateTask(task);
    await loadTasks();
  }

  Future<void> removeTask(int id) async {
    await deleteTask(id);
    await loadTasks();
  }

  void toggleTaskStatus(int index) {
    tasks[index].isDone = !tasks[index].isDone;
    notifyListeners();
  }
}

// This code defines a TaskViewModel class that manages the state of tasks in a Flutter application. It uses the GetAllTasks, CreateTask, UpdateTask, and DeleteTask use cases to perform CRUD operations on tasks. The loadTasks method fetches all tasks from the repository and notifies listeners of changes. The addTask, editTask, and removeTask methods perform their respective operations and refresh the task list afterward.
// The TaskViewModel class extends ChangeNotifier, allowing it to notify its listeners when the task list changes. This is useful for updating the UI in response to changes in the underlying data. The use of use cases promotes a clean architecture by separating business logic from presentation logic.
