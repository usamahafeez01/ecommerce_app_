// lib/services/auth_service.dart
// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce_app/utlis/constants/api_constant.dart';
import 'package:flutter/foundation.dart';

import '../models/login_model.dart';
import '../models/user_profile_model.dart';


class AuthService {
  AuthService({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: ApiConstants.baseUrl,
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10),
                headers: {'Content-Type': 'application/json'},
              ),
            );

  final Dio _dio;

  /* ────────────────────────────── LOGIN ────────────────────────────── */

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {
          'username': request.username,
          'password': request.password,
        },
      );

      debugPrint('LOGIN RAW JSON → ${response.data}');

      if (response.statusCode == 200) {
        return LoginResponse.fromJson(response.data);
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: 'Unexpected status ${response.statusCode}',
      );
    } on DioException catch (e) {
      log('Login DioException → ${e.message}');
      rethrow;
    } catch (e) {
      log('Login Error → $e');
      rethrow;
    }
  }

  /* ─────────────────────────── FETCH PROFILE ────────────────────────── */
  Future<UserProfile> fetchUser(
    int id, {
    String? bearerToken,
  }) async {
    try {
      final res = await _dio.get(
        '/users/$id',
        options: bearerToken == null
            ? null
            : Options(headers: {'Authorization': 'Bearer $bearerToken'}),
      );

      log('PROFILE RAW JSON → ${res.data}');

      if (res.statusCode == 200) {
        return UserProfile.fromJson(res.data);
      }

      throw DioException(
        requestOptions: res.requestOptions,
        response: res,
        message: 'Unexpected status ${res.statusCode}',
      );
    } on DioException catch (e) {
      log('fetchUser DioException → ${e.message}');
      rethrow;
    } catch (e) {
      log('fetchUser Error → $e');
      rethrow;
    }
  }

  /* ─────────────── Helper: map FakeStore demo usernames → ids ───────── */

  ///
  int resolveFakeStoreId(String username) {
    switch (username) {
      case 'mor_2314':
        return 1;
      case 'kminchelle':
        return 2;
      default:
        throw Exception('Unknown FakeStore demo username');
    }
  }
}
