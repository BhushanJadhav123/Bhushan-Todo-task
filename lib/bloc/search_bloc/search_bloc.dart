import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/bloc/search_bloc/search_event.dart';
import 'package:todo_task/bloc/search_bloc/search_state.dart';
import 'package:todo_task/dataModels/todo_model.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitialState()) {
    on<SearchEvent>(
      (event, emit) {
        emit(SearchingState());
        List<TodoEntry> filteredList = [];
        // Filtereing item on the basis of their title.
        filteredList = event.todoList
            .where((element) => element.title
                .toLowerCase()
                .contains(event.searchedText.toLowerCase()))
            .toList();

        return emit(SearchedState(filteredList));
      },
    );
  }
}
