class ToDoItem {
  final String name;
  final bool done;

  ToDoItem({
    required this.name,
    this.done = false,
  });

  ToDoItem copyWith({
    String? name,
    bool? done,
  }) {
    return ToDoItem(
      name: name ?? this.name,
      done: done ?? this.done,
    );
  }
}
