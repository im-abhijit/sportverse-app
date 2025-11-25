import 'package:flutter/foundation.dart';
import '../models/booking.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../utils/constants.dart';

class BookingProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  List<Booking> _bookings = [];
  bool _isLoading = false;
  String? _errorMessage;
  String? _selectedFilter = 'All';

  List<Booking> get bookings => _bookings;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get selectedFilter => _selectedFilter;

  List<Booking> get filteredBookings {
    if (_selectedFilter == 'All') return _bookings;
    return _bookings.where((booking) => booking.bookingStatus == _selectedFilter).toList();
  }

  int get todaysBookings {
    final today = DateTime.now().toIso8601String().split('T')[0];
    return _bookings.where((booking) => booking.date == today).length;
  }

  double get totalRevenue {
    return _bookings
        .where((booking) => booking.paymentStatus == AppConstants.paymentStatusSuccess)
        .fold(0.0, (sum, booking) => sum + booking.amount);
  }

  Future<void> fetchUserBookings() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final userIdStr = await StorageService.getSecureItem(AppConstants.userIdKey);
      if (userIdStr == null) {
        _errorMessage = 'User ID not found';
        _bookings = [];
        _isLoading = false;
        notifyListeners();
        return;
      }

      final userId = int.parse(userIdStr);
      final response = await _apiService.getBookingsByUser(userId);
      
      if (response['success'] == true) {
        final data = response['data'] as List<dynamic>?;
        _bookings = data != null
            ? data.map((json) => Booking.fromJson(json as Map<String, dynamic>)).toList()
            : [];
      } else {
        _errorMessage = response['message'] ?? 'Failed to fetch bookings';
        _bookings = [];
      }
    } catch (e) {
      _errorMessage = e.toString();
      _bookings = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPartnerBookings() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final partnerIdStr = await StorageService.getSecureItem(AppConstants.partnerIdKey);
      if (partnerIdStr == null) {
        _errorMessage = 'Partner ID not found';
        _bookings = [];
        _isLoading = false;
        notifyListeners();
        return;
      }

      final partnerId = int.parse(partnerIdStr);
      final response = await _apiService.getBookingsByPartner(partnerId);
      
      if (response['success'] == true) {
        final data = response['data'] as List<dynamic>?;
        _bookings = data != null
            ? data.map((json) => Booking.fromJson(json as Map<String, dynamic>)).toList()
            : [];
      } else {
        _errorMessage = response['message'] ?? 'Failed to fetch bookings';
        _bookings = [];
      }
    } catch (e) {
      _errorMessage = e.toString();
      _bookings = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setSelectedFilter(String filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}

