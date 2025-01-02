import 'package:todo_task/dataModels/todo_model.dart';

abstract class TodoEvent {
  final List<TodoEntry>? todoList;
  TodoEvent({this.todoList});
}

class TodoCreateEvent extends TodoEvent {
  final TodoEntry todoEntry;
  TodoCreateEvent(this.todoEntry, {super.todoList});
}

class TodoUpdateEvent extends TodoEvent {
  final TodoEntry updatedTodo;
  TodoUpdateEvent({required super.todoList, required this.updatedTodo});
}

class TodoDeletEvent extends TodoEvent {
  final TodoEntry todoEntry;
  TodoDeletEvent(this.todoEntry, {super.todoList});
}

class TodoFetchEvent extends TodoEvent {}
