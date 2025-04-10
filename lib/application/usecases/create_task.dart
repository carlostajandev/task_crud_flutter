import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';

class CreateTask {
  final TaskRepository repository;

  CreateTask(this.repository);

  Future<void> call(Task task) async {
    await repository.createTask(task);
  }
}
// Compare this snippet from lib/data/repositories/task_repository_impl.dart:
// import 'package:task_manager/domain/entities/task.dart';