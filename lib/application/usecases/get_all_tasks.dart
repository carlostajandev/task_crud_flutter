import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';

class GetAllTasks {
  final TaskRepository repository;

  GetAllTasks(this.repository);

  Future<List<Task>> call() async {
    return await repository.getAllTasks();
  }
}
// Compare this snippet from lib/data/repositories/task_repository_impl.dart:
// import 'package:task_manager/domain/repositories/task_repository.dart';