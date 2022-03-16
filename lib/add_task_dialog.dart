import 'package:flutter/material.dart';

import 'todo_item.dart';

class AddTaskDialog extends StatelessWidget {
  final ValueChanged<ToDoItem> onFinish;
  const AddTaskDialog({
    Key? key,
    required this.onFinish,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? text;
    return AlertDialog(
      title: const Text("Add new Task"),
      content: TextField(
          autofocus: true,
          onChanged: (String _text) {
            text = _text;
          }),
      actions: <Widget>[
        TextButton(
          child: const Text("Add"),
          onPressed: () {
            if (text != null) {
              try {
                onFinish(ToDoItem(name: text!));
                Navigator.of(context).pop();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Task ${text!} exist!")));
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Enter Task name")));
            }
          },
        ),
        TextButton(
          child: const Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
