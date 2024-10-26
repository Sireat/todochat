import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/todo_entity.dart';
import '../provider/todo_provider.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: StreamBuilder<List<TodoEntity>>(
        stream: Provider.of<TodoProvider>(context, listen: false).fetchTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading todos'));
          }

          final todos = snapshot.data;

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
            ),
            itemCount: todos!.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return Card(
                color: Colors.yellow,
                child: ListTile(
                  title: Text(todo.title),
                  subtitle: Text(todo.description),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
