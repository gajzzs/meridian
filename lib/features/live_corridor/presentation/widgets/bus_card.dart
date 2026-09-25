import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/models/bus_model.dart';

class BusCard extends StatelessWidget {
  final BusModel bus;

  const BusCard({super.key, required this.bus});

  @override
  Widget build(BuildContext context) {
    final isComfort = bus.type == 'comfort';

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: isComfort
            ? Border.all(
                color: AppTheme.tertiaryFixedDim.withOpacity(0.3),
                width: 2,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isComfort ? 0.1 : 0.05),
            blurRadius: isComfort ? 8 : 4,
          ),
        ],
      ),
      child: Column(
        children: [
          if (isComfort)
            Container(
              height: 4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.tertiaryFixedDim,
                    AppTheme.onTertiaryContainer,
                    AppTheme.secondary,
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isComfort
                            ? AppTheme.tertiaryContainer
                            : AppTheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        isComfort ? Icons.airline_seat_recline_extra : Icons.directions_bus,
                        color: isComfort ? AppTheme.tertiaryFixedDim : AppTheme.secondary,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                bus.number,
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 18,
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
                                  color: isComfort ? AppTheme.tertiaryFixed : AppTheme.surfaceContainer,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  isComfort ? 'COMFORT VIP' : 'Standard',
                                  style: GoogleFonts.inter(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w700,
                                    color: isComfort ? AppTheme.onTertiaryFixed : AppTheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            isComfort
                                ? 'AsteriskPath Express Cabin • AC 21°C'
                                : 'Govt E-Bus Fleet • Non-AC',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: isComfort ? AppTheme.secondary : AppTheme.onSurfaceVariant,
                              fontWeight: isComfort ? FontWeight.w500 : FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: AppTheme.metricDisplay,
                            children: [
                              TextSpan(text: '${bus.etaMinutes}'),
                              TextSpan(
                                text: ' min',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: AppTheme.onSurfaceVariant,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              bus.etaMinutes <= 3 ? Icons.schedule : Icons.navigation,
                              size: 12,
                              color: bus.etaMinutes <= 3 ? AppTheme.error : AppTheme.secondary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              bus.etaMinutes <= 3 ? 'Imminent' : '${(bus.etaMinutes * 0.2).toStringAsFixed(1)} km away',
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: bus.etaMinutes <= 3 ? AppTheme.error : AppTheme.secondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isComfort
                        ? AppTheme.surfaceContainerLow
                        : AppTheme.errorContainer.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: isComfort ? const Color(0xFF10B981) : AppTheme.error,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    bus.occupancyStatus + (isComfort ? ' (${bus.occupancyPercentage.toInt()}% Full)' : ' (${bus.occupancyPercentage.toInt()}% Full)'),
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: isComfort ? AppTheme.onSurface : AppTheme.onErrorContainer,
                                    ),
                                  ),
                                  Text(
                                    isComfort
                                        ? '${bus.maxCapacity - bus.currentOccupancy} seats open • Chilled 21°C Active'
                                        : 'Standing room only • Packed entryway',
                                    style: GoogleFonts.inter(
                                      fontSize: 10,
                                      color: isComfort
                                          ? AppTheme.onSurfaceVariant
                                          : AppTheme.onErrorContainer.withOpacity(0.8),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                isComfort ? 'Guaranteed Fare' : 'Base Fare',
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  color: AppTheme.onSurfaceVariant,
                                ),
                              ),
                              Text(
                                '₹${bus.totalFare}',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Density Telemetry',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: AppTheme.onSurfaceVariant,
                            ),
                          ),
                          Text(
                            '${bus.currentOccupancy}/${bus.maxCapacity} Pax',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: AppTheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: bus.occupancyPercentage / 100,
                          minHeight: 6,
                          backgroundColor: AppTheme.surfaceContainerHigh,
                          valueColor: AlwaysStoppedAnimation(
                            isComfort ? const Color(0xFF10B981) : AppTheme.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (isComfort) ...[
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.tertiaryContainer,
                      foregroundColor: AppTheme.tertiaryFixedDim,
                      minimumSize: const Size(double.infinity, 44),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.verified_user, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          'Claim Guaranteed Seat',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.speed, size: 14, color: AppTheme.onSurfaceVariant),
                        const SizedBox(width: 4),
                        Text(
                          '${bus.averageSpeed.toInt()} km/h avg',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.timelapse, size: 14, color: AppTheme.onSurfaceVariant),
                        const SizedBox(width: 4),
                        Text(
                          'ETA Destination: ${(bus.etaMinutes + 20)}m',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
