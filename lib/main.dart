import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'infrastructure/repositories/task_repository_impl.dart';
import 'domain/repositories/task_repository.dart'; // Add this import
import 'application/usecases/get_all_tasks.dart';
import 'application/usecases/create_task.dart';
import 'application/usecases/update_task.dart';
import 'application/usecases/delete_task.dart';
import 'presentation/viewmodels/task_viewmodel.dart';
import 'presentation/pages/task_list_screen.dart'; // Importa la vista aquí
import 'infrastructure/datasource/task_dao.dart'; // Import AppDatabase
import 'infrastructure/datasource/app_database.dart'; // Import AppDatabase

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the database and dependencies
  final db = await AppDatabase.instance.database;
  final taskDao = TaskDao(db);
  final TaskRepository repository = TaskRepositoryImpl(taskDao);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create:
              (_) => TaskViewModel(
                getAllTasks: GetAllTasks(repository),
                createTask: CreateTask(repository),
                updateTask: UpdateTask(repository),
                deleteTask: DeleteTask(repository),
              )..loadTasks(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const TaskListScreen(),
    );
  }
}

// // This code is the main entry point of a Flutter application that implements a task management system. It sets up the application with a clean architecture by using the Provider package for state management and dependency injection. The TaskRepositoryImpl class is used to interact with the data layer, while the use cases (GetAllTasks, CreateTask, UpdateTask, DeleteTask) encapsulate the business logic for managing tasks. The TaskViewModel class acts as a bridge between the UI and the use cases, providing methods to load, add, edit, and remove tasks. Finally, the TaskListScreen widget displays the list of tasks in the UI. The application is structured to promote separation of concerns and maintainability.
// // The main function initializes the application by creating an instance of TaskRepositoryImpl and setting up a MultiProvider to manage the state of the application. The TaskViewModel is created with the necessary use cases and is set to load tasks initially. The MyApp widget sets up the MaterialApp with a title, theme, and home screen, which is the TaskListScreen that displays the list of tasks. This structure allows for easy expansion and modification of the application in the future.
