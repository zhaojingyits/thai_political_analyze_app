
class UserSummary {
  late String userName;
  late String userFullName;
  late int topTweets;
  late List<KeyWords> keyWords;
  late List<UserIndexesValue> userIndexesValue;

  UserSummary({
    required this.userName,
    required this.userFullName,
    required this.topTweets,
    required this.keyWords,
    required this.userIndexesValue,
  });

  UserSummary.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    userFullName = json['user_full_name'];
    topTweets = json['top_tweets'];
    keyWords = List<dynamic>.from(json['key_words']).map((e)=>KeyWords.fromJson(e)).toList();
    userIndexesValue = List<dynamic>.from(json['user_indexes_value']).map((e)=>UserIndexesValue.fromJson(e)).toList();
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user_name'] = userName;
    _data['user_full_name'] = userFullName;
    _data['top_tweets'] = topTweets;
    _data['key_words'] = keyWords.map((e)=>e.toJson()).toList();
    _data['user_indexes_value'] = userIndexesValue.map((e)=>e.toJson()).toList();
    return _data;
  }
}
class KeyWords {
  late String wordName;
  late num rank;

  KeyWords({
    required this.wordName,
    required this.rank,
  });

  KeyWords.fromJson(Map<String, dynamic> json) {
    wordName = json['word_name'];
    rank = json['rank'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['word_name'] = wordName;
    _data['rank'] = rank;
    return _data;
  }
}
class UserIndexesValue {
  late String markName;
  late String markDescription;
  late int markRank;
  late int fullMark;
  late String markResult;

  UserIndexesValue({
    required this.markName,
    required this.markDescription,
    required this.markRank,
    required this.fullMark,
    required this.markResult,
  });

  UserIndexesValue.fromJson(Map<String, dynamic> json) {
    markName = json['mark_name'];
    markDescription = json['mark_description'];
    markRank = json['mark_rank'];
    fullMark = json['full_mark'];
    markResult = json['mark_result'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['mark_name'] = markName;
    _data['mark_description'] = markDescription;
    _data['mark_rank'] = markRank;
    _data['full_mark'] = fullMark;
    _data['mark_result'] = markResult;
    return _data;
  }
}