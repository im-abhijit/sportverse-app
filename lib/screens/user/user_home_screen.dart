import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import '../../providers/venue_provider.dart';
import '../../widgets/venue_card.dart';
import '../../widgets/custom_dropdown.dart';
import '../../utils/colors.dart';
import '../../config/app_config.dart';
import '../../models/venue.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  String? _selectedCity;
  String? _selectedSport;

  @override
  void initState() {
    super.initState();
    // Clear any previous filters
    final venueProvider = Provider.of<VenueProvider>(context, listen: false);
    venueProvider.clearFilters();
  }

  void _handleCitySelect(String city) {
    setState(() {
      _selectedCity = city;
      _selectedSport = null; // Reset sport when city changes
    });
    final venueProvider = Provider.of<VenueProvider>(context, listen: false);
    venueProvider.fetchVenuesByCity(city);
    venueProvider.setSelectedSport(null);
  }

  void _handleSportSelect(String? sport) {
    setState(() {
      _selectedSport = sport;
    });
    final venueProvider = Provider.of<VenueProvider>(context, listen: false);
    venueProvider.setSelectedSport(sport);
  }

  void _handleVenueTap(Venue venue) {
    final venueJson = venue.toJson();
    context.push(
      '/user/venue/${venue.id}?venue=${Uri.encodeComponent(venueJson.toString())}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      body: Consumer<VenueProvider>(
        builder: (context, venueProvider, child) {
          return CustomScrollView(
            slivers: [
              // Header with gradient
              SliverToBoxAdapter(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: AppColors.primaryGradient,
                    ),
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Find a Venue',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                icon: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    LucideIcons.user,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                onPressed: () {
                                  // Navigate to profile
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          
                          // Filters
                          Row(
                            children: [
                              Expanded(
                                child: CustomDropdown(
                                  options: AppConfig.cities,
                                  selected: _selectedCity,
                                  onSelect: _handleCitySelect,
                                  placeholder: 'Select City',
                                  icon: LucideIcons.mapPin,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomDropdown(
                                  options: AppConfig.sports,
                                  selected: _selectedSport,
                                  onSelect: _handleSportSelect,
                                  placeholder: _selectedCity != null
                                      ? 'Select Sport'
                                      : 'Select City First',
                                  icon: LucideIcons.calendar,
                                  enabled: _selectedCity != null,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          
                          // Search Bar
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  LucideIcons.search,
                                  size: 18,
                                  color: Colors.white70,
                                ),
                                SizedBox(width: 12),
                                Text(
                                  'Search venues...',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              
              // Content
              if (!_selectedCity)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: _buildEmptyState(),
                )
              else if (venueProvider.isLoading)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: _buildLoadingState(),
                )
              else if (venueProvider.filteredVenues.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: _buildEmptyVenuesState(venueProvider),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final venue = venueProvider.filteredVenues[index];
                      return VenueCard(
                        venue: venue,
                        onTap: () => _handleVenueTap(venue),
                      );
                    },
                    childCount: venueProvider.filteredVenues.length,
                  ),
                ),
            ],
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: AppColors.borderGrey, width: 1),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, -2),
                blurRadius: 8,
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () => context.push('/user/bookings'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'My Bookings',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(40),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 4),
              blurRadius: 12,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              LucideIcons.mapPin,
              size: 48,
              color: AppColors.primaryBlue,
            ),
            const SizedBox(height: 16),
            const Text(
              'Select City to See Venues',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Please select a city from the dropdown above to view available venues',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textGrey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: AppColors.primaryBlue,
          ),
          SizedBox(height: 16),
          Text(
            'Loading venues...',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyVenuesState(VenueProvider venueProvider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            LucideIcons.mapPin,
            size: 48,
            color: AppColors.textLightGrey,
          ),
          const SizedBox(height: 16),
          Text(
            venueProvider.errorMessage ??
                (_selectedSport != null
                    ? 'No $_selectedSport venues found in $_selectedCity'
                    : 'No venues found in $_selectedCity'),
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textGrey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

