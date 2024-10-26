import '../../data/repositories/todo_repository.dart';
import '../entities/todo_entity.dart';

class AddTodo {
  final TodoRepository repository;

  AddTodo(this.repository);

  Future<void> call(TodoEntity todo) {
    return repository.addTodo(todo);
  }
}