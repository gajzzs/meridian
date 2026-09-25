class RouteModel {
  final String id;
  final String name;
  final String lineNumber;
  final List<RouteStop> stops;
  final double distanceKm;
  final int estimatedDurationMinutes;
  final String origin;
  final String destination;

  RouteModel({
    required this.id,
    required this.name,
    required this.lineNumber,
    required this.stops,
    required this.distanceKm,
    required this.estimatedDurationMinutes,
    required this.origin,
    required this.destination,
  });

  String get distanceCategory {
    if (distanceKm < 5) return 'Short Distance';
    if (distanceKm <= 15) return 'Medium Range';
    return 'Long Distance';
  }

  int get baseFarePerKm {
    if (distanceKm < 5) return 2;
    if (distanceKm <= 15) return 2; // Actually 1.5 but rounded
    return 1;
  }

  int get comfortPremiumPercentage {
    if (distanceKm < 5) return 80; // 80% more for short
    if (distanceKm <= 15) return 40; // 40% for medium
    return 25; // 25% for long
  }

  int calculateFare(bool isComfort) {
    final baseFare = (distanceKm * baseFarePerKm).round();
    if (!isComfort) return baseFare;

    final premium = (baseFare * (comfortPremiumPercentage / 100)).round();
    return baseFare + premium;
  }
}

class RouteStop {
  final String name;
  final double latitude;
  final double longitude;
  final int sequenceNumber;
  final String? description;
  final bool isPassed;
  final bool isCurrent;

  RouteStop({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.sequenceNumber,
    this.description,
    this.isPassed = false,
    this.isCurrent = false,
  });
}
