import '../services/storage_service.dart';
import '../services/api_service.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';

class AuthService {
  final ApiService _apiService = ApiService();

  Future<Map<String, dynamic>> sendOtp(String phoneNumber, {String channel = 'sms'}) async {
    final formattedPhone = Helpers.formatPhoneNumber(phoneNumber);
    return await _apiService.generateOtp(formattedPhone, channel: channel);
  }

  Future<Map<String, dynamic>> verifyOtp(String phoneNumber, String code) async {
    final formattedPhone = Helpers.formatPhoneNumber(phoneNumber);
    final response = await _apiService.verifyOtp(formattedPhone, code);
    
    if (response['success'] == true && response['valid'] == true) {
      // Store user data
      if (response['userId'] != null) {
        await StorageService.setSecureItem(
          AppConstants.userIdKey,
          response['userId'].toString(),
        );
      }
      
      if (response['userName'] != null) {
        await StorageService.setSecureItem(
          AppConstants.userNameKey,
          response['userName'].toString(),
        );
      }
      
      // Store partner data if owner
      if (response['partnerId'] != null) {
        await StorageService.setSecureItem(
          AppConstants.partnerIdKey,
          response['partnerId'].toString(),
        );
      }
      
      if (response['partnerName'] != null) {
        await StorageService.setSecureItem(
          AppConstants.partnerNameKey,
          response['partnerName'].toString(),
        );
      }
    }
    
    return response;
  }

  Future<String?> getUserId() async {
    return await StorageService.getSecureItem(AppConstants.userIdKey);
  }

  Future<String?> getUserName() async {
    return await StorageService.getSecureItem(AppConstants.userNameKey);
  }

  Future<String?> getPartnerId() async {
    return await StorageService.getSecureItem(AppConstants.partnerIdKey);
  }

  Future<String?> getPartnerName() async {
    return await StorageService.getSecureItem(AppConstants.partnerNameKey);
  }

  Future<bool> isAuthenticated() async {
    final userId = await getUserId();
    final partnerId = await getPartnerId();
    return userId != null || partnerId != null;
  }

  Future<void> logout() async {
    await StorageService.clearAll();
  }
}

