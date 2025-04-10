import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';

class UpdateTask {
  final TaskRepository repository;

  UpdateTask(this.repository);

  Future<void> call(Task task) async {
    await repository.updateTask(task);
  }
}
// Compare this snippet from lib/data/repositories/task_repository_impl.dart:
// // import 'package:task_manager/domain/repositories/task_repository.dart';