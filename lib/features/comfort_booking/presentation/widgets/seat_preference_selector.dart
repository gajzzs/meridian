import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';

class SeatPreferenceSelector extends StatelessWidget {
  final String selected;
  final Function(String) onSelect;

  const SeatPreferenceSelector({
    super.key,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'SEAT PREFERENCE',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
                color: AppTheme.onSurfaceVariant,
              ),
            ),
            Text(
              'Free Allocation',
              style: GoogleFonts.inter(
                fontSize: 10,
                color: AppTheme.secondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildSeatOption(
                icon: Icons.window,
                label: 'Window',
                description: 'Tawi River View',
                value: 'window',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildSeatOption(
                icon: Icons.airline_seat_recline_normal,
                label: 'Aisle',
                description: 'Easy Exit',
                value: 'aisle',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildSeatOption(
                icon: Icons.volume_off,
                label: 'Quiet Zone',
                description: 'Front Cabin',
                value: 'quiet',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSeatOption({
    required IconData icon,
    required String label,
    required String description,
    required String value,
  }) {
    final isSelected = selected == value;

    return InkWell(
      onTap: () => onSelect(value),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryContainer : AppTheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? AppTheme.onPrimary : AppTheme.onSurfaceVariant,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
                color: isSelected ? AppTheme.onPrimary : AppTheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            Text(
              description,
              style: GoogleFonts.inter(
                fontSize: 10,
                color: isSelected
                    ? AppTheme.onPrimary.withOpacity(0.75)
                    : AppTheme.onSurfaceVariant.withOpacity(0.75),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
