import 'package:firebase_database/firebase_database.dart';
import '../../domain/entities/todo_entity.dart';
import '../models/todo_model.dart';

class TodoRepository {
  final DatabaseReference database = FirebaseDatabase.instance.ref().child('todos');

  Future<void> addTodo(TodoEntity todo) async {
    await database.push().set(TodoModel.fromEntity(todo).toMap());
  }

  Stream<List<TodoEntity>> getTodos() {
    return database.onValue.map((event) {
      final todosMap = event.snapshot.value as Map<dynamic, dynamic>?; // Handle null safety
      if (todosMap == null) {
        return <TodoEntity>[];
      }
      return todosMap.values.map((e) {
        final todoModel = TodoModel.fromMap(e);
        return todoModel.toEntity(); // Convert TodoModel to TodoEntity
      }).toList();
    });
  }

  Future<void> editTodo(TodoEntity todo) async {
    await database.child(todo.id).update(TodoModel.fromEntity(todo).toMap());
  }
}
