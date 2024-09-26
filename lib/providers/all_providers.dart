import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_riverpod/model/todo_model.dart';
import 'package:flutter_todo_riverpod/providers/todo_list_manager.dart';
import 'package:uuid/uuid.dart';

final todoListProvider =
    StateNotifierProvider<TodoListManager, List<TodoModel>>(
  (ref) {
    return TodoListManager([
      TodoModel(id: const Uuid().v4(), description: 'Go to School'),
      TodoModel(id: const Uuid().v4(), description: 'Go to Groceries'),
      TodoModel(id: const Uuid().v4(), description: 'Do Homework'),
      TodoModel(id: const Uuid().v4(), description: 'Television'),
    ]);
  },
);

final unCompletedTodoCount = Provider<int>((ref) {
  final allTodo = ref.watch(todoListProvider);
  final count = allTodo.where((element) => !element.completed,).length;
  return count;
},);

final currentTodoProvider = Provider<TodoModel>((ref) {
  throw UnimplementedError();
},);

enum TodoListFilter{
  all, active, completed
}

final todoListFilter = StateProvider<TodoListFilter>((ref) => TodoListFilter.all,);

final filteredTodoList = Provider<List<TodoModel>>((ref) {
  final filter = ref.watch(todoListFilter);
  final todoList = ref.watch(todoListProvider);

  switch (filter) {
    case TodoListFilter.all:
    return todoList;
    case TodoListFilter.completed:
    return todoList.where((element) => element.completed,).toList();
    case TodoListFilter.active:
    return todoList.where((element) => !element.completed,).toList();

  }
},);