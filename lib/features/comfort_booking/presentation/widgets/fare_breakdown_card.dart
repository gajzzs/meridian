import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';

class FareBreakdownCard extends StatelessWidget {
  final int baseFare;
  final int comfortPremium;
  final double distance;
  final bool isComfortTier;

  const FareBreakdownCard({
    super.key,
    required this.baseFare,
    required this.comfortPremium,
    required this.distance,
    required this.isComfortTier,
  });

  @override
  Widget build(BuildContext context) {
    final totalFare = baseFare + comfortPremium;
    final operatorBenefit = (comfortPremium * 0.75).toInt();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Fare Breakdown & Operator Support',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.tertiaryFixed,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '100% TRANSPARENT',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.onTertiaryFixed,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildFareRow(
            'Base Operator Fare (${distance.toStringAsFixed(1)} km)',
            '₹${baseFare.toStringAsFixed(2)}',
            false,
          ),
          if (isComfortTier) ...[
            const SizedBox(height: 8),
            _buildFareRow(
              'Comfort Experience Premium',
              '+₹${comfortPremium.toStringAsFixed(2)}',
              true,
              isHighlighted: true,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.handshake,
                        size: 14,
                        color: AppTheme.onSecondaryContainer,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Fleet Upgrade Fund (75% of fee):',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color: AppTheme.onSecondaryContainer,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '₹${operatorBenefit.toStringAsFixed(2)} to Bus Owner',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.onSecondaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 12),
          Container(
            height: 1,
            color: AppTheme.surfaceContainerHighest,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Payable',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '₹$totalFare',
                style: AppTheme.metricDisplay.copyWith(fontSize: 28),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFareRow(
    String label,
    String amount,
    bool showInfo, {
    bool isHighlighted = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: isHighlighted
                    ? AppTheme.secondary
                    : AppTheme.onSurfaceVariant,
                fontWeight: isHighlighted ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
            if (showInfo) ...[
              const SizedBox(width: 4),
              const Icon(
                Icons.info_outline,
                size: 14,
                color: AppTheme.secondary,
              ),
            ],
          ],
        ),
        Text(
          amount,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isHighlighted ? AppTheme.secondary : AppTheme.onSurface,
          ),
        ),
      ],
    );
  }
}
