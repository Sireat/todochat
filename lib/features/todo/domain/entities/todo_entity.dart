class TodoEntity {
  final String id;
  final String title;
  final String description;
  final bool isPinned;
  final DateTime dueDate;
  final String color;
  final bool isCollaborative;

  TodoEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.isPinned,
    required this.dueDate,
    required this.color,
    required this.isCollaborative,
  });
}
