import 'package:flutter/foundation.dart';
import '../models/venue.dart';
import '../services/api_service.dart';

class VenueProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  List<Venue> _venues = [];
  bool _isLoading = false;
  String? _errorMessage;
  String? _selectedCity;
  String? _selectedSport;

  List<Venue> get venues => _venues;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get selectedCity => _selectedCity;
  String? get selectedSport => _selectedSport;

  List<Venue> get filteredVenues {
    if (_selectedSport == null || _selectedSport!.isEmpty) {
      return _venues;
    }
    return _venues.where((venue) {
      if (venue.games == null || venue.games!.isEmpty) return false;
      return venue.games!.any(
        (game) => game.toLowerCase() == _selectedSport!.toLowerCase(),
      );
    }).toList();
  }

  Future<void> fetchVenuesByCity(String city) async {
    _isLoading = true;
    _errorMessage = null;
    _selectedCity = city;
    notifyListeners();

    try {
      final response = await _apiService.getVenuesByCity(city);
      
      if (response['success'] == true) {
        final data = response['data'] as List<dynamic>?;
        _venues = data != null
            ? data.map((json) => Venue.fromJson(json as Map<String, dynamic>)).toList()
            : [];
      } else {
        _errorMessage = response['message'] ?? 'Failed to fetch venues';
        _venues = [];
      }
    } catch (e) {
      _errorMessage = e.toString();
      _venues = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchVenuesByPartner(int partnerId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.getVenuesByPartner(partnerId);
      
      if (response['success'] == true) {
        final data = response['data'] as List<dynamic>?;
        _venues = data != null
            ? data.map((json) => Venue.fromJson(json as Map<String, dynamic>)).toList()
            : [];
      } else {
        _errorMessage = response['message'] ?? 'Failed to fetch venues';
        _venues = [];
      }
    } catch (e) {
      _errorMessage = e.toString();
      _venues = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setSelectedSport(String? sport) {
    _selectedSport = sport;
    notifyListeners();
  }

  void clearFilters() {
    _selectedCity = null;
    _selectedSport = null;
    _venues = [];
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}

