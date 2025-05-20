import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/controllers/todo_controller.dart';

class TodoListView extends StatelessWidget {
  final TodoController controller;

  const TodoListView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(() {
      if (controller.todos.isEmpty) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle_outline, size: 28, color: theme.disabledColor),
              const SizedBox(height: 12),
              Text(
                'No tasks yet',
                style: TextStyle(
                  fontSize: 16,
                  color: theme.hintColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        itemCount: controller.todos.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          final todo = controller.todos[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Dismissible(
              key: UniqueKey(),
              background: Container(
                decoration: BoxDecoration(
                  color: Colors.red.shade400,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (_) {
                Get.snackbar(
                  'Task Deleted',
                  '${todo.title} was removed',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red.shade400,
                  colorText: Colors.white,
                  margin: const EdgeInsets.all(8),
                  borderRadius: 8,
                );
                controller.deleteTodo(index);
              },
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  onTap: () => controller.toggleTodo(index),
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      decoration: todo.completed ? TextDecoration.lineThrough : null,
                      color: todo.completed ? theme.hintColor : null,
                      fontWeight: todo.completed ? FontWeight.normal : FontWeight.w500,
                    ),
                  ),
                  trailing: Icon(
                    todo.completed ? Icons.check_circle : Icons.circle_outlined,
                    color: todo.completed ? theme.primaryColor : theme.disabledColor,
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}