import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/models/route_model.dart';

class RouteTimeline extends StatelessWidget {
  final List<RouteStop> stops;

  const RouteTimeline({super.key, required this.stops});

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.alt_route, color: AppTheme.secondary, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Corridor Progression',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Text(
                'Live Stop Manifest',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...stops.asMap().entries.map((entry) {
            final index = entry.key;
            final stop = entry.value;
            final isLast = index == stops.length - 1;

            return _buildTimelineItem(stop, isLast);
          }),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(RouteStop stop, bool isLast) {
    Color dotColor;
    Color lineColor;
    IconData? icon;

    if (stop.isPassed) {
      dotColor = AppTheme.secondary;
      lineColor = AppTheme.secondaryContainer;
      icon = Icons.check;
    } else if (stop.isCurrent) {
      dotColor = AppTheme.primaryContainer;
      lineColor = AppTheme.secondaryContainer;
      icon = Icons.directions_bus;
    } else {
      dotColor = AppTheme.surfaceContainerHigh;
      lineColor = AppTheme.surfaceContainerHigh;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
                boxShadow: stop.isCurrent
                    ? [
                        BoxShadow(
                          color: dotColor.withOpacity(0.3),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
              ),
              child: icon != null
                  ? Icon(
                      icon,
                      size: 14,
                      color: stop.isPassed || stop.isCurrent ? Colors.white : AppTheme.outline,
                    )
                  : Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppTheme.outline,
                        shape: BoxShape.circle,
                      ),
                    ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 48,
                color: lineColor,
                margin: const EdgeInsets.symmetric(vertical: 4),
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(
              bottom: isLast ? 0 : 12,
              left: stop.isCurrent ? 12 : 0,
              right: stop.isCurrent ? 12 : 0,
              top: stop.isCurrent ? 8 : 0,
            ),
            decoration: stop.isCurrent
                ? BoxDecoration(
                    color: AppTheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(8),
                  )
                : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              stop.name,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: stop.isCurrent ? FontWeight.w700 : FontWeight.w600,
                                color: stop.isPassed || stop.isCurrent
                                    ? AppTheme.onSurface
                                    : AppTheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                          if (stop.isCurrent) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppTheme.errorContainer,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Bus 4102 HERE',
                                style: GoogleFonts.inter(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.onErrorContainer,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      stop.isPassed
                          ? 'Passed 14:10'
                          : stop.isCurrent
                              ? '1 min out'
                              : '${(stop.sequenceNumber * 4)} mins',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: stop.isCurrent ? FontWeight.w600 : FontWeight.w400,
                        color: stop.isCurrent ? AppTheme.error : AppTheme.outline,
                      ),
                    ),
                  ],
                ),
                if (stop.description != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    stop.description!,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
                if (stop.isCurrent)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Container(),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
