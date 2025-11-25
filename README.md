# SportVerse Flutter App

A Flutter recreation of the SportVerse mobile app - Book Your Game, Play Your Way.

## Features

- **User Flow**: Browse venues, filter by city/sport, view details, book slots
- **Owner Flow**: Manage venues, view bookings, add bookings, manage slots
- **Authentication**: OTP-based phone number authentication
- **Payment**: UPI QR code payment integration
- **WhatsApp Integration**: Send booking confirmations via WhatsApp

## Getting Started

1. Install Flutter SDK (if not already installed)
2. Get dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── main.dart
├── config/
│   └── app_config.dart
├── models/
│   ├── venue.dart
│   ├── booking.dart
│   ├── slot.dart
│   └── user.dart
├── services/
│   ├── api_service.dart
│   ├── auth_service.dart
│   └── storage_service.dart
├── providers/
│   ├── auth_provider.dart
│   ├── venue_provider.dart
│   └── booking_provider.dart
├── screens/
│   ├── auth/
│   │   ├── login_screen.dart
│   │   └── otp_screen.dart
│   ├── user/
│   │   ├── user_home_screen.dart
│   │   ├── venue_details_screen.dart
│   │   └── bookings_screen.dart
│   └── owner/
│       ├── owner_home_screen.dart
│       ├── venues_screen.dart
│       ├── bookings_screen.dart
│       └── slots_screen.dart
├── widgets/
│   ├── venue_card.dart
│   ├── booking_card.dart
│   ├── slot_card.dart
│   └── custom_dropdown.dart
└── utils/
    ├── colors.dart
    ├── constants.dart
    └── helpers.dart
```

## API Configuration

Set your API base URL in `lib/config/app_config.dart`:
```dart
const String apiBaseUrl = 'https://inbound-column-477004-d1.el.r.appspot.com';
```

## Build

### Android
```bash
flutter build apk
# or
flutter build appbundle
```

### iOS
```bash
flutter build ios
```

