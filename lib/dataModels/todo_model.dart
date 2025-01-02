import 'package:todo_task/dataModels/database_handler.dart';

class TodoEntry {
  final int id;
  final String title;
  final int minute;
  final int second;
  final String discription;
  final String status;

  TodoEntry(
      {required this.id,
      required this.title,
      required this.minute,
      required this.second,
      required this.discription,
      required this.status});

  Map<String, Object?> toMap() {
    return {
      todoTitle: title,
      columnId: id,
      todoDiscription: discription,
      todoMinute: minute,
      todoSecond: second,
      todoStatus: status
    };
  }

  static TodoEntry toTodoEntry(Map<String, dynamic> data) {
    return TodoEntry(
      id: data[columnId],
      title: data[todoTitle],
      second: data[todoSecond],
      discription: data[todoDiscription],
      minute: data[todoMinute],
      status: data[todoStatus],
    );
  }
}

/// This extention convert string into
extension CamleCaseString on String {
  String get toCapitalized =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
}
