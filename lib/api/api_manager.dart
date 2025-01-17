import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/api/api_constants.dart';
import 'package:news_app/api/end_points.dart';
import 'package:news_app/models/news_response.dart';
import 'package:news_app/models/sources_response.dart';

class ApiManager {
  static Future<SourcesResponse?> getSources(String categoryId) async {
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

  static Future<NewsResponse?> getNewsBySourceId(String sourceId) async {
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
}