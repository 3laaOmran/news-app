import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:news_app/api/api_constants.dart';
import 'package:news_app/api/end_points.dart';
import 'package:news_app/models/news_response.dart';
import 'package:news_app/models/sources_response.dart';

@singleton
class ApiManager {
  // static ApiManager?  _instance;
  // ApiManager._();
  // static ApiManager getApiManagerInstance(){
  //   _instance ??= ApiManager._();
  //   return _instance!;
  // }
  Future<SourcesResponse?> getSources(String categoryId) async {
    Uri url = Uri.https(ApiConstants.baseUrl,
    EndPoints.sourceApi,
    {
      'apiKey': ApiConstants.apiKey, 'category': categoryId}
  );
  try {
    var response =await http.get(url);
    var responseBody = response.body;
    var json = jsonDecode(responseBody);
    return SourcesResponse.fromJson(json);
  } catch (e) {
    rethrow;
  }
}

  Future<NewsResponse?> getNewsBySourceId(String sourceId) async {
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.newsApi,
        {'apiKey': ApiConstants.apiKey, 'sources': sourceId});
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return NewsResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  static Future<NewsResponse?> getSearch(String value) async {
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.newsApi,
        {'apiKey': ApiConstants.apiKey, 'q': value});
    try {
      var response = await http.get(url);
      return NewsResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      rethrow;
    }
  }
}