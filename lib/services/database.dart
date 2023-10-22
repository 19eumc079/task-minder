import 'package:hive/hive.dart';

class Database {
  List todoList = [];
  final todoBox = Hive.box('toDOListBox');

  addTodo(item) {
    todoList = todoBox.get('toDos') ?? [];
    todoList.add(item);
    todoBox.put('toDos', todoList);
  }

  update(int index, Map content) {
    todoList = todoBox.get('toDos');
    todoList[index] = content;
    todoBox.put('toDos', todoList);
  }

  delete(int index) {
    todoList = todoBox.get('toDos');
    todoList.remove(todoList[index]);
    todoBox.put('toDos', todoList);
  }
}
