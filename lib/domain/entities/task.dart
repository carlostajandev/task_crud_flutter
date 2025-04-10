class Task {
  final int id;
  final String title;
  final String description;
  bool isDone; // Added isDone field
  final bool isCompleted;
  final DateTime date;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.isDone, // Added isDone parameter
    required this.isCompleted,
    required this.date,
  });

  Task copyWith({
    int? id,
    String? title,
    String? description,
    bool? isDone,
    bool? isCompleted,
    DateTime? date,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      isCompleted: isCompleted ?? this.isCompleted,
      date: date ?? this.date,
    );
  }
}

// This code defines a Task entity with properties such as id, title, description, isDone, isCompleted, and date.
// It also includes a copyWith method to create a new Task instance with modified properties while keeping the rest unchanged.
