import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/bloc/todo_bloc/todo_bloc.dart';
import 'package:todo_task/bloc/todo_bloc/todo_event.dart';
import 'package:todo_task/customWidgets/custom_buttons.dart';
import 'package:todo_task/customWidgets/todo_timer.dart';
import 'package:todo_task/customWidgets/toto_status.dart';
import 'package:todo_task/dataModels/todo_model.dart';

class TodoCardWidget extends StatelessWidget {
  final TodoEntry todoEntryTask;
  final List<TodoEntry> todoEntryList;
  final bool usedForSearching;
  const TodoCardWidget(this.todoEntryTask,
      {super.key, required this.todoEntryList, this.usedForSearching = false});

  @override
  Widget build(BuildContext context) {
    final bool isTodoRunning =
        todoEntryTask.status == TodoStatus.values[1].name.toCapitalized;
    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 12.0, bottom: 6, top: 10, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Todo title
            Text(todoEntryTask.title,
                overflow: TextOverflow.clip,
                maxLines: 2,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
            const SizedBox(height: 4),

            // Todo discription
            Text(todoEntryTask.discription,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Status of Todo
                Chip(
                  backgroundColor:
                      isTodoRunning ? Colors.redAccent : Colors.green,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.all(0),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  side: BorderSide.none,
                  label: Text("Status: ${todoEntryTask.status}",
                      style: const TextStyle(fontSize: 14)),
                ),

                // Delete button
                DeleteButtoWidget(
                  deleteOnPress: () {
                    BlocProvider.of<TodoBloc>(context).add(
                        TodoDeletEvent(todoEntryTask, todoList: todoEntryList));
                  },
                ),

                // Todo timer
                TodoTimer(todoEntryTask: todoEntryTask)
              ],
            )
          ],
        ),
      ),
    );
  }
}
