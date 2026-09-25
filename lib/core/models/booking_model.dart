class BookingModel {
  final String id;
  final String busId;
  final String busNumber;
  final String routeId;
  final String origin;
  final String destination;
  final DateTime bookingTime;
  final bool isComfortTier;
  final int baseFare;
  final int comfortPremium;
  final String seatPreference; // 'window', 'aisle', 'quiet'
  final String status; // 'confirmed', 'active', 'completed', 'cancelled'
  final String passCode;

  BookingModel({
    required this.id,
    required this.busId,
    required this.busNumber,
    required this.routeId,
    required this.origin,
    required this.destination,
    required this.bookingTime,
    this.isComfortTier = false,
    required this.baseFare,
    this.comfortPremium = 0,
    this.seatPreference = 'window',
    this.status = 'confirmed',
    required this.passCode,
  });

  int get totalFare => baseFare + comfortPremium;

  String get formattedPassCode {
    if (passCode.length == 4) {
      return passCode.split('').join(' ');
    }
    return passCode;
  }
}
