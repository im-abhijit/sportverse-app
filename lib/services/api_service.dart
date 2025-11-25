import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  Future<Map<String, dynamic>> _makeRequest(
    String endpoint,
    String method, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final url = Uri.parse('${AppConfig.apiBaseUrl}$endpoint');
      
      http.Response response;
      
      final requestHeaders = {
        'Content-Type': 'application/json',
        ...?headers,
      };

      switch (method.toUpperCase()) {
        case 'GET':
          response = await http.get(url, headers: requestHeaders);
          break;
        case 'POST':
          response = await http.post(
            url,
            headers: requestHeaders,
            body: body != null ? jsonEncode(body) : null,
          );
          break;
        case 'PUT':
          response = await http.put(
            url,
            headers: requestHeaders,
            body: body != null ? jsonEncode(body) : null,
          );
          break;
        case 'DELETE':
          response = await http.delete(url, headers: requestHeaders);
          break;
        default:
          throw Exception('Unsupported HTTP method: $method');
      }

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return responseData;
      } else {
        throw Exception(responseData['message'] ?? 'Request failed');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  // Auth APIs
  Future<Map<String, dynamic>> generateOtp(String phoneNumber, {String channel = 'sms'}) async {
    return await _makeRequest(
      AppConfig.generateOtpEndpoint,
      'POST',
      body: {
        'phoneNumber': phoneNumber,
        'channel': channel,
      },
    );
  }

  Future<Map<String, dynamic>> verifyOtp(String phoneNumber, String code) async {
    return await _makeRequest(
      AppConfig.verifyOtpEndpoint,
      'POST',
      body: {
        'phoneNumber': phoneNumber,
        'code': code,
      },
    );
  }

  // Venue APIs
  Future<Map<String, dynamic>> getVenuesByCity(String city) async {
    return await _makeRequest(
      '${AppConfig.venuesByCityEndpoint}/$city',
      'GET',
    );
  }

  Future<Map<String, dynamic>> getVenuesByPartner(int partnerId) async {
    return await _makeRequest(
      '${AppConfig.venuesByPartnerEndpoint}/$partnerId',
      'GET',
    );
  }

  // Slot APIs
  Future<Map<String, dynamic>> getSlots(int venueId, String date) async {
    return await _makeRequest(
      '${AppConfig.slotsEndpoint}?venueId=$venueId&date=$date',
      'GET',
    );
  }

  // Booking APIs
  Future<Map<String, dynamic>> getBookingsByUser(int userId) async {
    return await _makeRequest(
      '${AppConfig.bookingsByUserEndpoint}/$userId',
      'GET',
    );
  }

  Future<Map<String, dynamic>> getBookingsByPartner(int partnerId) async {
    return await _makeRequest(
      '${AppConfig.bookingsByPartnerEndpoint}/$partnerId',
      'GET',
    );
  }
}

