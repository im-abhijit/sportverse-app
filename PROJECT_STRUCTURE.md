# SportVerse Flutter App - Project Structure

This document outlines the complete project structure and implementation status.

## ✅ Completed Files

### Configuration & Setup
- ✅ `pubspec.yaml` - Dependencies and project configuration
- ✅ `lib/main.dart` - App entry point with routing
- ✅ `lib/config/app_config.dart` - API endpoints and app constants
- ✅ `lib/utils/colors.dart` - Color palette matching original design
- ✅ `lib/utils/constants.dart` - App-wide constants
- ✅ `lib/utils/helpers.dart` - Utility functions

### Models
- ✅ `lib/models/venue.dart` - Venue data model
- ✅ `lib/models/slot.dart` - Time slot model
- ✅ `lib/models/booking.dart` - Booking model

### Services
- ✅ `lib/services/api_service.dart` - HTTP API client
- ✅ `lib/services/auth_service.dart` - Authentication service
- ✅ `lib/services/storage_service.dart` - Secure storage wrapper

### Providers (State Management)
- ✅ `lib/providers/auth_provider.dart` - Authentication state
- ✅ `lib/providers/venue_provider.dart` - Venue data state
- ✅ `lib/providers/booking_provider.dart` - Booking data state

### Screens
- ✅ `lib/screens/index_screen.dart` - Landing page with role selection
- ✅ `lib/screens/auth/login_screen.dart` - Phone number login
- ✅ `lib/screens/auth/otp_screen.dart` - OTP verification

## 📝 Remaining Files to Create

### User Flow Screens
- `lib/screens/user/user_home_screen.dart` - Browse venues with filters
- `lib/screens/user/venue_details_screen.dart` - Venue details with booking
- `lib/screens/user/user_bookings_screen.dart` - User's booking history

### Owner Flow Screens
- `lib/screens/owner/owner_home_screen.dart` - Owner dashboard
- `lib/screens/owner/owner_bookings_screen.dart` - Owner's bookings management
- `lib/screens/owner/slots_screen.dart` - Manage time slots
- `lib/screens/owner/add_booking_screen.dart` - Add new booking

### Widgets
- `lib/widgets/venue_card.dart` - Venue list item card
- `lib/widgets/booking_card.dart` - Booking list item card
- `lib/widgets/slot_card.dart` - Time slot selection card
- `lib/widgets/custom_dropdown.dart` - Custom dropdown filter
- `lib/widgets/payment_modal.dart` - Payment QR code modal
- `lib/widgets/gradient_header.dart` - Reusable gradient header

## 🎨 Design Specifications

### Colors
- Primary Blue: `#2563EB` (hsl(221, 83%, 53%))
- Primary Green: `#16A34A` (hsl(150, 70%, 40%))
- Accent Yellow: `#FCD34D` (hsl(48, 96%, 53%))
- Accent Dark: `#78350F` (hsl(26, 83%, 14%))
- Background: `#F1F5F9` (hsl(210, 40%, 96.1%))

### Typography
- Font Family: Inter
- Weights: Regular (400), Medium (500), SemiBold (600), Bold (700), ExtraBold (800)

### Key Features to Implement
1. **Gradient Headers** - Blue to green gradient on all main screens
2. **Venue Cards** - Image, name, address, games tags
3. **Date Selection** - Horizontal scrollable date picker (next 7 days)
4. **Time Slots** - Selectable slot cards with price
5. **Payment Modal** - QR code generation and WhatsApp integration
6. **Tab Navigation** - Bottom tabs for owner flow
7. **Pull to Refresh** - On all list screens
8. **Loading States** - Activity indicators during API calls
9. **Error Handling** - User-friendly error messages

## 📱 Screen Flow

### User Flow
1. Index → Login → OTP → User Home
2. User Home → Venue Details → Booking → Payment Modal
3. User Home → My Bookings

### Owner Flow
1. Index → Owner Login → OTP → Owner Home (Tabs)
2. Owner Home → Venues → Venue Details
3. Owner Home → Bookings → Booking Details
4. Owner Home → Slots → Manage Slots
5. Owner Home → Add Booking

## 🔧 Next Steps

1. Create remaining screen files
2. Create reusable widget components
3. Add image assets to `assets/images/`
4. Test API integration
5. Add error boundaries and loading states
6. Implement pull-to-refresh
7. Add payment QR code generation
8. Integrate WhatsApp URL launcher

## 📦 Dependencies Used

- `provider` - State management
- `go_router` - Navigation
- `http` - API calls
- `flutter_secure_storage` - Secure data storage
- `cached_network_image` - Image loading
- `qr_flutter` - QR code generation
- `url_launcher` - Open WhatsApp/UPI apps
- `flutter_lucide_icons` - Icons matching original design
- `intl` - Date formatting

