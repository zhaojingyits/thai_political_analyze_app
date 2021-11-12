
class DashboardSummary {
  late String datetime;
  late int continueHours;
  late String userInterfaceLanguage;
  late Details details;

  DashboardSummary({
    required this.datetime,
    required this.continueHours,
    required this.userInterfaceLanguage,
    required this.details,
  });

  DashboardSummary.fromJson(Map<String, dynamic> json) {
    datetime = json['datetime'];
    continueHours = json['continue_hours'];
    userInterfaceLanguage = json['user_interface_language'];
    details = Details.fromJson(json['details']);
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['datetime'] = datetime;
    _data['continue_hours'] = continueHours;
    _data['user_interface_language'] = userInterfaceLanguage;
    _data['details'] = details.toJson();
    return _data;
  }
}
class Details {
  late int tweetsCount;
  late int tweetsCountVariance;
  late int retweet;
  late int retweetVariance;
  late int favorite;
  late int favoriteVariance;
  late int reply;
  late int replyVariance;
  late int quote;
  late int quoteVariance;
  late int hashtag;
  late int hashtagVariance;
  late int verified;
  late int verifiedVariance;
  late int media;
  late int mediaVariance;
  late double lengthAvg;
  late double lengthAvgVariance;
  late List<Topics> topics;
  late String generalEvaluation;
  late List<Prediction> prediction;
  late ChinaRelated chinaRelated;
  late ClassifyAnalyzeResult classifyAnalyzeResult;

  Details({
    required this.tweetsCount,
    required this.tweetsCountVariance,
    required this.retweet,
    required this.retweetVariance,
    required this.favorite,
    required this.favoriteVariance,
    required this.reply,
    required this.replyVariance,
    required this.quote,
    required this.quoteVariance,
    required this.hashtag,
    required this.hashtagVariance,
    required this.verified,
    required this.verifiedVariance,
    required this.media,
    required this.mediaVariance,
    required this.lengthAvg,
    required this.lengthAvgVariance,
    required this.topics,
    required this.generalEvaluation,
    required this.prediction,
    required this.chinaRelated,
    required this.classifyAnalyzeResult,
  });

  Details.fromJson(Map<String, dynamic> json) {
    tweetsCount = json['tweets_count'];
    tweetsCountVariance = json['tweets_count_variance'];
    retweet = json['retweet'];
    retweetVariance = json['retweet_variance'];
    favorite = json['favorite'];
    favoriteVariance = json['favorite_variance'];
    reply = json['reply'];
    replyVariance = json['reply_variance'];
    quote = json['quote'];
    quoteVariance = json['quote_variance'];
    hashtag = json['hashtag'];
    hashtagVariance = json['hashtag_variance'];
    verified = json['verified'];
    verifiedVariance = json['verified_variance'];
    media = json['media'];
    mediaVariance = json['media_variance'];
    lengthAvg = json['length_avg'];
    lengthAvgVariance = json['length_avg_variance'];
    topics = List<dynamic>.from(json['topics']).map((e)=>Topics.fromJson(e)).toList();
    generalEvaluation = json['general_evaluation'];
    prediction = List<dynamic>.from(json['prediction']).map((e)=>Prediction.fromJson(e)).toList();
    chinaRelated = ChinaRelated.fromJson(json['china_related']);
    classifyAnalyzeResult = ClassifyAnalyzeResult.fromJson(json['classify_analyze_result']);
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['tweets_count'] = tweetsCount;
    _data['tweets_count_variance'] = tweetsCountVariance;
    _data['retweet'] = retweet;
    _data['retweet_variance'] = retweetVariance;
    _data['favorite'] = favorite;
    _data['favorite_variance'] = favoriteVariance;
    _data['reply'] = reply;
    _data['reply_variance'] = replyVariance;
    _data['quote'] = quote;
    _data['quote_variance'] = quoteVariance;
    _data['hashtag'] = hashtag;
    _data['hashtag_variance'] = hashtagVariance;
    _data['verified'] = verified;
    _data['verified_variance'] = verifiedVariance;
    _data['media'] = media;
    _data['media_variance'] = mediaVariance;
    _data['length_avg'] = lengthAvg;
    _data['length_avg_variance'] = lengthAvgVariance;
    _data['topics'] = topics.map((e)=>e.toJson()).toList();
    _data['general_evaluation'] = generalEvaluation;
    _data['prediction'] = prediction.map((e)=>e.toJson()).toList();
    _data['china_related'] = chinaRelated.toJson();
    _data['classify_analyze_result'] = classifyAnalyzeResult.toJson();
    return _data;
  }
}
class Topics {
  late String word;
  late String translated;
  late int rank;

