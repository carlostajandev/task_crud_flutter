import 'package:sqflite/sqflite.dart';
import '../../../domain/entities/task.dart';

class TaskDao {
  final Database db;

  TaskDao(this.db);

  Future<void> insertTask(Task task) async {
    await db.insert('tasks', {
      'id': task.id,
      'title': task.title,
      'description': task.description,
      'isDone': task.isDone ? 1 : 0,
      'isCompleted': task.isCompleted ? 1 : 0,
      'date': task.date.toIso8601String(),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Task>> getAllTasks() async {
    final List<Map<String, dynamic>> maps = await db.query('tasks');

    return maps
        .map(
          (map) => Task(
            id: map['id'],
            title: map['title'],
            description: map['description'],
            isDone: map['isDone'] == 1,
            isCompleted: map['isCompleted'] == 1,
            date: DateTime.parse(map['date']),
          ),
        )
        .toList();
  }

  Future<void> updateTask(Task task) async {
    await db.update(
      'tasks',
      {
        'title': task.title,
        'description': task.description,
        'isDone': task.isDone ? 1 : 0,
        'isCompleted': task.isCompleted ? 1 : 0,
        'date': task.date.toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(int id) async {
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
