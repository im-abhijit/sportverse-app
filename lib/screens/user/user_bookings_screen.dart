// TODO: Implement user bookings screen with:
// - List of user's bookings
// - Booking cards showing venue, date, time, amount, status
// - Filter by status (All, Confirmed, Paid, Initiated, Failed)
// - Pull to refresh

import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class UserBookingsScreen extends StatelessWidget {
  const UserBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
        backgroundColor: AppColors.primaryBlue,
      ),
      body: const Center(
        child: Text('User Bookings Screen - To be implemented'),
      ),
    );
  }
}

