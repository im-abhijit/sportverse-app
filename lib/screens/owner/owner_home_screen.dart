// TODO: Implement owner home screen with:
// - Tab navigation (Home, Bookings, Add Booking, Open Slots)
// - List of owner's venues
// - Stats (today's bookings, total revenue)
// - Pull to refresh

import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class OwnerHomeScreen extends StatelessWidget {
  const OwnerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: AppColors.primaryBlue,
      ),
      body: const Center(
        child: Text('Owner Home Screen - To be implemented'),
      ),
    );
  }
}

