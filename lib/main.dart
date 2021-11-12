import 'package:flutter/material.dart';
import 'pages/search_page.dart';
import 'pages/settings_page.dart';
import 'pages/trend_page.dart';
import 'pages/user_page.dart';
import 'pages/dashboard_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '舆情分析系统',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  final List<BottomNavigationBarItem> bottomNavItems = [
    //概要 趋势 用户 搜索 设置
    BottomNavigationBarItem(
      icon: Icon(Icons.table_view),
      label: "概要",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.stacked_bar_chart),
      label: "趋势",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.contact_page),
      label: "用户",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: "搜索",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: "设置",
    ),
  ];

  int currentIndex = 0;

  final pages = [
    DashboardPage(),
    TrendPage(),
    UserPage(),
    SearchPage(),
    SettingsPage()
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: bottomNavItems,
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            _changePage(index);
          },
        ),
        body: pages[currentIndex],
      );

  /*切换页面*/
  void _changePage(int index) {
    /*如果点击的导航项不是当前项  切换 */
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
    }
  }
}
