// lib/services/api_service.dart

import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService()
      : _dio = Dio(BaseOptions(
          baseUrl: 'https://jsonplaceholder.org',
          responseType: ResponseType.json,
        ));

  /// Tüm postları getirir
  Future<List<dynamic>> getPosts() async {
    final response = await _dio.get('/posts');

    if (response.statusCode == 200) {
      print(response.data.runtimeType); // Verinin tipini yazdırır
      return response.data;
    } else {
      throw Exception('Postlar yüklenemedi: ${response.statusCode}');
    }
  }

  /// Belirli bir postu ID ile getirir
  Future<dynamic> getPostById(int id) async {
    final response = await _dio.get('/posts/$id');

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Post yüklenemedi: ${response.statusCode}');
    }
  }
}
