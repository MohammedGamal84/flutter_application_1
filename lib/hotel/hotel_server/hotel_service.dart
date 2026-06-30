import 'package:dio/dio.dart';
import 'package:flutter_application_1/auth/services/api_constants.dart';
import 'package:flutter_application_1/auth/services/api_service.dart';
import 'package:flutter_application_1/hotel/hotel_server/hotel_model.dart';

class HotelService {
  final ApiService _apiService = ApiService();

  Future<List<HotelModel>> getAllHotels() async {
    try {
      final Response response =
          await _apiService.dio.get(ApiConstants.getAllHotels);
      print("HOTELS STATUS: ${response.statusCode}");
      print("HOTELS RESPONSE: ${response.data}");

      final dynamic data = response.data;

      // لو رجع List مباشرة
      if (data is List) {
        return data.map((e) => HotelModel.fromJson(e)).toList();
      }

      // لو رجع Map
      if (data is Map<String, dynamic>) {

        // hotels مباشرة
        if (data['hotels'] is List) {
          return (data['hotels'] as List)
              .map((e) => HotelModel.fromJson(e))
              .toList();
        }

        // data عبارة عن List
        if (data['data'] is List) {
          return (data['data'] as List)
              .map((e) => HotelModel.fromJson(e))
              .toList();
        }

        // ✅ الحالة المهمة
        if (data['data'] is Map<String, dynamic>) {
          final dataMap = data['data'];

          if (dataMap['hotels'] is List) {
            return (dataMap['hotels'] as List)
                .map((e) => HotelModel.fromJson(e))
                .toList();
          }
        }
      }

      return [];
    } catch (e, s) {
  print("GET HOTELS ERROR: $e");
  print("STACK TRACE: $s");
  rethrow;
}
  }
}