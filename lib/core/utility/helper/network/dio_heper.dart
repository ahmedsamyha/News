import 'package:dio/dio.dart';

class ApiService {
  final _baseUrl = 'https://newsapi.org/v2/';
  final _apiKey = '1c8942a0dbf647eab3af0214598fae14';
  final Dio dio;

  ApiService({required this.dio});
  Future<Map<String, dynamic>> get(
      {required String endPoint,
      required String lang,
      required String token}) async {
    var response = await dio.get('$_baseUrl/endPoint/sources?apiKey=$_apiKey'
       /* options: Options(headers: {
          'lang': lang,
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        })*/
    );
    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    required String lang,
    required String token,
    required dynamic data,
  }) async {
    var response = await dio.post(
      '$_baseUrl$endPoint',
      data: data,
      options: Options(
        headers: {
          'lang': lang,
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      ),
    );
    return response.data;
  }
}
