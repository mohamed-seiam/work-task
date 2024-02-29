import 'package:dio/dio.dart';
import 'package:work_task/core/network/api_constant.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late Dio _dio;

  factory ApiClient() {
    return _instance;
  }

  ApiClient._internal() {
    _dio = Dio();
    _dio.options.baseUrl = ApiConstants.apiBaseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 6);
    _dio.options.receiveTimeout = const Duration(seconds: 8);
  }

  Future<Map<String, dynamic>> getUsers({int skip = 10}) async {
    final response = await _dio.get(ApiConstants.usersEndPoint,
        queryParameters: {'limit': 10, 'skip': skip});
    return response.data;
  }

  Future<Map<String, dynamic>> searchUsers(String query) async {
    final response = await _dio
        .get(ApiConstants.searchEndPoint, queryParameters: {'q': query});
    return response.data;
  }

  Dio get dio => _dio;
}
