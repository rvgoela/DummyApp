import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/controllers/todo_controller.dart';

class ApiTasksSection extends StatelessWidget {
  const ApiTasksSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TodoController>();
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton.icon(
            onPressed: controller.fetchApiTodos,
            icon: const Icon(Icons.cloud_download),
            label: const Text('Fetch API Tasks'),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.cloud, size: 20, color: theme.primaryColor),
              const SizedBox(width: 8),
              Text(
                'External Tasks',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Obx(() {
            if (controller.apiTodos.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Column(
                    children: [
                      Icon(Icons.cloud_off, color: theme.disabledColor),
                      const SizedBox(height: 8),
                      Text(
                        'No external tasks',
                        style: TextStyle(
                          color: theme.hintColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: controller.apiTodos.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                final todo = controller.apiTodos[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
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
                      onTap: () {
                        Get.snackbar(
                          'Task Details',
                          '${todo.title}\nCompleted: ${todo.completed ? "Yes" : "No"}',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.black87,
                          colorText: Colors.white,
                          margin: const EdgeInsets.all(8),
                          borderRadius: 8,
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}