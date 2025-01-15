import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/api/api_constants.dart';
import 'package:news_app/api/end_points.dart';
import 'package:news_app/models/sources_responce.dart';
class ApiManager {
static Future<SourcesResponse?> getSources()async{
  //https://newsapi.org/v2/top-headlines/sources?apiKey=bdd5f7b37ecf45418e9fba7bca3a303e
  Uri url = Uri.https(ApiConstants.baseUrl,
    EndPoints.sourceApi,
    {
      'apiKey': ApiConstants.apiKey,
    }
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
}