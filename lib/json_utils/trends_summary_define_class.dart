
class TrendsSummary {
  late String fromDatetime;
  late String toDatetime;
  late List<TrendsResults> trendsResults;

  TrendsSummary({
    required this.fromDatetime,
    required this.toDatetime,
    required this.trendsResults,
  });

  TrendsSummary.fromJson(Map<String, dynamic> json) {
    fromDatetime = json['from_datetime'];
    toDatetime = json['to_datetime'];
    trendsResults = List<dynamic>.from(json['trends_results']).map((e)=>TrendsResults.fromJson(e)).toList();
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['from_datetime'] = fromDatetime;
    _data['to_datetime'] = toDatetime;
    _data['trends_results'] = trendsResults.map((e)=>e.toJson()).toList();
    return _data;
  }
}
class TrendsResults {
  late String valueName;
  late List<double> thisTrendValue;
  late List<String> thisTrendKey;

  TrendsResults({
    required this.valueName,
    required this.thisTrendValue,
    required this.thisTrendKey,
  });

  TrendsResults.fromJson(Map<String, dynamic> json) {
    valueName = json['value_name'];
    thisTrendValue = List<double>.from(json['this_trend_value']);
    thisTrendKey = List<String>.from(json['this_trend_key']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['value_name'] = valueName;
    _data['this_trend_value'] = thisTrendValue;
    _data['this_trend_key'] = thisTrendKey;
    return _data;
  }
}