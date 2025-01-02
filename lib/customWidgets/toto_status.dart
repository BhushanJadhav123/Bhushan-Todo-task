import 'package:flutter/material.dart';
import 'package:todo_task/dataModels/todo_model.dart';

enum TodoStatus { created, running, paused, completed }

// ignore: must_be_immutable
class TodoStatusDropDownWidget extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  TodoStatusDropDownWidget(
      {super.key, required this.onStatusCallBack, this.selectedStatus});

  final Function(TodoStatus?) onStatusCallBack;
  final String? selectedStatus;

  @override
  State<TodoStatusDropDownWidget> createState() =>
      _TodoStatusDropDownWidgetState();
}

class _TodoStatusDropDownWidgetState extends State<TodoStatusDropDownWidget> {
  late String selectedValue;

  final List<String> itemList = [
    'Created',
    'Running',
    'Paused',
    'Completed',
  ];
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    selectedValue = widget.selectedStatus == null
        ? itemList[0]
        : widget.selectedStatus.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue,
      ),
      child: DropdownButton<String>(
        padding: EdgeInsets.symmetric(horizontal: 12),
        style: TextStyle(fontSize: 20, color: Colors.black),
        underline: Container(),
        focusColor: Colors.blue,
        alignment: Alignment.bottomCenter,
        dropdownColor: Colors.white,
        isExpanded: true,
        elevation: 10,
        value: selectedValue,
        items: itemList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (newStatus) {
          setState(() {
            selectedValue = newStatus ?? TodoStatus.created.name.toCapitalized;
            // Setting callback according to status of Todo.
            if (newStatus == TodoStatus.created.name.toCapitalized) {
              widget.onStatusCallBack(TodoStatus.created);
            } else if (newStatus == TodoStatus.running.name.toCapitalized) {
              widget.onStatusCallBack(TodoStatus.running);
            } else if (newStatus == TodoStatus.paused.name.toCapitalized) {
              widget.onStatusCallBack(TodoStatus.paused);
            } else if (newStatus == TodoStatus.completed.name.toCapitalized) {
              widget.onStatusCallBack(TodoStatus.completed);
            }
          });
        },
      ),
    );
  }
}
