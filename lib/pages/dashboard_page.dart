import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thai_political_analyze_app/network_utils/get_dashboard_data.dart';
import 'show_tweets_page.dart';
import '../json_utils/dashboard_summary_define_class.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fl_chart/fl_chart.dart';



class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late DashboardSummary summaryData;
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
    //this.summaryData = await getTitleData();
    getDashboardData().then((value) {
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
    getDashboardData().then((value) {
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

  Widget childWidget() {
    Widget childWidget;
    if (this.loadingIsDone == true) {
      childWidget = new Padding(
          padding: EdgeInsets.all(6.0),
          child: dashboardShowing(this.summaryData, this.context));
    } else {
      childWidget = loadingSplash();
    }
    return childWidget;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Twitter泰语舆情"),
      actions: [IconButton(onPressed: (){}, icon: Icon(Icons.share))],
    ),
        body: Center(child: childWidget()),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.calendar_today_outlined),
          onPressed: () {
            this.refresh();
          },
        ),
      );
}

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

Widget dashboardShowing(DashboardSummary summary, BuildContext context) {
  print('show');
  print(summary.toString());
  return ListView(
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    children: [
      basicInfoCard(summary),
      detailsCards(summary),
      topicCard(summary),
      generalEvaluationCard(summary),
      predictionCards(summary, context),
      chinaRelatedCards(summary, context),
      classifyCards(summary, context)
    ],
  );
}

Widget basicInfoCard(DashboardSummary summary) {
  var fromTime = DateTime.parse(summary.datetime);
  var toTime = fromTime.add(Duration(hours: summary.continueHours));
  return Card(
    child: Column(
      children: [
        Text(
          '舆情信息报告',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Text('开始时间：' + fromTime.toString()),
        Text('结束时间：' + toTime.toString()),
      ],
    ),
  );
}

Widget detailsCards(DashboardSummary summary) {
  return GridView(
    shrinkWrap: true,
    physics: new NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.3
        ),
    children: [
      detailsValueCard('总推文', summary.details.tweetsCount.toString(),
          summary.details.tweetsCountVariance.toString(),summary.details.tweetsCountVariance>0?true:false),
      detailsValueCard('转推数', summary.details.retweet.toString(),
          summary.details.retweetVariance.toString(),summary.details.retweetVariance>0?true:false),
      detailsValueCard('点赞数', summary.details.favorite.toString(),
          summary.details.favoriteVariance.toString(),summary.details.favoriteVariance>0?true:false),
      detailsValueCard('评论数', summary.details.reply.toString(),
          summary.details.replyVariance.toString(),summary.details.replyVariance>0?true:false),
      detailsValueCard('引用数', summary.details.quote.toString(),
          summary.details.quoteVariance.toString(),summary.details.quoteVariance>0?true:false),
      detailsValueCard('话题数', summary.details.hashtag.toString(),
          summary.details.hashtagVariance.toString(),summary.details.hashtagVariance>0?true:false),
      detailsValueCard('认证用户推文数', summary.details.verified.toString(),
          summary.details.verifiedVariance.toString(),summary.details.verifiedVariance>0?true:false),
      detailsValueCard('媒体文件数', summary.details.media.toString(),
          summary.details.mediaVariance.toString(),summary.details.mediaVariance>0?true:false),
      detailsValueCard('平均长度', summary.details.lengthAvg.toStringAsFixed(2),
          summary.details.lengthAvgVariance.toStringAsFixed(2),summary.details.lengthAvgVariance>0?true:false),
    ],
  );
}

