// 导入包
import 'package:flutter/material.dart';

// 应用入口
void main() {
  runApp(MyApp());
}
// void main()=>runApp(MyApp());

// StatelessWidget 无状态组件
// StatefulWidget 有状态组件
class MyApp extends StatelessWidget {
  @override
  // widget相当于组件，主要通过提供build()来描述如何构建UI界面
  Widget build(BuildContext context) {
    return MaterialApp(
      // 应用名称
      title: 'Flutter Demo',
      theme: ThemeData(
        // 设置主色调
        // primarySwatch: Colors.blue,
        // 设置整体的颜色方案，ColorScheme.fromSeed相当设置主色调
        // 区别：colorScheme可控制的颜色比primarySwatch多
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xCCE8CF)),
      ),

      // 应用首页路由
      home: MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:\n',
            ),
            Text(
                '${context.findAncestorWidgetOfExactType<MaterialApp>()!.title}'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
