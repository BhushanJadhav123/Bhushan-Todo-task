import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_task/dataModels/todo_model.dart';

// This constant is used for creatng a database and also used for CRUD operations.
const todoTableName = "todoTable";
const String columnId = "id";
const String todoTitle = "todoTitle";
const String todoMinute = "todoMinute";
const todoSecond = "todoSecond";
const todoDiscription = "todoDiscription";
const todoStatus = "todoStatus";

class DataBaseHander {
  /// Open database if does not exist than create table.
  Future<Database> openTable() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'doggie_database.db'),
      // When the database is first created, create a table to store Todo.
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $todoTableName($columnId INTEGER PRIMARY KEY, $todoTitle TEXT, $todoSecond INTEGER ,$todoMinute INTEGER , $todoDiscription TEXT, $todoStatus TEXT)',
        );
      },
      version: 1,
    );
    return database;
  }

  // Define a function that inserts Todo into the database
  Future<void> insertTodo(TodoEntry todo) async {
    final db = await openTable();
    await db.insert(
      todoTableName,
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Get all Todos
  Future<List<Map<String, Object?>>> getTodoList() async {
    try {
      final db = await openTable();
      final rows = await db.query(todoTableName);
      return rows;
    } catch (e) {
      return [];
    }
  }

  /// Remove the Todo from the database.
  Future<void> deleteTodo(int id) async {
    final db = await openTable();
    await db.delete(
      todoTableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  /// Update the given Todo.
  Future<void> updateTodo(TodoEntry todo) async {
    final db = await openTable();
    await db.update(
      todoTableName,
      todo.toMap(),
      where: '$columnId = ?',
      whereArgs: [todo.id],
    );
  }
}
