import 'package:dio/dio.dart';
import 'package:flutter_application_1/auth/services/api_constants.dart';
import 'package:flutter_application_1/auth/services/api_service.dart';
import 'package:flutter_application_1/location/location_serv/location_model.dart';

class LocationService {
  final ApiService _apiService = ApiService();

  Future<List<LocationModel>> getAllLocations() async {
    try {
      final Response response =
          await _apiService.dio.get(ApiConstants.getAllLocations);

      print("LOCATION STATUS: ${response.statusCode}");
      print("LOCATION RESPONSE: ${response.data}");

      final dynamic data = response.data;

      // لو رجع List مباشرة
      if (data is List) {
        return data.map((e) => LocationModel.fromJson(e)).toList();
      }

      // لو رجع Map
      if (data is Map<String, dynamic>) {

        // locations مباشرة
        if (data['locations'] is List) {
          return (data['locations'] as List)
              .map((e) => LocationModel.fromJson(e))
              .toList();
        }

        // data عبارة عن List
        if (data['data'] is List) {
          return (data['data'] as List)
              .map((e) => LocationModel.fromJson(e))
              .toList();
        }

        // ✅ الحالة المهمة
        if (data['data'] is Map<String, dynamic>) {
          final dataMap = data['data'];

          if (dataMap['locations'] is List) {
            return (dataMap['locations'] as List)
                .map((e) => LocationModel.fromJson(e))
                .toList();
          }
        }
      }

      return [];
    } catch (e) {
      print("GET LOCATIONS ERROR: $e");
      throw Exception("فشل تحميل الأماكن");
    }
  }
}