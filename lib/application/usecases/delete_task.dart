import '../../domain/repositories/task_repository.dart';

class DeleteTask {
  final TaskRepository repository;

  DeleteTask(this.repository);

  Future<void> call(int id) async {
    await repository.deleteTask(id);
  }
}
// // Compare this snippet from lib/data/repositories/task_repository_impl.dart:
// // import 'package:task_manager/domain/repositories/task_repository.dart';