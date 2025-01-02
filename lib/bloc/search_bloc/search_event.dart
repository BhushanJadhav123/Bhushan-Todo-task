import 'package:todo_task/dataModels/todo_model.dart';

class SearchEvent {
  final List<TodoEntry> todoList;
  final String searchedText;
  SearchEvent(this.todoList, this.searchedText);
}
