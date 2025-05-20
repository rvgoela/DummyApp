import 'package:flutter/material.dart';

class TasksHeader extends StatelessWidget {
  const TasksHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Icon(
            Icons.check_box,
            color: theme.primaryColor,
            size: 24,
          ),
          const SizedBox(width: 12),
          Text(
            'My Tasks',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.primaryColorDark,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}