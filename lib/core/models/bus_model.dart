class BusModel {
  final String id;
  final String number;
  final String type; // 'standard' or 'comfort'
  final String line;
  final int currentOccupancy;
  final int maxCapacity;
  final double latitude;
  final double longitude;
  final int etaMinutes;
  final String status; // 'approaching', 'stopped', 'moving'
  final bool hasAC;
  final bool hasGPS;
  final int baseFare;
  final int comfortPremium;
  final double averageSpeed;
  final String currentStop;

  BusModel({
    required this.id,
    required this.number,
    required this.type,
    required this.line,
    required this.currentOccupancy,
    required this.maxCapacity,
    required this.latitude,
    required this.longitude,
    required this.etaMinutes,
    required this.status,
    this.hasAC = false,
    this.hasGPS = true,
    required this.baseFare,
    this.comfortPremium = 0,
    this.averageSpeed = 0.0,
    this.currentStop = '',
  });

  double get occupancyPercentage => (currentOccupancy / maxCapacity) * 100;

  bool get isCrowded => occupancyPercentage >= 70;

  int get totalFare => baseFare + comfortPremium;

  String get occupancyStatus {
    if (occupancyPercentage >= 90) return 'Crowded';
    if (occupancyPercentage >= 60) return 'Moderate';
    return 'Comfortable';
  }
}
