import 'package:get/get.dart';
import 'package:test_app/models/todo_model.dart';

class TodoController extends GetxController {
  RxList<Todo> todos = <Todo>[].obs;
  RxList<Todo> apiTodos = <Todo>[].obs;

  void loadTodosFromMemory() {
    todos.assignAll([
      Todo(title: 'Task 1', completed: false),
      Todo(title: 'Task 2', completed: true),
    ]);
  }

  void addTodo(String title, {bool completed = false}) {
    final todo = Todo(title: title, completed: completed);
    todos.add(todo);
  }

  void toggleTodo(int index) {
    final todo = todos[index];
    final updatedTodo = Todo(
      title: todo.title,
      completed: !todo.completed,
    );

    todos[index] = updatedTodo;
  }

  void deleteTodo(int index) {
    todos.removeAt(index);
  }

  void fetchApiTodos() {
    apiTodos.assignAll([
      Todo(title: 'API Task 1', completed: false),
      Todo(title: 'API Task 2', completed: true),
    ]);
  }
}