  Topics({
    required this.word,
    required this.translated,
    required this.rank,
  });

  Topics.fromJson(Map<String, dynamic> json) {
    word = json['word'];
    translated = json['translated'];
    rank = json['rank'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['word'] = word;
    _data['translated'] = translated;
    _data['rank'] = rank;
    return _data;
  }
}
class Prediction {
  late String predictItem;
  late String predictValue;
  late List<int>? formerValue;
  late List<String>? formerKey;
  late String? description;

  Prediction({
    required this.predictItem,
    required this.predictValue,
    required this.formerValue,
    required this.formerKey,
    required this.description,
  });

  Prediction.fromJson(Map<String, dynamic> json) {
    predictItem = json['predict_item'];
    predictValue = json['predict_value'];
    formerValue = json['former_value'] != null?List<int>.from(json['former_value']):null;
    formerKey = json['former_key'] != null?List<String>.from(json['former_key']):null;
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['predict_item'] = predictItem;
    _data['predict_value'] = predictValue;
    _data['former_value'] = formerValue;
    _data['former_key'] = formerKey;
    _data['description'] = description;
    return _data;
  }
}
class ChinaRelated {
  late int count;
  late int pages;
  late int onePageCount;
  late TweetsPage tweetsPage;

  ChinaRelated({
    required this.count,
    required this.pages,
    required this.onePageCount,
    required this.tweetsPage,
  });

  ChinaRelated.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    pages = json['pages'];
    onePageCount = json['one_page_count'];
    tweetsPage = TweetsPage.fromJson(json['tweets_page']);
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['count'] = count;
    _data['pages'] = pages;
    _data['one_page_count'] = onePageCount;
    _data['tweets_page'] = tweetsPage.toJson();
    return _data;
  }
}
class TweetsPage {
  late String datetime;
  late int continueHours;
  late String topic;
  late int pageNumber;
  late String sortedBy;
  late List<PageContent> pageContent;

  TweetsPage({
    required this.datetime,
    required this.continueHours,
    required this.topic,
    required this.pageNumber,
    required this.sortedBy,
    required this.pageContent,
  });

  TweetsPage.fromJson(Map<String, dynamic> json) {
    datetime = json['datetime'];
    continueHours = json['continue_hours'];
    topic = json['topic'];
    pageNumber = json['page_number'];
    sortedBy = json['sorted_by'];
    pageContent = List<dynamic>.from(json['page_content']).map((e)=>PageContent.fromJson(e)).toList();
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['datetime'] = datetime;
    _data['continue_hours'] = continueHours;
    _data['topic'] = topic;
    _data['page_number'] = pageNumber;
    _data['sorted_by'] = sortedBy;
    _data['page_content'] = pageContent.map((e)=>e.toJson()).toList();
    return _data;
  }
}
class PageContent {
  late String createdAt;
  late String idStr;
  late String conversationIdStr;
  late String fullText;
  late String lang;
  late bool favorited;
  late bool retweeted;
  late int retweetCount;
  late int favoriteCount;
  late int replyCount;
  late int quoteCount;
  late String quotedStatusIdStr;
  late String quotedStatusShortUrl;
  late String quotedStatusExpandUrl;
  late String userIdStr;
  late String userName;
  late String userFullName;
  late bool userVerified;
  late String inReplyToStatusIdStr;
  late String inReplyToUserIdStr;
  late List<String> hashtags;
  late List<Null> urls;
  late List<Null> media;

