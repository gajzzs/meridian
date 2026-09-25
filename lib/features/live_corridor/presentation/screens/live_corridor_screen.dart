import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/providers/bus_provider.dart';
import '../widgets/bus_card.dart';
import '../widgets/route_timeline.dart';

class LiveCorridorScreen extends StatefulWidget {
  const LiveCorridorScreen({super.key});

  @override
  State<LiveCorridorScreen> createState() => _LiveCorridorScreenState();
}

class _LiveCorridorScreenState extends State<LiveCorridorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildAppBar(),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildSearchBar(),
                  const SizedBox(height: 12),
                  _buildQuickHotspots(),
                  const SizedBox(height: 16),
                  _buildCorridorHeader(context),
                  const SizedBox(height: 16),
                  _buildSmartCapacityBanner(),
                  const SizedBox(height: 16),
                  _buildBusesSection(context),
                  const SizedBox(height: 16),
                  _buildRouteTimeline(),
                  const SizedBox(height: 32),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
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
                      'Jammu Central • Live GPS Grid',
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
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Text(
                  'Rider',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    color: AppTheme.onSurface,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
                child: Text(
                  'Partner',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
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

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
      child: Row(
        children: [
          const Icon(Icons.search, color: AppTheme.secondary, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Where in Jammu are you traveling today?',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppTheme.outline,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.mic,
              color: AppTheme.secondary,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickHotspots() {
    final hotspots = [
      {'icon': Icons.local_hospital, 'label': 'GMC Jammu'},
      {'icon': Icons.train, 'label': 'Railway Stn'},
      {'icon': Icons.shopping_bag, 'label': 'Wave Mall'},
      {'icon': Icons.temple_hindu, 'label': 'Panjtirthi'},
    ];

    return Row(
      children: [
        Text(
          'HOTSPOTS:',
          style: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: AppTheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: hotspots.map((spot) {
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        spot['icon'] as IconData,
                        size: 14,
                        color: AppTheme.onSurface,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        spot['label'] as String,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppTheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCorridorHeader(BuildContext context) {
    final busProvider = Provider.of<BusProvider>(context);
    final route = busProvider.selectedRoute;

    if (route == null) return const SizedBox();

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
              Column(
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
                          color: AppTheme.primaryContainer,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'LINE ${route.lineNumber}',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                            color: AppTheme.surfaceVariant,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Color(0xFF10B981),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Real-Time Radar',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: Color(0xFF059669),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.onSurface,
                        height: 1.3,
                      ),
                      children: [
                        TextSpan(text: route.origin),
                        TextSpan(
                          text: ' ⇄ ',
                          style: const TextStyle(color: AppTheme.secondary),
                        ),
                        TextSpan(text: route.destination),
                      ],
                    ),
                  ),
                  Text(
                    'via Satwari Chowk & Gandhi Nagar Green Belt',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.swap_horiz),
                onPressed: () {},
                color: AppTheme.secondary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmartCapacityBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.tertiaryContainer,
            const Color(0xFF382200),
            AppTheme.tertiaryContainer,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppTheme.tertiaryFixedDim.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.airline_seat_recline_extra,
              color: AppTheme.tertiaryFixedDim,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SMART CAPACITY BALANCING',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                        color: AppTheme.tertiaryFixedDim,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.tertiaryFixedDim.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'SKIP THE RUSH',
                        style: GoogleFonts.inter(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.95),
                      height: 1.3,
                    ),
                    children: const [
                      TextSpan(text: 'Bus behind is '),
                      TextSpan(
                        text: '65% less crowded',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppTheme.tertiaryFixedDim,
                        ),
                      ),
                      TextSpan(
                        text: ' and arrives in 7 mins. Switch to Comfort Tier for guaranteed chilled window seating!',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBusesSection(BuildContext context) {
    final busProvider = Provider.of<BusProvider>(context);
    final buses = busProvider.buses;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ARRIVING VEHICLES ON LINE 102',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
              Text(
                'Auto-syncs in 12s',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  color: AppTheme.secondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ...buses.map((bus) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: BusCard(bus: bus),
            )),
      ],
    );
  }

  Widget _buildRouteTimeline() {
    final busProvider = Provider.of<BusProvider>(context);
    final route = busProvider.selectedRoute;

    if (route == null || route.stops.isEmpty) return const SizedBox();

    return RouteTimeline(stops: route.stops);
  }
}
