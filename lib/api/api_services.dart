import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/model/news_model.dart';

class ApiServices {
  List<ArticleModel> news = [];

  Future<void> getData() async {
    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=e57d0be5c6e04d06b84d212096578fad");
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    print(jsonData);

    if (jsonData['status'] == "ok") {
      return jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
          );
          news.add(articleModel);
        }
      });
    }
  }
}
