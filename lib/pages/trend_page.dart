import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:thai_political_analyze_app/json_utils/trends_summary_define_class.dart';
import 'package:thai_political_analyze_app/network_utils/get_trends_data.dart';

class TrendPage extends StatefulWidget {
  @override
  _TrendPageState createState() => _TrendPageState();
}

class _TrendPageState extends State<TrendPage> {
  late TrendsSummary summaryData;
  bool loadingIsDone = false;
  @override
  void initState() {
    super.initState();
    /*获取本地解析的json*/ if (mounted) {
      setState(() {
        this.loadingIsDone = false;
      });
    }
    print(loadingIsDone.toString());
    getTrendsData().then((value) {
      //赋值刷新必须放入setState中
      this.summaryData = value;
      if (mounted) {
        setState(() {
          this.loadingIsDone = true;
        });
      }
      print(loadingIsDone.toString());
      print('refresh done');
    });
  }

  void refresh() {
    print('clicked refresh button');
    setState(() {
      this.loadingIsDone = false;
    });
    print(loadingIsDone.toString());
    //this.summaryData = await getTitleData();
    getTrendsData().then((value) {
      //赋值刷新必须放入setState中
      this.summaryData = value;
      setState(() {
        this.loadingIsDone = true;
      });
      print(loadingIsDone.toString());
      print('refresh done');
    });

    //setState(() {this.loadingIsDone = !this.loadingIsDone;});
  }

  @override
  Widget build(BuildContext context) => childWidget();
  Widget loadingSplash() {
    return Stack(
      children: <Widget>[
        new Padding(
          padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 35.0),
          child: new Center(
            child: SpinKitFadingCircle(
              color: Colors.blueAccent,
              size: 30.0,
            ),
          ),
        ),
        new Padding(
          padding: new EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
          child: new Center(
            child: new Text('正在加载中，莫着急哦~'),
          ),
        ),
      ],
    );
  }

  Widget childWidget() {
    Widget childWidget;
    if (this.loadingIsDone == true) {
      childWidget = new Scaffold(
        appBar: AppBar(
          title: Text("Twitter泰语舆情"),
          actions: [IconButton(onPressed: (){}, icon: Icon(Icons.share))],
        ),
        floatingActionButton: FloatingActionButton(child: Icon(Icons.calendar_today_outlined),
          onPressed: (){
          },),
        body: Padding(
            padding: EdgeInsets.all(6.0),
            child: trendsShowing(this.summaryData, this.context)),

      );
    } else {
      childWidget = new Scaffold(body: loadingSplash());
    }
    return childWidget;
  }
}

Widget trendsShowing(TrendsSummary summary, BuildContext context) {
  print('show');
  print(summary.toString());
  return ListView.builder(
      itemCount: summary.trendsResults.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0)
          return basicInfoCard(summary);
        else {
          return trendCard(
              summary.trendsResults[index - 1].valueName,
              summary.trendsResults[index - 1].thisTrendValue,
              summary.trendsResults[index - 1].thisTrendKey);
        }
      });
}

Widget basicInfoCard(TrendsSummary summary) {
  //var fromTime = DateTime.parse(summary.fromDatetime);
  //var toTime = DateTime.parse(summary.toDatetime);
  return Card(
    child: Column(
      children: [
        Text(
          '舆情信息趋势',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Text('开始时间：' + summary.fromDatetime),
        Text('结束时间：' + summary.toDatetime),
      ],
    ),
  );
}

Widget trendCard(String valueName, List<double> values, List<String> keys) {
  List<FlSpot> _barsData = [];
  for (int i = 0; i < values.length; i++) {
    _barsData.add(FlSpot(i.toDouble(), values[i]));
  }
  return Card(
    child: Column(
      children: [
        Text('趋势图 - ' + valueName),
        Divider(),
        Container(
          height: 300,
          width: 300,
          child: LineChart(LineChartData(
              titlesData: FlTitlesData(
                  bottomTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 22,
                      getTitles: (value) {
                        int _i = value.toInt();
                        var titleStr = keys[_i];
                        return titleStr;
                      })),
              lineBarsData: [
                LineChartBarData(
                  spots: _barsData,
                  colors: [Colors.indigo, Colors.blue],
                  isCurved: true,
                  barWidth: 2.0,
                ),
              ])),
        )
      ],
    ),
  );
}
