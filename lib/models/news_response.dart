import 'package:hive/hive.dart';
import 'package:news_app/models/sources_response.dart';

part 'news_response.g.dart';

@HiveType(typeId: 3)
class NewsResponse extends HiveObject {
  @HiveField(0)
  String? status;
  @HiveField(1)
  int? totalResults;
  @HiveField(2)
  List<News>? articles;
  @HiveField(3)
  String? code;
  @HiveField(4)
  String? message;

  NewsResponse({
    this.status,
    this.code,
    this.message,
    this.totalResults,
    this.articles,
  });

  NewsResponse.fromJson(dynamic json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = [];
      json['articles'].forEach((v) {
        articles?.add(News.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['code'] = code;
    map['message'] = message;
    map['totalResults'] = totalResults;
    if (articles != null) {
      map['articles'] = articles?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

@HiveType(typeId: 4)
class News extends HiveObject {
  @HiveField(0)
  Source? source;
  @HiveField(1)
  String? author;
  @HiveField(3)
  String? title;
  @HiveField(4)
  String? description;
  @HiveField(5)
  String? url;
  @HiveField(6)
  String? urlToImage;
  @HiveField(7)
  String? publishedAt;
  @HiveField(8)
  String? content;

  News({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  News.fromJson(dynamic json) {
    source = json['source'] != null ? Source.fromJson(json['source']) : null;
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (source != null) {
      map['source'] = source?.toJson();
    }
    map['author'] = author;
    map['title'] = title;
    map['description'] = description;
    map['url'] = url;
    map['urlToImage'] = urlToImage;
    map['publishedAt'] = publishedAt;
    map['content'] = content;
    return map;
  }
}
