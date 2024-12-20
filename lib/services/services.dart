import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:news_app/models/news_hedlines_model.dart';
import 'package:news_app/models/news_categories_model.dart';

class Services {
  static Future<News_headlines_model> getbbcheadlinesapi(String source) async {
    final responce = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?sources=$source&apiKey=enteryourownapikey'));

    var data = jsonDecode(responce.body.toString());

    if (responce.statusCode == 200) {
      return News_headlines_model.fromJson(data);
    } else {
      throw Exception('Error to fetch Data from Model');
    }
  }

  static Future<NewsCategoryModel> News_category_api(String category) async {
    final responce = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=$category&apiKey=enteryouownapikey'));
    if (responce.statusCode == 200) {
      var data = jsonDecode(responce.body.toString());
      return NewsCategoryModel.fromJson(data);
    } else {
      throw Exception('Error to fetch data');
    }
  }
}
