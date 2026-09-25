import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';

class TierCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String example;
  final int baseFare;
  final int comfortFare;
  final int premiumAmount;
  final int premiumPercentage;
  final List<String> features;
  final bool isPopular;

  const TierCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.example,
    required this.baseFare,
    required this.comfortFare,
    required this.premiumAmount,
    required this.premiumPercentage,
    required this.features,
    this.isPopular = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isPopular)
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: const BoxDecoration(
                  color: AppTheme.secondary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: Text(
                  'Popular Route',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    color: AppTheme.onSecondary,
                  ),
                ),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            subtitle,
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: AppTheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      example,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppTheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        '₹$baseFare',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          decoration: TextDecoration.lineThrough,
                          color: AppTheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '₹$comfortFare',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '+₹$premiumAmount premium (+$premiumPercentage%)',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.tertiaryContainer,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: features.map((feature) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getFeatureIcon(feature),
                      size: 14,
                      color: AppTheme.onSecondaryContainer,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      feature,
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: AppTheme.onSecondaryContainer,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  IconData _getFeatureIcon(String feature) {
    if (feature.contains('Seat')) return Icons.event_seat;
    if (feature.contains('GPS')) return Icons.radar;
    if (feature.contains('Express')) return Icons.speed;
    if (feature.contains('Recliner')) return Icons.chair;
    if (feature.contains('Charging')) return Icons.power;
    if (feature.contains('Standing')) return Icons.group_off;
    return Icons.check_circle;
  }
}
