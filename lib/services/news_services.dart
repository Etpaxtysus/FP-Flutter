import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';

class NewsService {
  static const String _apiKey = '18606cb135ac400f8ad2514e41fc327a';
  static const String _baseUrl =
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=$_apiKey';

  static Future<List<News>> fetchNews({int limit = 10, int page = 1}) async {
    try {
      final response = await http.get(Uri.parse(
          '$_baseUrl&page=$page&pageSize=$limit'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> articles = data['articles'];
        return articles.map((json) => News.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }

  static Future<List<News>> searchNews(String keyword) async {
    try {
      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/everything?q=$keyword&apiKey=$_apiKey'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> articles = data['articles'];
        return articles.map((json) => News.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search news');
      }
    } catch (e) {
      throw Exception('Error searching news: $e');
    }
  }
}