  PageContent({
    required this.createdAt,
    required this.idStr,
    required this.conversationIdStr,
    required this.fullText,
    required this.lang,
    required this.favorited,
    required this.retweeted,
    required this.retweetCount,
    required this.favoriteCount,
    required this.replyCount,
    required this.quoteCount,
    required this.quotedStatusIdStr,
    required this.quotedStatusShortUrl,
    required this.quotedStatusExpandUrl,
    required this.userIdStr,
    required this.userName,
    required this.userFullName,
    required this.userVerified,
    required this.inReplyToStatusIdStr,
    required this.inReplyToUserIdStr,
    required this.hashtags,
    required this.urls,
    required this.media,
  });

  PageContent.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    idStr = json['id_str'];
    conversationIdStr = json['conversation_id_str'];
    fullText = json['full_text'];
    lang = json['lang'];
    favorited = json['favorited'];
    retweeted = json['retweeted'];
    retweetCount = json['retweet_count'];
    favoriteCount = json['favorite_count'];
    replyCount = json['reply_count'];
    quoteCount = json['quote_count'];
    quotedStatusIdStr = json['quoted_status_id_str'];
    quotedStatusShortUrl = json['quoted_status_short_url'];
    quotedStatusExpandUrl = json['quoted_status_expand_url'];
    userIdStr = json['user_id_str'];
    userName = json['user_name'];
    userFullName = json['user_full_name'];
    userVerified = json['user_verified'];
    inReplyToStatusIdStr = json['in_reply_to_status_id_str'];
    inReplyToUserIdStr = json['in_reply_to_user_id_str'];
    hashtags = List<String>.from(json['hashtags']);
    urls = List<Null>.from(json['urls']);
    media = List<Null>.from(json['media']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['created_at'] = createdAt;
    _data['id_str'] = idStr;
    _data['conversation_id_str'] = conversationIdStr;
    _data['full_text'] = fullText;
    _data['lang'] = lang;
    _data['favorited'] = favorited;
    _data['retweeted'] = retweeted;
    _data['retweet_count'] = retweetCount;
    _data['favorite_count'] = favoriteCount;
    _data['reply_count'] = replyCount;
    _data['quote_count'] = quoteCount;
    _data['quoted_status_id_str'] = quotedStatusIdStr;
    _data['quoted_status_short_url'] = quotedStatusShortUrl;
    _data['quoted_status_expand_url'] = quotedStatusExpandUrl;
    _data['user_id_str'] = userIdStr;
    _data['user_name'] = userName;
    _data['user_full_name'] = userFullName;
    _data['user_verified'] = userVerified;
    _data['in_reply_to_status_id_str'] = inReplyToStatusIdStr;
    _data['in_reply_to_user_id_str'] = inReplyToUserIdStr;
    _data['hashtags'] = hashtags;
    _data['urls'] = urls;
    _data['media'] = media;
    return _data;
  }
}
class ClassifyAnalyzeResult {
  late int newsCount;
  late int discussionCount;
  late int newsPageCount;
  late int discussionPageCount;
  late TweetsPage newsPage;
  late TweetsPage discussionPage;

  ClassifyAnalyzeResult({
    required this.newsCount,
    required this.discussionCount,
    required this.newsPageCount,
    required this.discussionPageCount,
    required this.newsPage,
    required this.discussionPage,
  });

  ClassifyAnalyzeResult.fromJson(Map<String, dynamic> json) {
    newsCount = json['news_count'];
    discussionCount = json['discussion_count'];
    newsPageCount = json['news_page_count'];
    discussionPageCount = json['discussion_page_count'];
    newsPage = TweetsPage.fromJson(json['news_page']);
    discussionPage = TweetsPage.fromJson(json['discussion_page']);
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['news_count'] = newsCount;
    _data['discussion_count'] = discussionCount;
    _data['news_page_count'] = newsPageCount;
    _data['discussion_page_count'] = discussionPageCount;
    _data['news_page'] = newsPage.toJson();
    _data['discussion_page'] = discussionPage.toJson();
    return _data;
  }
}
