import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/bloc/todo_bloc/todo_bloc.dart';
import 'package:todo_task/bloc/todo_bloc/todo_event.dart';
import 'package:todo_task/bloc/todo_bloc/todo_state.dart';
import 'package:todo_task/customWidgets/alert_dialog.dart';
import 'package:todo_task/customWidgets/custom_buttons.dart';
import 'package:todo_task/customWidgets/custom_field.dart';
import 'package:todo_task/customWidgets/timer_dropdown.dart';
import 'package:todo_task/customWidgets/toto_status.dart';
import 'package:todo_task/dataModels/database_handler.dart';
import 'package:todo_task/dataModels/todo_model.dart';

class UpdateTodoPage extends StatelessWidget {
  const UpdateTodoPage({super.key, required this.todoEntry});
  final TodoEntry todoEntry;

  @override
  Widget build(BuildContext context) {
    final List<TodoEntry> todoEntryList =
        BlocProvider.of<TodoBloc>(context).state.todoList ?? [];
    Map<String, dynamic> dataMap = todoEntry.toMap();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Update Todo",
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.blue,
      ),
      body: BlocListener<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoUpdatedState) {
            Navigator.of(context).pop();
          }
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                  // Title field
                  CustomTextfield(
                    text: "Enter title",
                    intitalText: todoEntry.title,
                    onCallBack: (title) {
                      dataMap[todoTitle] = title;
                      print("Title $title");
                    },
                  ),
                  const SizedBox(height: 10),

                  // Discription field
                  CustomTextfield(
                    text: "Enter Discription",
                    intitalText: todoEntry.discription,
                    maxLines: 3,
                    onCallBack: (discription) {
                      dataMap[todoDiscription] = discription;
                      print("Discription $discription");
                    },
                  ),
                  const SizedBox(height: 20),

                  // Status field
                  const Text("Select Status:", style: TextStyle(fontSize: 18)),
                  TodoStatusDropDownWidget(
                    selectedStatus: dataMap[todoStatus],
                    onStatusCallBack: (TodoStatus? status) {
                      final selectedStatus =
                          TodoStatus.values[status!.index].name;
                      dataMap[todoStatus] = selectedStatus.replaceFirst(
                          selectedStatus[0], selectedStatus[0].toUpperCase());
                    },
                  ),
                  const SizedBox(height: 20),

                  // Time field
                  const Text("Select Time:", style: TextStyle(fontSize: 18)),
                  MinutesSelectionDropDown(
                      slectedTimerCallBack: (value) {
                        dataMap[todoMinute] = value;
                      },
                      selectedMinute: todoEntry.minute),
                  const SizedBox(height: 10),

                  SecondSelectionDropDown(
                      slectedTimerCallBack: (value) {
                        dataMap[todoSecond] = value;
                      },
                      selectedSecond: todoEntry.second),
                  const SizedBox(height: 40),

                  // Update button
                  SaveButtoWidget(
                    buttonText: "Update",
                    onPress: () {
                      if (dataMap[todoTitle] == "" ||
                          dataMap[todoDiscription] == "") {
                        showAlertDialog(context);
                        return;
                      }
                      BlocProvider.of<TodoBloc>(context).add(
                        TodoUpdateEvent(
                            updatedTodo: TodoEntry.toTodoEntry(dataMap),
                            todoList: todoEntryList),
                      );
                    },
                  )
                  // CustomTextfield()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
