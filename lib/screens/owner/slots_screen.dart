import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class SlotsScreen extends StatelessWidget {
  const SlotsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Open Slots'),
        backgroundColor: AppColors.primaryBlue,
      ),
      body: const Center(
        child: Text('Slots Screen - To be implemented'),
      ),
    );
  }
}

