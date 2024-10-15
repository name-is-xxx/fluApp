import 'package:flutter/material.dart';

class Todo {
  String todoText;
  int createTime;
  int lastChangeTime;
  bool isFinish;

  Todo(this.todoText, this.createTime, this.lastChangeTime, this.isFinish);

  String getText() {
    return todoText;
  }

  String toString() {
    return '''创建时间：$createTime    最后修改时间：$lastChangeTime\n
    内容：$todoText \n
    是否完成：${isFinish ? 'yes' : 'no'}
    ''';
  }
}

class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  int num = 0;
  final List<Todo> todo_list = [
    Todo('1', 555, 333, false),
    Todo('2', 555, 333, false),
    Todo('3', 555, 333, false),
    Todo('4', 555, 333, false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CheckboxListTile(
            // tileColor: Colors.red,
            title: Text(todo_list[0].getText()),
            value: true,
            onChanged: (bool? value) {},
          ),
        ],
      ),
    );
  }
}