Card detailsValueCard(String name, String count, String variance,bool isIncreased) {
  if(isIncreased)
    variance='+'+variance;
  return Card(
    child: Column(
      children: [
        Text(name),
        Divider(),
        Row(mainAxisAlignment:MainAxisAlignment.center,children: [
          Text(count,style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
          Text(variance,style: TextStyle(color: isIncreased?Colors.red:Colors.green,fontWeight: FontWeight.bold),),
        ],)
      ],
    ),
  );
}

Widget topicCard(DashboardSummary summary) {
  List<Widget> _getData() {
    var list = [
      Text('主题'),
      Divider(),
    ];
    for (var itemInTopics in summary.details.topics) {
      list.add(ListTile(
          title: Text(itemInTopics.word),
          subtitle: Text('热度：' + itemInTopics.rank.toString())));
    }
    if (summary.details.topics.length < 1) {
      return [Text('主题信息为空')];
    }
    return list;
  }

  return Card(child: Column(children: _getData()));
}

Widget generalEvaluationCard(DashboardSummary summary) {
  return Card(
    child: Column(
      children: [
        Text('总体趋势'),
        Divider(),
        Container(child: Text(summary.details.generalEvaluation),padding: EdgeInsets.all(10.0),),
      ],
    ),
  );
}

Widget predictionCards(DashboardSummary summary, BuildContext context) {
  List<Widget> _getData() {
    var list = [
      Text('趋势预测'),
      Divider(),
    ];

    for (var itemInPrediction in summary.details.prediction) {
      list.add(
        ListTile(
            onTap: () {
              List<FlSpot> _barsData = [];
              late int _itemCount;
              if (itemInPrediction.formerValue != null)
                _itemCount = itemInPrediction.formerValue!.length;
              else
                _itemCount = 0;
              print(_itemCount);
              for (int itemNumber = 0; itemNumber < _itemCount; itemNumber++) {
                if (itemInPrediction.formerValue != null)
                  _barsData.add(FlSpot(itemNumber.toDouble(),
                      itemInPrediction.formerValue![itemNumber].toDouble()));
              }
              List<FlSpot> _barsPredData = [];
              if (itemInPrediction.formerValue != null) {
                _barsPredData.add(FlSpot((_itemCount - 1).toDouble(),
                    itemInPrediction.formerValue![_itemCount - 1].toDouble()));
              }
              try {
                _barsPredData.add(FlSpot((_itemCount).toDouble(),
                    double.parse(itemInPrediction.predictValue)));
              } catch (e) {
                print(e.toString());
              }

              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    /*return new AlertDialog(
                        title: Text('itemInPrediction.predictItem'),
                        actions: <Widget>[
                          new FlatButton(
                            child: new Text('确定'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                        content: new SingleChildScrollView(
                          child: ListBody(
                            children: [new Text('预测变量')],
                          ),
                        )
                    );*/

                    return new Scaffold(
                        appBar: AppBar(
                          title: Text(itemInPrediction.predictItem),
                        ),
                        body: ListView(
                          children: [
                            Card(
                              child: Column(
                                children: [
                                  Text('预测' + itemInPrediction.predictItem),
                                  Divider(),
                                  Text(
                                    itemInPrediction.predictValue.toString(),
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            Card(
                              child: Column(
                                children: [
                                  Text('趋势图 - ' + itemInPrediction.predictItem),
                                  Divider(),
                                  if (itemInPrediction.formerValue == null)
                                    Text('无趋势图')
                                  else
                                    Container(
                                      height: 300,
                                      width: 300,
                                      child: LineChart(LineChartData(
                                          titlesData: FlTitlesData(
                                              bottomTitles: SideTitles(
                                                  showTitles: true,
                                                  reservedSize: 22,
                                                  getTitles: (value) {
                                                    String titleStr = '';
                                                    if (itemInPrediction
                                                            .formerKey !=
                                                        null) {
                                                      //return '前'+(_itemCount-value).toInt().toString();
                                                      if (value ==
                                                          _itemCount.toDouble())
                                                        titleStr = '预测值';
                                                      //print(value.toString()+' - '+_itemCount.toDouble().toString());
                                                      //print(titleStr);
                                                      if (value < _itemCount) {
                                                        titleStr =
                                                            itemInPrediction
                                                                    .formerKey![
                                                                value.toInt()];
                                                        titleStr = titleStr
                                                            .substring(5);
                                                        titleStr =
                                                            titleStr.replaceAll(
                                                                RegExp(
                                                                    r'00:00:00'),
                                                                '00');
                                                        titleStr =
                                                            titleStr.replaceAll(
                                                                RegExp(
                                                                    r'12:00:00'),
                                                                '12');
                                                        //print(titleStr);
                                                      }
                                                    }

                                                    return titleStr;
                                                  })),
                                          lineBarsData: [
                                            LineChartBarData(
                                              spots: _barsData,
                                              colors: [
                                                Colors.indigo,
                                                Colors.blue
                                              ],
                                              isCurved: true,
                                              barWidth: 2.0,
                                            ),
                                            LineChartBarData(
                                              spots: _barsPredData,
                                              colors: [
                                                Colors.orange,
                                                Colors.deepOrange
                                              ],
                                              isCurved: true,
                                              barWidth: 2.0,
                                            )
                                          ])),
                                    )
                                ],
                              ),
                            ),
                          ],
                        ));
                  });
            },
            title: Text(itemInPrediction.predictItem),
            subtitle: itemInPrediction.description == null
                ? Text('预测信息：' + itemInPrediction.predictValue.toString())
                : Text('简介：' +
                    itemInPrediction.description.toString() +
                    '\n' +
                    '预测信息：' +
                    itemInPrediction.predictValue.toString())),
      );
      list.add(Divider());
    }
    if (summary.details.topics.length < 1) {
      return [Text('预测信息为空')];
    }
    return list;
  }

  return Card(child: Column(children: _getData()));
}

Widget chinaRelatedCards(DashboardSummary summary, BuildContext context) {
  List<Widget> _getData() {
    var list = [
      Text('涉华舆情信息'),
      Card(
          child: Container(
            child: Column(children: [
              Row(mainAxisAlignment:MainAxisAlignment.center,children: [
                Text(summary.details.chinaRelated.count.toString(),style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                Text('条')
              ],),
              if (summary.details.chinaRelated.count < 1)
                Text('null')
              else
                ListTile(
                  title: Text('最热门推文'),
                  subtitle: Text(
                    summary.details.chinaRelated.tweetsPage.pageContent[0].fullText,
                    maxLines: 4,
                  ),
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context){
                      return TweetsShowingPage(
                        page:summary.details.chinaRelated.tweetsPage,
                        pageDescription: '涉华推文',
                        pages: summary.details.chinaRelated.pages,
                        onePageCount: summary.details.chinaRelated.onePageCount,
                        allPagesCount: summary.details.chinaRelated.count,
                      );
                    }));
                  },
                )
            ]),
          ))
    ];
    return list;
  }
  return Container(child: Column(children: _getData()));
}
Widget classifyCards(DashboardSummary summary, BuildContext context) {
  List<Widget> _getData() {
    var list = [
      Text('情感分类'),
      Card(
          child: Container(
            child: Column(children: [
              Row(mainAxisAlignment:MainAxisAlignment.center,children: [
                Text('新闻'),
                Text(summary.details.classifyAnalyzeResult.newsCount.toString(),style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                Text('条'),
              ],),
              ListTile(title: Text('查看推文'),onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context){
                  return TweetsShowingPage(
                    page:summary.details.classifyAnalyzeResult.newsPage,
                    pageDescription: '新闻推文',
                    pages: summary.details.classifyAnalyzeResult.newsPageCount,
                    onePageCount: summary.details.classifyAnalyzeResult.newsPage.pageContent.length,
                    allPagesCount: summary.details.classifyAnalyzeResult.newsCount,
                  );
                }));
              },),
              Row(mainAxisAlignment:MainAxisAlignment.center,children: [
                Text('倾向性讨论'),
                Text(summary.details.classifyAnalyzeResult.newsCount.toString(),style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                Text('条'),
              ],),
              ListTile(title: Text('查看推文'),onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context){
                  return TweetsShowingPage(
                    page:summary.details.classifyAnalyzeResult.discussionPage,
                    pageDescription: '倾向性推文',
                    pages: summary.details.classifyAnalyzeResult.discussionPageCount,
                    onePageCount: summary.details.classifyAnalyzeResult.discussionPage.pageContent.length,
                    allPagesCount: summary.details.classifyAnalyzeResult.discussionCount,
                  );
                }));
              },),
            ]),
          ))
    ];
    return list;
  }
  return Container(child: Column(children: _getData()));
}
