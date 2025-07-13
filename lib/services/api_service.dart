// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';


class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://fakestoreapi.com"));

  Future<Response> post(String path, Map<String, dynamic> data) =>
      _dio.post(path, data: data);

  Future<Response> get(String path) => _dio.get(path);
}
