import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/controllers/todo_controller.dart';
import 'package:test_app/screens/components/add_todo_card.dart';
import 'package:test_app/screens/components/api_card.dart';
import 'package:test_app/screens/components/task_header.dart';
import 'package:test_app/screens/components/todo_list.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  
  final controller = Get.put(TodoController());
  final titleController = TextEditingController();
  final completed = false.obs;

  void _handleAddTask(BuildContext context) {
    final theme = Theme.of(context);
    final title = titleController.text.trim();
    
    if (title.isEmpty) {
      Get.snackbar(
        "Error",
        "Task title cannot be empty",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
        margin: const EdgeInsets.all(8),
        borderRadius: 8,
      );
      return;
    }
    
    controller.addTodo(title);
    titleController.clear();
    completed.value = false;
    
    Get.snackbar(
      "Success",
      "Task added successfully",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade400,
      colorText: Colors.white,
      margin: const EdgeInsets.all(8),
      borderRadius: 8,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Task Manager',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: theme.primaryColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AddTodoCard(
              titleController: titleController,
              completed: completed,
              onAdd: () => _handleAddTask(context),
            ),
            const SizedBox(height: 20),
            const TasksHeader(),
            const SizedBox(height: 8),
            TodoListView(controller: controller),
            const SizedBox(height: 20),
            const ApiTasksSection(),
          ],
        ),
      ),
    );
  }
}