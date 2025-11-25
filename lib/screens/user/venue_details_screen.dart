// TODO: Implement venue details screen with:
// - Image carousel
// - Venue info (name, address, rating, games, facilities)
// - Date selection (next 7 days)
// - Time slot selection
// - Book Now button
// - Payment modal with QR code

import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class VenueDetailsScreen extends StatelessWidget {
  final String venueId;
  final String venueJson;

  const VenueDetailsScreen({
    super.key,
    required this.venueId,
    required this.venueJson,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Venue Details'),
        backgroundColor: AppColors.primaryBlue,
      ),
      body: const Center(
        child: Text('Venue Details Screen - To be implemented'),
      ),
    );
  }
}

