// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_riverpod/providers/all_providers.dart';
import 'package:flutter_todo_riverpod/widgets/title_widget.dart';
import 'package:flutter_todo_riverpod/widgets/todo_list_item_widget.dart';
import 'package:flutter_todo_riverpod/widgets/toolbar_widget.dart';

class TodoApp extends ConsumerWidget {
  TodoApp({super.key});
  final newTodoController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allTodos = ref.watch(filteredTodoList);
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
              onSubmitted: (newTodo) {
                ref.read(todoListProvider.notifier).addTodo(newTodo);
              },
            ),
            const SizedBox(height: 20),
            ToolbarWidget(),
            allTodos.isEmpty ? const Center(child: Text('There is nothing Todo here')) : const SizedBox(),
            for (var i = 0; i < allTodos.length; i++)
              Dismissible(
                key: ValueKey(allTodos[i].id),
                onDismissed: (direction) {
                  ref.read(todoListProvider.notifier).remove(allTodos[i]);
                },
                child: ProviderScope(overrides: [
                  currentTodoProvider.overrideWithValue(allTodos[i])
                ],child: const TodoListItemWidget()),
              ),
          ],
        ),
      ),
    );
  }
}
