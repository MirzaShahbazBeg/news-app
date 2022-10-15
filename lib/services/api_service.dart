import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:news_app/models/news_model.dart';

class ApiService {
  Future<List<Article>> getnews() async {
    final Url = Uri.parse(
        "https://newsapi.org/v2/everything?q=keyword&apiKey=933054873c14482e9ed1be016f2235fe");

    Response response = await get(Url);
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> body = json['articles'];
      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();
      return articles;
    } else {
      throw ('Cant get the Articles');
    }
  }

  Future<List<Article>> getarticles(String text) async {
    if (text != null) {
      final Url = Uri.parse(
          "https://newsapi.org/v2/everything?q=$text&apiKey=933054873c14482e9ed1be016f2235fe");
      Response response = await get(Url);
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        List<dynamic> body = json['articles'];
        List<Article> articles =
            body.map((dynamic item) => Article.fromJson(item)).toList();
        return articles;
      } else {
        throw ('Cant get the Articles');
      }
    } else {
      final Url = Uri.parse(
          "https://newsapi.org/v2/everything?q=keyword&apiKey=933054873c14482e9ed1be016f2235fe");
      Response response = await get(Url);
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        List<dynamic> body = json['articles'];
        List<Article> articles =
            body.map((dynamic item) => Article.fromJson(item)).toList();
        return articles;
      } else {
        throw ('Cant get the Articles');
      }
    }
    // final Url = Uri.parse(
    //     "https://newsapi.org/v2/everything?q=$text&apiKey=933054873c14482e9ed1be016f2235fe");

    // Response response = await get(Url);
    // if (response.statusCode == 200) {
    //   Map<String, dynamic> json = jsonDecode(response.body);
    //   List<dynamic> body = json['articles'];
    //   List<Article> articles =
    //       body.map((dynamic item) => Article.fromJson(item)).toList();
    //   return articles;
    // } else {
    //   throw ('Cant get the Articles');
    // }
  }
}

//Your API key is: 933054873c14482e9ed1be016f2235fe