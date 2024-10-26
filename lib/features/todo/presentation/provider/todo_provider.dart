
import 'package:flutter/material.dart';

import '../../domain/entities/todo_entity.dart';
import '../../domain/usecases/add_todo.dart';
import '../../domain/usecases/edit_todo.dart';
import '../../domain/usecases/get_todos.dart';

class TodoProvider with ChangeNotifier {
  final AddTodo addTodo;
  final GetTodos getTodos;
  final EditTodo editTodo;

  TodoProvider(this.addTodo, this.getTodos, this.editTodo);

  Stream<List<TodoEntity>> fetchTodos() {
    return getTodos.call();
  }

  Future<void> addNewTodo(TodoEntity todo) async {
    await addTodo.call(todo);
    notifyListeners();
  }

  Future<void> updateTodo(TodoEntity todo) async {
    await editTodo.call(todo);
    notifyListeners();
  }
}
