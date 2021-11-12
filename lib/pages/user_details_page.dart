import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thai_political_analyze_app/json_utils/user_summary_define_class.dart';
class UserDetailsPage extends StatefulWidget {
  UserDetailsPage({required this.resultInfo}) : super();
  final UserSummary resultInfo;
  @override
  State<StatefulWidget> createState() {
    return new _UserDetailsPageState();
  }
}
class _UserDetailsPageState extends State<UserDetailsPage>{
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('用户舆情统计'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.open_in_browser)),
          IconButton(onPressed: (){}, icon: Icon(Icons.share))
        ],
      ),
      body:userDetailsBody(context,widget.resultInfo)
    );
  }
}
Widget userDetailsBody(BuildContext context,UserSummary summary){
  return ListView.builder(
      itemCount:summary.userIndexesValue.length+2,
      itemBuilder: (BuildContext context, int index){
    if(index==0) return userBasicInfo(summary);
    else if(index==1) return userKeyWordsInfo(summary.keyWords);
    else return indexesInfo(summary.userIndexesValue[index-2]);
  });
}

Widget userBasicInfo(UserSummary summary){
  return Card(child: Column(children: [
    ListTile(
      title: Text(summary.userFullName),
      subtitle: Text('@'+summary.userName),
      leading: Icon(Icons.person,color: Colors.blue[500],),
    )
  ],),);
}
Widget userKeyWordsInfo(List<KeyWords> kList) {
  List<DataRow> rows = [];
  for(var _v in kList){
    rows.add(DataRow(cells: [DataCell(Text(_v.wordName)),DataCell(Text(_v.rank.toString()))]));
  }
  return Card(child: Column(children: [
    Text('用户关键词'),
    Divider(),
    DataTable(rows: rows,columns: [DataColumn(label: Text('项目')),DataColumn(label: Text('指数'))],),
  ],),);
}
Widget getGradeStar(double scoreOrig, double _totalOrig) {
  var _total=5.0;
  var score=(scoreOrig/_totalOrig)*_total;
  int total = _total.toInt();
  List<Widget> _list = [];
  for (var i = 0; i < total; i++) {
    double factor = (score - i);
    if (factor >= 1) {
      factor = 1.0;
    } else if (factor < 0) {
      factor = 0;
    }
    Stack _st = Stack(
      children: <Widget>[
        Icon(
          Icons.star,
          color: Colors.grey,
        ),
        ClipRect(
            child: Align(
              alignment: Alignment.topLeft,
              widthFactor: factor,
              child: Icon(
                Icons.star,
                color:
                (score / _total >= 0.67) ? Colors.redAccent : Colors.blueAccent,
              ),
            ))
      ],
    );
    _list.add(_st);
  }
  String tx=scoreOrig.toString()+'/'+_totalOrig.toString();
  _list.add(Text(tx));
  return Row(children: _list,mainAxisAlignment: MainAxisAlignment.center,);
}

Widget indexesInfo(UserIndexesValue _value){
  return Card(
    child: Column(children: [
      ListTile(leading: Icon(Icons.info),
        title: Text(_value.markName),
        subtitle: Text(_value.markDescription),
      ),
      getGradeStar(_value.markRank.toDouble(), _value.fullMark.toDouble()),
      Text(_value.markResult)
    ],),
  );
}