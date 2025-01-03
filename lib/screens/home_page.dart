import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/bloc/search_bloc/search_bloc.dart';
import 'package:todo_task/bloc/todo_bloc/todo_bloc.dart';
import 'package:todo_task/bloc/todo_bloc/todo_event.dart';
import 'package:todo_task/bloc/todo_bloc/todo_state.dart';
import 'package:todo_task/customWidgets/bottom_sheet.dart';
import 'package:todo_task/customWidgets/todo_card.dart';
import 'package:todo_task/dataModels/todo_model.dart';
import 'package:todo_task/screens/search_page.dart';
import 'package:todo_task/screens/update_todo_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            addTodoBottomSheet(context);
          },
          backgroundColor: Colors.blue,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          )),
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black, size: 44),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider(
                          create: (context) => SearchBloc(),
                          child: const SearchPage())));
            },
          )
        ],
        title: const Text(
          "Home page",
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.blue,
      ),
      body: BlocConsumer<TodoBloc, TodoState>(listener: (context, state) {
        if (state is TodoDeletedState) {
          BlocProvider.of<TodoBloc>(context).add(TodoFetchEvent());
        }
      }, builder: (context, state) {
        return state is! TodoLoadingState
            ? HomeTodoBodyStateWidget(state: state)
            : const Center(child: CircularProgressIndicator(color: Colors.red));
      }),
    );
  }
}

class HomeTodoBodyStateWidget extends StatelessWidget {
  const HomeTodoBodyStateWidget({super.key, required this.state});
  final TodoState state;
  @override
  Widget build(BuildContext context) {
    final todoBlocState = state;
    if (todoBlocState is TodoEmptyState ||
        todoBlocState.todoList == null ||
        todoBlocState.todoList!.isEmpty) {
      return const Center(
        child: Text("Don't created any todo yet."),
      );
    }
    final loadedState = todoBlocState;
    return ListView.builder(
        itemBuilder: (context, index) {
          TodoEntry todoTask = loadedState.todoList![index];
          return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateTodoPage(
                              todoEntry: loadedState.todoList![index],
                            )));
              },
              child: TodoCardWidget(todoTask,
                  todoEntryList: loadedState.todoList!));
        },
        itemCount: loadedState.todoList!.length);
  }
}
