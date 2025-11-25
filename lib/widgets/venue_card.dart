import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/venue.dart';
import '../utils/colors.dart';
import '../utils/helpers.dart';

class VenueCard extends StatelessWidget {
  final Venue venue;
  final VoidCallback onTap;

  const VenueCard({
    super.key,
    required this.venue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final imageUri = venue.photos != null && venue.photos!.isNotEmpty
        ? Helpers.getImageUri(venue.photos!.first)
        : 'https://via.placeholder.com/400x160?text=No+Image';

    final primaryGame = venue.games != null && venue.games!.isNotEmpty
        ? venue.games!.first[0].toUpperCase() + venue.games!.first.substring(1)
        : 'Sports';

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 2),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: CachedNetworkImage(
                imageUrl: imageUri,
                width: double.infinity,
                height: 160,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 160,
                  color: AppColors.borderLightGrey,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 160,
                  color: AppColors.borderLightGrey,
                  child: const Icon(
                    LucideIcons.image,
                    size: 48,
                    color: AppColors.textGrey,
                  ),
                ),
              ),
            ),
            
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    venue.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        LucideIcons.map_pin,
                        size: 14,
                        color: AppColors.textGrey,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          venue.displayAddress,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textGrey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (venue.games != null && venue.games!.isNotEmpty)
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundGrey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            primaryGame,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.primaryBlue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (venue.games!.length > 1)
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              '+${venue.games!.length - 1} more',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textGrey,
                              ),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

