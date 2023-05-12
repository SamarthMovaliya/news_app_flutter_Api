import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../models/news_api_model.dart';

class newsApiHelper {
  newsApiHelper._();

  static final newsApi = newsApiHelper._();

  Future<List<global>?> fetchNewsData(
      {required dynamic ct, required dynamic cou}) async {
    var dio = Dio();
    print(dio.toString());
    String country = cou;
    print(country);
    String categoryData = ct;
    print(categoryData);
    String path =
        'https://newsapi.org/v2/top-headlines?country=$country&category=$categoryData&apiKey=0a70f1a579a34654aeda313ddf3670f2';
    var res = await dio.get(path, queryParameters: {});

    print(res.statusCode);
    if (res.statusCode == 200) {
      List<global> allData = [];
      List articles = res.data['articles'];

      articles.forEach((e) {
        Map<String, dynamic> tempData = {
          'name': e['source']['name'].toString(),
          'author': e['author'].toString(),
          'title': e['title'].toString(),
          'description': e['description'].toString(),
          'urlToImage': (e['urlToImage'] == null)
              ? 'assets/images/news.png'
              : e['urlToImage'].toString(),
          'content': e['content'].toString(),
        };
        global temp = global.fromList(data: tempData);
        allData.add(temp);
      });
      print(res.data);
      return allData;
    }
    return null;
  }
}
