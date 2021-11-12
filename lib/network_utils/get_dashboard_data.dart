import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:thai_political_analyze_app/json_utils/dashboard_summary_define_class.dart';


Future<DashboardSummary> getDashboardData() async {
  String jsonData = await rootBundle.loadString('assets/dashboard_json.json');
  final jsonResult = json.decode(jsonData);
  await Future.delayed(Duration(milliseconds: 800));
  print('delayed 0.8s');
  return new DashboardSummary.fromJson(jsonResult);
}