import 'package:flutter/material.dart';
import 'package:todo_task/dataModels/todo_model.dart';

class TodoTimer extends StatelessWidget {
  const TodoTimer({
    super.key,
    required this.todoEntryTask,
  });

  final TodoEntry todoEntryTask;

  @override
  Widget build(BuildContext context) {
    // Adding zero if second length is 1.
    final String seconds = todoEntryTask.second.toString().length == 1
        ? "0${todoEntryTask.second}"
        : "${todoEntryTask.second}";
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.black,
          radius: 28,
          child: Text(
            "${todoEntryTask.minute}:$seconds",
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const Text(
          "Selected Time",
          style: TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
