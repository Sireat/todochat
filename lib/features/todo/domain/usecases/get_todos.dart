import '../../data/repositories/todo_repository.dart';
import '../entities/todo_entity.dart';

class GetTodos {
  final TodoRepository repository;

  GetTodos(this.repository);

  Stream<List<TodoEntity>> call() {
    return repository.getTodos();
  }
}