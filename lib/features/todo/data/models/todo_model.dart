import '../../domain/entities/todo_entity.dart';

class TodoModel {
  final String id;
  final String title;
  final String description;
  final bool isPinned;
  final String color;
  final DateTime dueDate;
  final bool isCollaborative;  // Changed to `bool`

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isPinned,
    required this.color,
    required this.dueDate,
    required this.isCollaborative,
  });

  // Factory to create TodoModel from a Map
  factory TodoModel.fromMap(Map<dynamic, dynamic> map) {
    return TodoModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isPinned: map['isPinned'],
      color: map['color'],
      dueDate: DateTime.parse(map['dueDate']),  // Convert string to DateTime
      isCollaborative: map['isCollaborative'] as bool,  // Ensure it's a boolean
    );
  }

  // Method to convert TodoModel to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isPinned': isPinned,
      'color': color,
      'dueDate': dueDate.toIso8601String(),  // Convert DateTime to string
      'isCollaborative': isCollaborative,
    };
  }

  // Conversion method to TodoEntity
  TodoEntity toEntity() {
    return TodoEntity(
      id: id,
      title: title,
      description: description,
      isPinned: isPinned,
      color: color,
      dueDate: dueDate,
      isCollaborative: isCollaborative,
    );
  }

  // Factory to create TodoModel from TodoEntity
  factory TodoModel.fromEntity(TodoEntity entity) {
    return TodoModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      isPinned: entity.isPinned,
      color: entity.color,
      dueDate: entity.dueDate,
      isCollaborative: entity.isCollaborative,
    );
  }
}
