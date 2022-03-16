import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todo_item.dart';
import 'add_task_dialog.dart';
import 'todo_item_widget.dart';

class _ViewModelState {
  final List<ToDoItem> items;

  _ViewModelState({
    this.items = const <ToDoItem>[],
  });

  _ViewModelState copyWith({
    List<ToDoItem>? items,
  }) {
    return _ViewModelState(
      items: items ?? this.items,
    );
  }
}

class _ViewModel extends ChangeNotifier {
  var _state = _ViewModelState();

  _ViewModelState get state => _state;
  set state(_ViewModelState val) {
    _state = _state.copyWith(items: val.items);
    notifyListeners();
  }

  addItem(ToDoItem item) {
    var list = state.items.toList();
    if (list.any((element) => element.name == item.name)) {
      throw Error();
    } else {
      list.add(item);
      state = state.copyWith(items: list);
    }
  }

  dellItem(ToDoItem item) {
    var list = state.items.toList();
    list.removeWhere((element) => element.name == item.name);
    state = state.copyWith(items: list);
  }

  toogleItem(ToDoItem item) {
    var list = state.items.toList();
    var index = list.indexWhere((element) => element.name == item.name);
    list[index] = item.copyWith(done: !item.done);
    state = state.copyWith(items: list);
  }
}

class ToDoListWidget extends StatelessWidget {
  const ToDoListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _viewModel = context.watch<_ViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDo List"),
      ),
      body: ListView.builder(
        itemBuilder: (_, int index) => ToDoItemWidget(
          item: _viewModel.state.items[index],
          onDelete: _viewModel.dellItem,
          onToogle: _viewModel.toogleItem,
        ),
        itemCount: _viewModel.state.items.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AddTaskDialog(onFinish: _viewModel.addItem),
          );
        },
        tooltip: 'Add task',
        child: const Icon(Icons.add),
      ),
    );
  }

  static Widget create() => ChangeNotifierProvider(
        create: (_) => _ViewModel(),
        child: const ToDoListWidget(),
      );
}
