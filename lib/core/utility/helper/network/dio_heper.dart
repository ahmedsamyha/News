import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;
  ApiService({required this.dio});

  final _baseUrl = 'https://newsapi.org/v2';
  final _apiKey = '3e88ae5d08814f7e96fd8161788b124b';

  Future<Map<String, dynamic>> get({required String endPoint}) async {
    try {
      var response = await dio.get(
        '$_baseUrl/$endPoint',
        queryParameters: {'apiKey': _apiKey},
      );
      return response.data;
    } catch (e) {
      throw Exception('API call failed: $e');
    }
  }
}