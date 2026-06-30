import 'package:dio/dio.dart';
import 'package:flutter_application_1/home/home_model/home_model.dart';
import 'package:flutter_application_1/auth/services/api_constants.dart';
import 'package:flutter_application_1/auth/services/api_service.dart';

class HomeService {
  final ApiService _apiService = ApiService();

  Future<List<HomeModel>> getAllHomes() async {
    try {
      final Response response =
          await _apiService.dio.get(ApiConstants.getAllHomes);

      print(
          "GET ALL HOMES URL: ${_apiService.dio.options.baseUrl}${ApiConstants.getAllHomes}");
      print("GET ALL HOMES STATUS: ${response.statusCode}");
      print("GET ALL HOMES RESPONSE: ${response.data}");

      final dynamic responseData = response.data;

      if (responseData is List) {
        return responseData.map((e) => HomeModel.fromJson(e)).toList();
      }

      if (responseData is Map<String, dynamic>) {
        if (responseData['data'] is List) {
          return (responseData['data'] as List)
              .map((e) => HomeModel.fromJson(e))
              .toList();
        }

        if (responseData['homes'] is List) {
          return (responseData['homes'] as List)
              .map((e) => HomeModel.fromJson(e))
              .toList();
        }

        if (responseData['allHomes'] is List) {
          return (responseData['allHomes'] as List)
              .map((e) => HomeModel.fromJson(e))
              .toList();
        }

        if (responseData['results'] is List) {
          return (responseData['results'] as List)
              .map((e) => HomeModel.fromJson(e))
              .toList();
        }

        if (responseData['data'] is Map<String, dynamic>) {
          final dataMap = responseData['data'];

          if (dataMap['homes'] is List) {
            return (dataMap['homes'] as List)
                .map((e) => HomeModel.fromJson(e))
                .toList();
          }

          if (dataMap['allHomes'] is List) {
            return (dataMap['allHomes'] as List)
                .map((e) => HomeModel.fromJson(e))
                .toList();
          }

          if (dataMap['results'] is List) {
            return (dataMap['results'] as List)
                .map((e) => HomeModel.fromJson(e))
                .toList();
          }
        }
      }

      print("GET ALL HOMES: No matching data format found");
      return [];
    } catch (e) {
      print("GET ALL HOMES ERROR: $e");
      throw Exception('فشل تحميل الأماكن: $e');
    }
  }

  Future<HomeModel> getHomeById(String id) async {
    try {
      final Response response = await _apiService.dio.get(
        ApiConstants.getHome,
        queryParameters: {"id": id},
      );

      print(
          "GET HOME URL: ${_apiService.dio.options.baseUrl}${ApiConstants.getHome}?id=$id");
      print("GET HOME STATUS: ${response.statusCode}");
      print("GET HOME RESPONSE: ${response.data}");

      final dynamic responseData = response.data;

      if (responseData is Map<String, dynamic>) {
        if (responseData['data'] is Map<String, dynamic>) {
          return HomeModel.fromJson(responseData['data']);
        }

        if (responseData['home'] is Map<String, dynamic>) {
          return HomeModel.fromJson(responseData['home']);
        }

        if (responseData['result'] is Map<String, dynamic>) {
          return HomeModel.fromJson(responseData['result']);
        }

        return HomeModel.fromJson(responseData);
      }

      throw Exception("صيغة البيانات غير متوقعة");
    } catch (e) {
      print("GET HOME ERROR: $e");
      throw Exception('فشل تحميل تفاصيل المكان: $e');
    }
  }
}