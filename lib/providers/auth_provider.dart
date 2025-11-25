import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';
import '../utils/constants.dart';
import '../services/storage_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  
  bool _isLoading = false;
  bool _isAuthenticated = false;
  bool _isReady = false;
  String? _userId;
  String? _userName;
  String? _partnerId;
  String? _partnerName;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;
  bool get isReady => _isReady;
  String? get userId => _userId;
  String? get userName => _userName;
  String? get partnerId => _partnerId;
  String? get partnerName => _partnerName;
  String? get errorMessage => _errorMessage;

  AuthProvider() {
    _init();
  }

  Future<void> _init() async {
    _isReady = false;
    notifyListeners();
    
    try {
      _userId = await _authService.getUserId();
      _userName = await _authService.getUserName();
      _partnerId = await _authService.getPartnerId();
      _partnerName = await _authService.getPartnerName();
      _isAuthenticated = await _authService.isAuthenticated();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isReady = true;
      notifyListeners();
    }
  }

  Future<bool> sendOtp(String phoneNumber, {String channel = 'sms'}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _authService.sendOtp(phoneNumber, channel: channel);
      _isLoading = false;
      
      if (response['success'] == true) {
        notifyListeners();
        return true;
      } else {
        _errorMessage = response['message'] ?? 'Failed to send OTP';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> verifyOtp(String phoneNumber, String code) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _authService.verifyOtp(phoneNumber, code);
      _isLoading = false;
      
      if (response['success'] == true && response['valid'] == true) {
        // Reload user data
        await _init();
        notifyListeners();
        return true;
      } else {
        _errorMessage = response['message'] ?? 'Invalid OTP code';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authService.logout();
      _userId = null;
      _userName = null;
      _partnerId = null;
      _partnerName = null;
      _isAuthenticated = false;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}

