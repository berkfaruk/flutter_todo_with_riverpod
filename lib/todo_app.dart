// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_todo_riverpod/model/todo_model.dart';
import 'package:flutter_todo_riverpod/widgets/title_widget.dart';
import 'package:flutter_todo_riverpod/widgets/todo_list_item_widget.dart';
import 'package:flutter_todo_riverpod/widgets/toolbar_widget.dart';
import 'package:uuid/uuid.dart';

class TodoApp extends StatelessWidget {
  TodoApp({super.key});
  final newTodoController = TextEditingController();
  List<TodoModel> allTodos = [
    TodoModel(id: const Uuid().v4(), description: 'Go To Gym'),
    TodoModel(id: const Uuid().v4(), description: 'Go To Groceries'),
    TodoModel(id: const Uuid().v4(), description: 'Study'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: ListView(
          children: [
            const TitleWidget(),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                labelText: 'What will you do today?',
              ),
              controller: newTodoController,
              onSubmitted: (value) {
                debugPrint('new todo : $value');
              },
            ),
            const SizedBox(height: 20),
            const ToolbarWidget(),
            for (var i = 0; i < allTodos.length; i++)
              Dismissible(
                key: ValueKey(allTodos[i].id),
                onDismissed: (direction) {
                  
                },
                child: TodoListItemWidget(item: allTodos[i]),
              ),
          ],
        ),
      ),
    );
  }
}
