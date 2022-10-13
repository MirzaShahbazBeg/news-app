import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:news_app/models/news_model.dart';

class ApiService {
  Future<NewsModel> getNews() async {
    final Url = Uri.parse(
        "https://newsapi.org/v2/everything?q=keyword&apiKey=933054873c14482e9ed1be016f2235fe");

    Response response = await get(Url);
    if (response.statusCode != 200) {}
    var json = jsonDecode(response.body);
    // print(json);
    return NewsModel.fromJson(json);
  }

  Future<List<Article>> getarticles() async {
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
}

//Your API key is: 933054873c14482e9ed1be016f2235fe