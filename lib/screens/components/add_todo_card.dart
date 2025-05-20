import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTodoCard extends StatelessWidget {
  final TextEditingController titleController;
  final RxBool completed;
  final VoidCallback onAdd;

  const AddTodoCard({
    super.key,
    required this.titleController,
    required this.completed,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: theme.primaryColor.withOpacity(0.3),
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add New Task',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.primaryColorDark,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Task Title',
                prefixIcon: Icon(Icons.task_alt, color: theme.primaryColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: theme.primaryColor, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
              cursorColor: theme.primaryColor,
            ),
            const SizedBox(height: 16),
            Obx(
              () => CheckboxListTile(
                activeColor: theme.primaryColor,
                checkColor: Colors.white,
                contentPadding: EdgeInsets.zero,
                dense: true,
                title: Text(
                  'Mark as Completed',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: theme.primaryColorDark,
                  ),
                ),
                value: completed.value,
                onChanged: (val) => completed.value = val ?? false,
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onAdd,
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                shadowColor: theme.primaryColor.withOpacity(0.4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.add_task, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Add Task',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}