class AppConfig {
  // API Base URL
  static const String apiBaseUrl = 
      'https://inbound-column-477004-d1.el.r.appspot.com';
  
  // API Endpoints
  static const String generateOtpEndpoint = '/api/auth/generate-otp';
  static const String verifyOtpEndpoint = '/api/auth/verify-otp';
  static const String venuesByCityEndpoint = '/api/venues/city';
  static const String venuesByPartnerEndpoint = '/api/venues/partner';
  static const String slotsEndpoint = '/api/slots';
  static const String bookingsByUserEndpoint = '/api/bookings/user';
  static const String bookingsByPartnerEndpoint = '/api/bookings/partner';
  
  // App Info
  static const String appName = 'SportVerse';
  static const String appTagline = 'Book Your Game, Play Your Way';
  
  // Cities
  static const List<String> cities = ['Bareilly'];
  
  // Sports
  static const List<String> sports = [
    'Cricket',
    'Football',
    'Badminton',
    'Tennis',
    'Basketball',
    'Volleyball',
  ];
}

