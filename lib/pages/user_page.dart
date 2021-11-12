import 'package:flutter/material.dart';
import 'package:thai_political_analyze_app/network_utils/get_user_data.dart';
import 'package:thai_political_analyze_app/pages/user_details_page.dart';
class UserPage extends StatefulWidget{
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>{
  var buttonIcon = Icons.search;
  var buttonColor = Colors.green;
  var buttonText = '查询';
  var leftRightPadding = 30.0;
  var topBottomPadding = 4.0;
  var _userNameController = new TextEditingController();
  var hintTips = new TextStyle(fontSize: 15.0, color: Colors.black26);
  void initState() {
    super.initState();
  }
  Widget build(BuildContext context) =>Scaffold(
    appBar: AppBar(
      title: Text("Twitter泰语舆情"),
      actions: [IconButton(onPressed: (){}, icon: Icon(Icons.share))],
    ),
    body: Center(child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
              leftRightPadding, 50.0, leftRightPadding, 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.contacts),
              Text('用户搜索')
            ],
          )
        ),
        Padding(
          padding: new EdgeInsets.fromLTRB(
              leftRightPadding, 50.0, leftRightPadding, topBottomPadding),
          child: new TextField(
            style: hintTips,
            controller: _userNameController,
            decoration: new InputDecoration(
              hintText: "如：realDonaldTrump",
              labelText: "请输入Twitter用户ID",
              prefixIcon: Icon(Icons.person),
            ),
          ),
        ),
      Container(
        width: 360.0,
        margin: new EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0.0),
        padding: new EdgeInsets.fromLTRB(leftRightPadding,
            topBottomPadding, leftRightPadding, topBottomPadding),
        child: new Card(
          color: buttonColor,
          elevation: 6.0,
          child: new TextButton(
              onPressed: () async {
                setState(() {
                  buttonColor = Colors.pink;
                  buttonText = '查询中';
                  buttonIcon = Icons.schedule;
                });
                var res = await getUserData();
                setState(() {
                  buttonColor = Colors.green;
                  buttonText = '查询';
                  buttonIcon = Icons.search;
                });
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return UserDetailsPage(
                        resultInfo: res,
                      );
                    }));
              },
              child: new Padding(
                  padding: new EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        buttonIcon,
                        color: Colors.white,
                      ),
                      Text(
                        buttonText,
                        style: TextStyle(
                            color: Colors.white, fontSize: 16.0),
                      )
                    ],
                  ))),
        ),
      )],)),
  );
}