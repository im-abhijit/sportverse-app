// TODO: Implement owner bookings screen with:
// - List of all bookings for owner's venues
// - Filter by status
// - Stats (today's bookings, total revenue)
// - Booking cards with details

import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class OwnerBookingsScreen extends StatelessWidget {
  const OwnerBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings'),
        backgroundColor: AppColors.primaryBlue,
      ),
      body: const Center(
        child: Text('Owner Bookings Screen - To be implemented'),
      ),
    );
  }
}

