import 'package:todo_task/dataModels/todo_model.dart';

abstract class TodoState {
  final List<TodoEntry>? todoList;
  TodoState({this.todoList});
}

class TodoInitialState extends TodoState {}

class TodoLoadedState extends TodoState {
  TodoLoadedState({super.todoList});
}

class TodoEmptyState extends TodoState {}

class TodoCreatedState extends TodoState {
  TodoCreatedState({required super.todoList});
}

class TodoDeletedState extends TodoState {
  TodoDeletedState({required super.todoList});
}

class TodoUpdatedState extends TodoState {
  TodoUpdatedState({required super.todoList});
}

class TodoLoadingState extends TodoState {}
