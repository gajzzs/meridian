import 'package:flutter/foundation.dart';
import '../models/booking_model.dart';

class BookingProvider with ChangeNotifier {
  List<BookingModel> _bookings = [];
  BookingModel? _currentBooking;

  List<BookingModel> get bookings => _bookings;
  BookingModel? get currentBooking => _currentBooking;

  void createBooking(BookingModel booking) {
    _bookings.add(booking);
    _currentBooking = booking;
    notifyListeners();
  }

  void updateBookingStatus(String bookingId, String status) {
    final index = _bookings.indexWhere((b) => b.id == bookingId);
    if (index != -1) {
      // In real app, we'd create a new instance
      notifyListeners();
    }
  }

  void clearCurrentBooking() {
    _currentBooking = null;
    notifyListeners();
  }
}
