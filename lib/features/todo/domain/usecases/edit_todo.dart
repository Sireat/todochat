import '../../data/repositories/todo_repository.dart';
import '../entities/todo_entity.dart';

class EditTodo {
  final TodoRepository repository;

  EditTodo(this.repository);

  Future<void> call(TodoEntity todo) {
    return repository.editTodo(todo);
  }
}