// lib/repositories/user_repository.dart
import 'package:dio/dio.dart';
import 'package:ecommerce_app/models/user_profile_model.dart';

class UserRepository {
  final Dio _dio;
  UserRepository(this._dio);

  Future<UserProfile> fetchUser(int id) async {
    final res = await _dio.get('/users/$id');
    return UserProfile.fromJson(res.data as Map<String, dynamic>);
  }
}
