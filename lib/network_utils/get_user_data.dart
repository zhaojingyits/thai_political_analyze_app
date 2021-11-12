import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:thai_political_analyze_app/json_utils/user_summary_define_class.dart';


Future<UserSummary> getUserData() async {
  String jsonData = await rootBundle.loadString('assets/user_json.json');
  final jsonResult = json.decode(jsonData);
  await Future.delayed(Duration(milliseconds: 800));
  print('delayed 0.8s');
  return new UserSummary.fromJson(jsonResult);
}