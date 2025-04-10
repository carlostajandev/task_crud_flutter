import '../../../domain/entities/task.dart';
import '../../../domain/repositories/task_repository.dart';
import '../datasource/task_dao.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskDao taskDao;

  TaskRepositoryImpl(this.taskDao);

  @override
  Future<void> createTask(Task task) async {
    await taskDao.insertTask(task);
  }

  @override
  Future<void> deleteTask(int id) async {
    await taskDao.deleteTask(id);
  }

  @override
  Future<List<Task>> getAllTasks() async {
    return await taskDao.getAllTasks();
  }

  @override
  Future<void> updateTask(Task task) async {
    await taskDao.updateTask(task);
  }
}
