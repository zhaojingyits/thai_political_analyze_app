import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'sputil.dart';
void sendEmail(String email) => launch("mailto:$email");
void about(BuildContext ctx) {
  //sharedDeleteData('history');
  showAboutDialog(
      context: ctx,
      applicationIcon: Icon(Icons.bubble_chart),
      applicationName: '泰语舆情研究系统',
      applicationVersion: "1.0",
      children: [
        Text('赵敬一'),
        
      ]);
}