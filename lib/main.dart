// 导入包
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application/page/home.dart';
import 'package:flutter_application/page/todo_list.dart';

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
    debugPaintSizeEnabled = false; // 开启尺寸绘制
    debugPaintBaselinesEnabled = false; // 开启基线绘制
    debugPaintPointersEnabled = false; // 开启指针绘制
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedTab = 0;
  String title = 'Home';
  final PageController _pageController = PageController();
  List<NavigationRailDestination> tabList = [
    const NavigationRailDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
      label: Text('Home'),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.format_list_bulleted_outlined),
      selectedIcon: Icon(Icons.format_list_bulleted),
      label: Text('Todo-List'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        ),
        body: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(color: Colors.grey[300]!, width: 1.5))),
              constraints: const BoxConstraints.tightForFinite(width: 100),
              child: NavigationRail(
                useIndicator: false,
                selectedIndex: selectedTab,
                labelType: NavigationRailLabelType.all,
                selectedIconTheme:
                    IconThemeData(color: Colors.purple[200]), // 设置选中项的图标颜色
                // 页码变化
                onDestinationSelected: (int index) {
                  setState(() {
                    selectedTab = index;
                    title = (tabList[index].label as Text).data!;
                    _pageController.jumpToPage(index);
                  });
                },
                destinations: tabList,
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                children: [
                  HomePage(),
                  TodoList(),
                ],
              ),
            )
          ],
        ));
  }
}
