// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_todo_riverpod/model/todo_model.dart';

class TodoListItemWidget extends StatelessWidget {
  TodoModel item;
  TodoListItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: true,
        onChanged: (value) {
          debugPrint(value.toString());
        },
      ),
      title: Text(item.description),
    );
  }
}
