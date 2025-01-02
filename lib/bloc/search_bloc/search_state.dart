import 'package:todo_task/dataModels/todo_model.dart';

abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchingState extends SearchState {}

class SearchedState extends SearchState {
  List<TodoEntry> filterdList;
  SearchedState(this.filterdList);
}
