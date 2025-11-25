import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class AddBookingScreen extends StatelessWidget {
  const AddBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Booking'),
        backgroundColor: AppColors.primaryBlue,
      ),
      body: const Center(
        child: Text('Add Booking Screen - To be implemented'),
      ),
    );
  }
}

