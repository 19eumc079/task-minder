import 'package:hive/hive.dart';

import '../models/expense_tracker_model.dart';

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

class ExpenseDatabase {
  List<ExpenseTrackerModel> expenseList = [];
  final expenseBox = Hive.box('expenseTrackerBox');

  add(ExpenseTrackerModel item) {
    expenseList =
        (expenseBox.get('expenselist') ?? []).cast<ExpenseTrackerModel>();
    expenseList.add(item);
    expenseBox.put('expenselist', expenseList);
  }

  update(int index, ExpenseTrackerModel content) {
    expenseList = expenseBox.get('expenselist');
    expenseList[index] = content;
    expenseBox.put('expenselist', expenseList);
  }

  delete(int index) {
    expenseList = expenseBox.get('expenselist');
    expenseList.remove(expenseList[index]);
    expenseBox.put('expenselist', expenseList);
  }
}
