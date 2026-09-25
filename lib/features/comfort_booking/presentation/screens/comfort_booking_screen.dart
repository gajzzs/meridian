import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/providers/bus_provider.dart';
import '../../../../core/providers/booking_provider.dart';
import '../../../../core/models/booking_model.dart';
import '../widgets/tier_card.dart';
import '../widgets/seat_preference_selector.dart';
import '../widgets/fare_breakdown_card.dart';

class ComfortBookingScreen extends StatefulWidget {
  const ComfortBookingScreen({super.key});

  @override
  State<ComfortBookingScreen> createState() => _ComfortBookingScreenState();
}

class _ComfortBookingScreenState extends State<ComfortBookingScreen> {
  bool isComfortTier = true;
  String selectedSeat = 'window';

  @override
  Widget build(BuildContext context) {
    final busProvider = Provider.of<BusProvider>(context);
    final route = busProvider.selectedRoute;

    if (route == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final baseFare = route.calculateFare(false);
    final comfortFare = route.calculateFare(true);
    final premium = comfortFare - baseFare;

    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildAppBar(context),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildHeroBanner(),
                  const SizedBox(height: 16),
                  _buildTierCards(baseFare, premium),
                  const SizedBox(height: 16),
                  _buildTripConfigurator(route),
                  const SizedBox(height: 16),
                  _buildTravelClassSelector(baseFare, comfortFare),
                  const SizedBox(height: 16),
                  SeatPreferenceSelector(
                    selected: selectedSeat,
                    onSelect: (seat) => setState(() => selectedSeat = seat),
                  ),
                  const SizedBox(height: 16),
                  FareBreakdownCard(
                    baseFare: baseFare,
                    comfortPremium: isComfortTier ? premium : 0,
                    distance: route.distanceKm,
                    isComfortTier: isComfortTier,
                  ),
                  const SizedBox(height: 16),
                  _buildOccupancyTelemetry(),
                  const SizedBox(height: 16),
                  _buildBookingButton(context, baseFare, premium),
                  const SizedBox(height: 16),
                  _buildGuaranteeCard(),
                  const SizedBox(height: 32),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      floating: true,
      snap: true,
      backgroundColor: AppTheme.surface.withOpacity(0.85),
      elevation: 0,
      title: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.directions_bus,
              color: AppTheme.surfaceVariant,
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
                      'AsteriskPath',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.onSurface,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'JAMMU',
                        style: GoogleFonts.inter(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.onSecondaryContainer,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFF10B981),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Comfort Tier Booking',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.onSurfaceVariant,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          width: 32,
          height: 32,
          decoration: const BoxDecoration(
            color: AppTheme.primary,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.person,
            color: AppTheme.onPrimary,
            size: 18,
          ),
        ),
      ],
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryContainer,
            AppTheme.primaryContainer.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.tertiaryFixed,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'CIVIC COMFORT INITIATIVE',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.onTertiaryFixed,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Row(
                children: [
                  const Icon(
                    Icons.eco,
                    size: 14,
                    color: AppTheme.tertiaryFixedDim,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Direct Operator Support',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      color: AppTheme.surfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Peace of mind on every Jammu mile.',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppTheme.onPrimary,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Pay a bit extra for guaranteed seat, air conditioning, and peaceful commute. Your extra fare directly supports operator fleet upgrades!',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: AppTheme.surfaceVariant,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildFeatureChip(Icons.airline_seat_recline_extra, 'Max 40% Cap'),
              const SizedBox(width: 12),
              _buildFeatureChip(Icons.ac_unit, 'Chilled Cabin'),
              const SizedBox(width: 12),
              _buildFeatureChip(Icons.verified, '100% Guarantee'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppTheme.secondaryContainer),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 10,
            color: AppTheme.surfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildTierCards(int baseFare, int premium) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Standardized Tiers',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Transparent municipal transit tariffs',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Fixed By J&K DTC',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        TierCard(
          title: 'Short Distance Tier',
          subtitle: '< 5 km',
          example: 'e.g., Jewel Chowk → Bikram Chowk',
          baseFare: 10,
          comfortFare: 18,
          premiumAmount: 8,
          premiumPercentage: 80,
          features: const [
            'Guaranteed Seating',
            'Instant Express Gate Entry',
          ],
        ),
        const SizedBox(height: 8),
        TierCard(
          title: 'Medium Distance Tier',
          subtitle: '5 - 15 km',
          example: 'e.g., Bus Stand → Gandhi Nagar / Satwari',
          baseFare: 25,
          comfortFare: 35,
          premiumAmount: 10,
          premiumPercentage: 40,
          features: const [
            'Reserved Priority Seat',
            'Live GPS ETA Telemetry',
          ],
        ),
        const SizedBox(height: 8),
        TierCard(
          title: 'Long Distance Tier',
          subtitle: '> 15 km',
          example: 'e.g., Jammu Tawi → Bari Brahmana / Katra',
          baseFare: baseFare,
          comfortFare: baseFare + premium,
          premiumAmount: premium,
          premiumPercentage: 25,
          isPopular: true,
          features: const [
            'Ergonomic Recliner',
            'Phone Charging Socket',
            'Zero Standing Guarantee',
          ],
        ),
      ],
    );
  }

  Widget _buildTripConfigurator(route) {
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
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: AppTheme.secondary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Trip Configurator',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Next Departure: 6 mins',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'SELECTED CORRIDOR',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
              color: AppTheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.route,
                    size: 18,
                    color: AppTheme.secondary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        route.name,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${route.distanceKm} km • ${route.distanceCategory}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.swap_horiz),
                  color: AppTheme.secondary,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTravelClassSelector(int baseFare, int comfortFare) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SELECT TRAVEL CLASS',
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
            color: AppTheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: _buildClassOption(
                  'Standard',
                  baseFare,
                  '92% Crowd Cap',
                  'Standing likely',
                  !isComfortTier,
                  false,
                ),
              ),
              Expanded(
                child: _buildClassOption(
                  'Comfort',
                  comfortFare,
                  '40% Occupancy Cap',
                  'Guaranteed AC Seat',
                  isComfortTier,
                  true,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildClassOption(
    String label,
    int fare,
    String crowdInfo,
    String description,
    bool isSelected,
    bool isComfort,
  ) {
    return InkWell(
      onTap: () => setState(() => isComfortTier = isComfort),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.surfaceContainerLowest : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      label,
                      style: GoogleFonts.inter(
                        fontSize: isComfort ? 14 : 12,
                        fontWeight: isComfort ? FontWeight.w700 : FontWeight.w600,
                        color: isSelected ? AppTheme.onSurface : AppTheme.onSurfaceVariant,
                      ),
                    ),
                    if (isComfort) ...[
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.verified,
                        size: 16,
                        color: AppTheme.tertiaryContainer,
                      ),
                    ],
                  ],
                ),
                Text(
                  '₹$fare',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? AppTheme.onSurface : AppTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: isComfort ? AppTheme.secondary : AppTheme.error,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  crowdInfo,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                    color: isComfort ? AppTheme.secondary : AppTheme.error,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              description,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: AppTheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOccupancyTelemetry() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppTheme.secondaryContainer,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'FLEET DISPATCH TELEMETRY',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.8,
                      color: AppTheme.onSurface,
                    ),
                  ),
                ],
              ),
              Text(
                'Vehicle #JK-02-AZ-4188',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reserved Comfort Capacity:',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
              Text(
                '8 / 20 Seats Claimed (40% Cap Active)',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.secondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 0.4,
              minHeight: 12,
              backgroundColor: AppTheme.surfaceContainerHighest,
              valueColor: const AlwaysStoppedAnimation(AppTheme.primaryContainer),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '12 guaranteed seats remaining',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
              Text(
                'No standees permitted',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBookingButton(BuildContext context, int baseFare, int premium) {
    final totalFare = isComfortTier ? baseFare + premium : baseFare;

    return ElevatedButton(
      onPressed: () => _handleBooking(context, baseFare, premium),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primary,
        foregroundColor: AppTheme.onPrimary,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.airline_seat_recline_extra, size: 22),
          const SizedBox(width: 8),
          Text(
            'Book ${isComfortTier ? "Comfort" : "Standard"} Pass & Lock Seat (₹$totalFare)',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuaranteeCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.verified_user,
              color: AppTheme.secondary,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '100% Crowd Guarantee',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'If bus occupancy exceeds 50% or your seat is unavailable, your comfort premium is auto-refunded to UPI within 2 minutes.',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppTheme.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleBooking(BuildContext context, int baseFare, int premium) {
    final busProvider = Provider.of<BusProvider>(context, listen: false);
    final bookingProvider = Provider.of<BookingProvider>(context, listen: false);
    final route = busProvider.selectedRoute!;

    final booking = BookingModel(
      id: 'booking_${DateTime.now().millisecondsSinceEpoch}',
      busId: 'bus_2',
      busNumber: 'JK02-BT-8921',
      routeId: route.id,
      origin: route.origin,
      destination: route.destination,
      bookingTime: DateTime.now(),
      isComfortTier: isComfortTier,
      baseFare: baseFare,
      comfortPremium: isComfortTier ? premium : 0,
      seatPreference: selectedSeat,
      status: 'confirmed',
      passCode: '6429',
    );

    bookingProvider.createBooking(booking);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Booking confirmed! Pass code: ${booking.passCode}',
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppTheme.secondary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
