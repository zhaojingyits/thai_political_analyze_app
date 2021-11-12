import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../json_utils/dashboard_summary_define_class.dart';

// ignore: must_be_immutable
class TweetsShowingPage extends StatefulWidget {
  TweetsShowingPage(
      { //Key key,
      required this.page,
      required this.onePageCount,
      required this.pages,
      required this.pageDescription,
      required this.allPagesCount})
      : super(/*key: key*/);
  late TweetsPage page;
  late int onePageCount;
  late int pages;
  late String pageDescription;
  late int allPagesCount;
  @override
  State<StatefulWidget> createState() {
    return new _TweetsShowingPageState();
  }
}

class _TweetsShowingPageState extends State<TweetsShowingPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageDescription),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return new AlertDialog(
                          title: Text('itemInPrediction.predictItem'),
                          actions: <Widget>[
                            new TextButton(
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
                          ));
                    });
              },
              icon: Icon(Icons.share)),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return new AlertDialog(
                          title: Text('帮助'),
                          actions: <Widget>[
                            new TextButton(
                              child: new Text('确定'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                          content: new SingleChildScrollView(
                            child: ListBody(
                              children: [
                                Row(mainAxisAlignment:MainAxisAlignment.spaceAround,children: [
                                  Icon(Icons.forward),
                                  Text('转推(retweet)数'),
                                ],),
                                Row(mainAxisAlignment:MainAxisAlignment.spaceAround,children: [
                                  Icon(Icons.favorite),
                                  Text('收藏(favorite)数'),
                                ],),
                                Row(mainAxisAlignment:MainAxisAlignment.spaceAround,children: [
                                  Icon(Icons.reply),
                                  Text('回复(reply)数'),
                                ],),
                                Row(mainAxisAlignment:MainAxisAlignment.spaceAround,children: [
                                  Icon(Icons.repeat),
                                  Text('引用(quote)数'),
                                ],),
                                Row(mainAxisAlignment:MainAxisAlignment.spaceAround,children: [
                                  Icon(Icons.perm_media),
                                  Text('媒体(图片视频)数'),
                                ],),
                              ],
                            ),
                          ));
                    });
              },
              icon: Icon(Icons.help))
        ],
      ),
      persistentFooterButtons: [
        IconButton(
            onPressed: () {
              print('prev');
            },
            icon: Icon(Icons.arrow_left)),
        TextButton(
            onPressed: () {}, child: Text(widget.page.pageNumber.toString()+'/'+widget.pages.toString())),
        IconButton(
            onPressed: () {
              print('next');
            },
            icon: Icon(Icons.arrow_right)),
      ],
      body: tweetsBody(widget.page.pageContent, context),
    );
  }
}

Widget tweetsBody(List<PageContent> contentList, BuildContext context) {
  return ListView.builder(
      itemCount: contentList.length,
      //itemExtent: 100.0,
      itemBuilder: (BuildContext context, int index) {
        return Card(
            child: Column(
          children: [
            Container(child: Row(
              children: [
                contentList[index].userVerified?Icon(Icons.verified_user):Icon(Icons.person),
                Text(contentList[index].userFullName,style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
                Text('@'+contentList[index].userName),
              ],
            ),padding: EdgeInsets.all(10.0),),
            Container(child: Text(contentList[index].fullText),padding: EdgeInsets.all(10.0),),
            Divider(),
            Row(mainAxisAlignment:MainAxisAlignment.spaceAround,children: [
              TextButton(child: Text('详情'),onPressed: (){
                var _infoString=contentList[index].toJson().toString();
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return new AlertDialog(
                          title: Text('详情'),
                          actions: <Widget>[
                            new TextButton(
                              child: new Text('复制'),
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: _infoString));
                              },
                            ),
                            new TextButton(
                              child: new Text('确定'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                          content: new SingleChildScrollView(
                            child: ListBody(
                              children: [new Text(_infoString)],
                            ),
                          ));
                    });
              },),
              Icon(Icons.forward),
              Text(contentList[index].retweetCount.toString()),
              Icon(Icons.favorite),
              Text(contentList[index].favoriteCount.toString()),
              Icon(Icons.reply),
              Text(contentList[index].replyCount.toString()),
              Icon(Icons.repeat),
              Text(contentList[index].quoteCount.toString()),
              Icon(Icons.perm_media),
              Text(contentList[index].media.length.toString()),
              TextButton(child: Text('翻译'),onPressed: (){},),
            ],)

          ],
        ));
      });
}
String strTranslate(String content,String from,String to){
  return '';
}