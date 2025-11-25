import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'config/app_config.dart';
import 'providers/auth_provider.dart';
import 'providers/venue_provider.dart';
import 'providers/booking_provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/otp_screen.dart';
import 'screens/user/user_home_screen.dart';
import 'screens/user/venue_details_screen.dart';
import 'screens/user/user_bookings_screen.dart';
import 'screens/owner/owner_home_screen.dart';
import 'screens/owner/owner_bookings_screen.dart';
import 'screens/owner/slots_screen.dart';
import 'screens/owner/add_booking_screen.dart';
import 'screens/index_screen.dart';
import 'utils/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  
  runApp(const SportVerseApp());
}

class SportVerseApp extends StatelessWidget {
  const SportVerseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => VenueProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
      ],
      child: MaterialApp.router(
        title: 'SportVerse',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Inter',
          scaffoldBackgroundColor: AppColors.backgroundGrey,
          useMaterial3: true,
        ),
        routerConfig: _router,
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const IndexScreen(),
    ),
    GoRoute(
      path: '/auth/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/auth/owner-login',
      builder: (context, state) => const LoginScreen(isOwner: true),
    ),
    GoRoute(
      path: '/auth/otp',
      builder: (context, state) {
        final phoneNumber = state.uri.queryParameters['phone'] ?? '';
        final isOwner = state.uri.queryParameters['isOwner'] == 'true';
        return OtpScreen(phoneNumber: phoneNumber, isOwner: isOwner);
      },
    ),
    // User routes
    GoRoute(
      path: '/user',
      builder: (context, state) => const UserHomeScreen(),
    ),
    GoRoute(
      path: '/user/venue/:id',
      builder: (context, state) {
        final venueId = state.pathParameters['id'] ?? '';
        final venueJson = state.uri.queryParameters['venue'] ?? '';
        return VenueDetailsScreen(venueId: venueId, venueJson: venueJson);
      },
    ),
    GoRoute(
      path: '/user/bookings',
      builder: (context, state) => const UserBookingsScreen(),
    ),
    // Owner routes
    GoRoute(
      path: '/owner',
      builder: (context, state) => const OwnerHomeScreen(),
    ),
    GoRoute(
      path: '/owner/bookings',
      builder: (context, state) => const OwnerBookingsScreen(),
    ),
    GoRoute(
      path: '/owner/slots',
      builder: (context, state) => const SlotsScreen(),
    ),
    GoRoute(
      path: '/owner/add-booking',
      builder: (context, state) => const AddBookingScreen(),
    ),
  ],
);

