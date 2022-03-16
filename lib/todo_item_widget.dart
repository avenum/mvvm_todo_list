import 'package:flutter/material.dart';
import 'package:mvvm_todo_list/todo_item.dart';

class ToDoItemWidget extends StatelessWidget {
  final ToDoItem item;
  final Function(ToDoItem) onDelete;
  final Function(ToDoItem) onToogle;
  const ToDoItemWidget({
    Key? key,
    required this.item,
    required this.onDelete,
    required this.onToogle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        background: Container(color: Colors.red),
        key: Key(item.name),
        onDismissed: (_) {
          onDelete(item);
        },
        child: CheckboxListTile(
          value: item.done,
          onChanged: (_) {
            onToogle(item);
          },
          title: Text(item.name),
        ));
  }
}
