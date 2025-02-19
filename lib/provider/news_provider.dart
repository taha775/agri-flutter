import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class NewsProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> posts = [];
  final Dio _dio = Dio();

  Future<void> getLatestNews() async {
    try {
      final response = await _dio.get(
        'https://newsapi.org/v2/top-headlines',
        queryParameters: {
          'country': 'us',
          'apiKey': '45a53c79a43b483f8abce538c13e7683',
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        posts.clear();

        for (final post in data['articles']) {
          posts.add({
            'username': post['author'] ?? 'Unknown',
            'postContent': post['title'],
            'profileImagePath': post['urlToImage'] ?? '',
            'postImagePath': post['urlToImage'] ?? '',
            'isLiked': false,
          });
        }
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching news: $e');
    }
  }
}
