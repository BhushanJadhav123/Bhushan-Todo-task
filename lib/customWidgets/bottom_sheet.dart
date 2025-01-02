import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/bloc/todo_bloc/todo_bloc.dart';
import 'package:todo_task/bloc/todo_bloc/todo_event.dart';
import 'package:todo_task/bloc/todo_bloc/todo_state.dart';
import 'package:todo_task/customWidgets/alert_dialog.dart';
import 'package:todo_task/customWidgets/custom_buttons.dart';
import 'package:todo_task/customWidgets/custom_field.dart';
import 'package:todo_task/customWidgets/timer_dropdown.dart';
import 'package:todo_task/dataModels/todo_model.dart';

void addTodoBottomSheet(context) {
  String todoTitle = "";
  String discription = "";
  int minutes = 0;
  int second = 59;

  showModalBottomSheet(
      context: context,
      builder: (context) {
        final todoBlocState = BlocProvider.of<TodoBloc>(context).state;
        return SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            margin: const EdgeInsets.only(top: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Add Todos",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 14),

                // Title field
                CustomTextfield(
                  maxLines: 1,
                  text: "Enter title",
                  onCallBack: (title) {
                    todoTitle = title;
                  },
                ),
                const SizedBox(height: 10),

                // Discription field
                CustomTextfield(
                  text: "Enter Discription",
                  maxLines: 3,
                  onCallBack: (value) {
                    discription = value;
                  },
                ),

                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Select Timer:", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),

                // Minute field
                MinutesSelectionDropDown(
                  slectedTimerCallBack: (value) {
                    minutes = value;
                  },
                ),
                const SizedBox(height: 10),

                // Second field
                SecondSelectionDropDown(
                  slectedTimerCallBack: (value) {
                    second = value;
                  },
                ),
                const SizedBox(height: 30),

                // Save button
                SaveButtoWidget(
                  isLoading: todoBlocState is TodoLoadingState,
                  onPress: () {
                    if (discription == "" || todoTitle == "") {
                      return showAlertDialog(context);
                    }
                    // Creating new todo.
                    BlocProvider.of<TodoBloc>(context).add(
                      TodoCreateEvent(
                          TodoEntry(
                              title: todoTitle,
                              minute: minutes,
                              second: second,
                              discription: discription,
                              id: DateTime.timestamp().microsecondsSinceEpoch,
                              status: "Created"),
                          todoList: todoBlocState.todoList == null ||
                                  todoBlocState.todoList!.isEmpty
                              ? []
                              : todoBlocState.todoList),
                    );
                    Navigator.pop(context);
                  },
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      });
}
