import 'package:intl/intl.dart';

class Helpers {
  // Format phone number to include country code
  static String formatPhoneNumber(String phone) {
    if (phone.isEmpty) return '';
    
    String cleaned = phone.replaceAll(RegExp(r'[^\d+]'), '');
    
    // Remove leading + if present
    if (cleaned.startsWith('+')) {
      cleaned = cleaned.substring(1);
    }
    
    // Remove leading 0 if present
    if (cleaned.startsWith('0')) {
      cleaned = cleaned.substring(1);
    }
    
    // Add 91 country code if not present
    if (!cleaned.startsWith('91')) {
      cleaned = '91$cleaned';
    }
    
    return '+$cleaned';
  }
  
  // Format date for display
  static String formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('EEE, MMM d', 'en_US').format(date);
    } catch (e) {
      return dateString;
    }
  }
  
  // Get image URI from base64 string
  static String getImageUri(String? base64String) {
    if (base64String == null || base64String.isEmpty) {
      return 'https://via.placeholder.com/400x160?text=No+Image';
    }
    
    String base64 = base64String.trim().replaceAll(RegExp(r'\s'), '');
    
    // Check if already has data URI prefix
    if (base64.startsWith('data:')) {
      return base64;
    }
    
    // Detect image type
    String mimeType = 'image/jpeg'; // default
    if (base64.startsWith('iVBORw0KGgo')) {
      mimeType = 'image/png';
    } else if (base64.startsWith('/9j/')) {
      mimeType = 'image/jpeg';
    } else if (base64.startsWith('UklGR')) {
      mimeType = 'image/webp';
    }
    
    return 'data:$mimeType;base64,$base64';
  }
  
  // Format date for WhatsApp message
  static String formatDateForWhatsApp(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final day = date.day.toString().padLeft(2, '0');
      final monthNames = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];
      final month = monthNames[date.month - 1];
      final year = date.year;
      return '$day $month $year';
    } catch (e) {
      return dateString;
    }
  }
  
  // Get local date string (yyyy-MM-dd)
  static String getLocalDateString() {
    final date = DateTime.now();
    final year = date.year;
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }
  
  // Get next 7 days
  static List<Map<String, dynamic>> getNext7Days() {
    final dates = <Map<String, dynamic>>[];
    for (int i = 0; i < 7; i++) {
      final date = DateTime.now().add(Duration(days: i));
      final year = date.year;
      final month = date.month.toString().padLeft(2, '0');
      final day = date.day.toString().padLeft(2, '0');
      final dateString = '$year-$month-$day';
      
      dates.add({
        'date': dateString,
        'day': DateFormat('EEE', 'en_US').format(date),
        'dayNum': date.day,
      });
    }
    return dates;
  }
}

