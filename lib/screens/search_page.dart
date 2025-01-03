import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/bloc/search_bloc/search_bloc.dart';
import 'package:todo_task/bloc/search_bloc/search_event.dart';
import 'package:todo_task/bloc/search_bloc/search_state.dart';
import 'package:todo_task/bloc/todo_bloc/todo_bloc.dart';
import 'package:todo_task/bloc/todo_bloc/todo_state.dart';
import 'package:todo_task/customWidgets/todo_card.dart';
import 'package:todo_task/dataModels/todo_model.dart';
import 'package:todo_task/screens/update_todo_page.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<TodoBloc, TodoState>(builder: (context, todoState) {
          return BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            if (View.of(context).viewInsets.bottom > 0.0) {
                              /// Hideing keyboard when keyboard is open.
                              FocusScope.of(context).unfocus();
                              return;
                            }
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          expands: false,
                          autofocus: true,
                          onChanged: (value) {
                            BlocProvider.of<SearchBloc>(context).add(
                                SearchEvent(todoState.todoList ?? [], value));
                          },
                          decoration: const InputDecoration(
                              hintText: "Search by Title"),
                        ),
                      ),
                    ],
                  ),
                  // ignore: prefer_const_constructors
                  SearchPageBuilder()
                ],
              );
            },
          );
        }),
      ),
    );
  }
}

class SearchPageBuilder extends StatelessWidget {
  const SearchPageBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<SearchBloc>(context).state;
    return Builder(builder: (_) {
      if (state is SearchInitialState) {
        return Container();
      } else if (state is SearchingState) {
        return const Center(child: CircularProgressIndicator());
      }
      final searchBlocState = (state as SearchedState);
      return searchBlocState.filterdList.isEmpty
          ? const Expanded(
              child: Center(
                child: Text("Item does not exist",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
            )
          : Expanded(
              child: ListView.builder(
                  shrinkWrap: false,
                  itemBuilder: (context, index) {
                    TodoEntry todoTask = searchBlocState.filterdList[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => UpdateTodoPage(
                                todoEntry:
                                    searchBlocState.filterdList[index])));
                      },
                      child: TodoCardWidget(todoTask,
                          todoEntryList: searchBlocState.filterdList),
                    );
                  },
                  itemCount: searchBlocState.filterdList.length),
            );
    });
  }
}
