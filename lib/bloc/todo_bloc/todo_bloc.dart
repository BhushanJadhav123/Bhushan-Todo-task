import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/bloc/todo_bloc/todo_event.dart';
import 'package:todo_task/bloc/todo_bloc/todo_state.dart';
import 'package:todo_task/dataModels/database_handler.dart';
import 'package:todo_task/dataModels/todo_model.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitialState()) {
    final databasehandler = DataBaseHander();

    /// Create event
    on<TodoCreateEvent>(
      (event, emit) {
        try {
          emit(TodoLoadingState());

          databasehandler.insertTodo(event.todoEntry);

          // We are getting old todo list from [TodoCreateEvent], and adding new todoEntry
          // in this list for showing updated data on UI side.
          List<TodoEntry> newTodoList = event.todoList!;
          newTodoList.insert(0, event.todoEntry);

          return emit(TodoCreatedState(todoList: newTodoList.toList()));
        } catch (e) {
          debugPrint("ERROR $e");
        }
      },
    );

    /// Fetch all locally stored Todos.
    on<TodoFetchEvent>(
      (event, emit) async {
        try {
          List<TodoEntry> todoEntries = [];
          emit(TodoLoadingState());

          final List data = await databasehandler.getTodoList();
          if (data.isEmpty) return emit(TodoEmptyState());
          for (Map dataMap in data) {
            todoEntries.add(
              TodoEntry(
                  title: dataMap[todoTitle],
                  minute: dataMap[todoMinute],
                  second: dataMap[todoSecond],
                  discription: dataMap[todoDiscription],
                  status: dataMap[todoStatus],
                  id: dataMap[columnId]),
            );
          }
          return emit(TodoLoadedState(todoList: todoEntries.reversed.toList()));
        } catch (e) {
          debugPrint("FetchERROR $e");
        }
      },
    );

    // Delete event
    on<TodoDeletEvent>((event, emit) async {
      try {
        await databasehandler.deleteTodo(event.todoEntry.id);
        List<TodoEntry> newTodoList = event.todoList ?? [];

        // Removing todo from local variable for ui purpose.
        newTodoList.removeWhere((item) {
          return item.id == event.todoEntry.id;
        });

        emit(TodoDeletedState(todoList: newTodoList));
      } catch (e) {
        debugPrint("DELETE ERROR $e");
      }
    });

    // Update event
    on<TodoUpdateEvent>(
      (event, emit) {
        try {
          databasehandler.updateTodo(event.updatedTodo);

          // Get index of todo which we are updating,
          final int index = event.todoList!
              .indexWhere((element) => element.id == event.updatedTodo.id);

          // Remove old todo from list of todos.
          event.todoList!.removeAt(index);

          // Inserting updated todo in todos list
          event.todoList!.insert(index, event.updatedTodo);

          emit(TodoUpdatedState(todoList: event.todoList!));
        } catch (e) {
          debugPrint("Update Error $e");
        }
      },
    );
  }
}
