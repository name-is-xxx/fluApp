import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Todo {
  String todoText;
  DateTime createTime;
  DateTime lastChangeTime;
  bool isFinish;

  Todo(this.todoText, this.createTime, this.lastChangeTime, this.isFinish);

  // 转换为Json格式
  Map<String, dynamic> toJson() {
    return {
      'createTime': createTime.toIso8601String(),
      'lastChangeTime': lastChangeTime.toIso8601String(),
      'todoText': todoText,
      'isFinish': isFinish
    };
  }

  // 从JSON Map创建Todo对象
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      json['todoText'],
      DateTime.parse(json['createTime']),
      DateTime.parse(json['lastChangeTime']),
      json['isFinish'],
    );
  }
}

void writeData(List list) async {
  // 获取文档目录
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/data.json');
  // 转换为Json
  String jsonString = json.encode(list.map((item) => item.toJson()).toList());
  await file.writeAsString(jsonString);
}

Future<List<Todo>?> readData() async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/data.json');
  try {
    // 读取文件内容
    String? contents = await file.readAsString();
    // 解码Json
    List<dynamic> dataList = json.decode(contents);
    return dataList.map((item) => Todo.fromJson(item)).toList();
  } catch (e) {
    final error = File('${directory.path}/ErrorMes.json');
    await error.writeAsString('读取文件时发生错误: $e');
    return null;
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<StatefulWidget> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  int num = 0;
  bool isAdd = false;
  List<Todo> todoList = [];

  @override
  void initState() {
    super.initState();
    // 在initState中异步加载数据
    loadData();
  }

  Future<void> loadData() async {
    // 等待数据加载完成
    List<Todo>? temp = await readData();
    if (temp != null) {
      todoList = temp;
      // 通知更新
      setState(() {});
    }
  }

  @override
  void dispose() {
    writeData(todoList);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          addList(isAdd: isAdd),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: OutlinedButton.icon(
              icon: isAdd
                  ? const Icon(Icons.check_outlined)
                  : const Icon(Icons.add),
              label: isAdd ? const Text("完成") : const Text("添加"),
              onPressed: () {
                setState(() {
                  isAdd = !isAdd;
                });
              },
            ),
          ),
          const Divider(
            thickness: 1,
            color: Colors.black,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(
                    todoList[index].todoText,
                    style: TextStyle(
                        decoration: todoList[index].isFinish
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                  value: todoList[index].isFinish,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool? value) {
                    setState(() {
                      todoList[index].isFinish = !todoList[index].isFinish;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget addList({required bool isAdd}) {
    if (isAdd) {
      final controller = TextEditingController();

      void dispose() {
        controller.clear();
      }

      return Column(
        children: [
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Add a new Todo list',
              border: InputBorder.none,
            ),
            onSubmitted: (String value) {
              if (value != '') {
                Todo newTab =
                    Todo(value, DateTime.now(), DateTime.now(), false);
                setState(() {
                  todoList.add(newTab);
                });
                controller.clear();
              }
            },
          ),
        ],
      );
    } else {
      return const Column();
    }
  }
}
