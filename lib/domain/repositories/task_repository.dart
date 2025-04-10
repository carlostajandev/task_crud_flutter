import '../entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getAllTasks();
  Future<void> createTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(int id);
}
// Compare this snippet from lib/data/repositories/task_repository_impl.dart:
// import 'package:task_manager/domain/entities/task.dart';