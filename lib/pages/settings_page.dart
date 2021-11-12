import 'package:flutter/material.dart';
import 'package:thai_political_analyze_app/other_utils/about.dart';
class SettingsPage extends StatefulWidget{
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>{
  void initState() {
    super.initState();
  }
  Widget build(BuildContext context) =>Scaffold(
    appBar: AppBar(
      title: Text("Twitter泰语舆情"),
      actions: [IconButton(onPressed: (){}, icon: Icon(Icons.share))],
    ),
    body: aboutLists(context),

  );
}

Widget aboutLists(BuildContext context)=>ListView(
  children: [
    ListTile(
      title: Text('反馈'),
      subtitle: Text('帮助我们改进使用体验'),
      leading: Icon(Icons.feedback_outlined),
      onTap: () {
        sendEmail('zhaojingyits@foxmail.com');
      },
    ),
    ListTile(
      title: Text('关于'),
      subtitle: Text('版本1.0'),
      leading: Icon(Icons.info_outline),
      onTap: (){about(context);},
    ),
    ListTile(
      title: Text('语言'),
      subtitle: Text('简体中文'),
      leading: Icon(Icons.language),
    )
  ],
);