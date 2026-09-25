import 'package:flutter/foundation.dart';
import '../models/bus_model.dart';
import '../models/route_model.dart';

class BusProvider with ChangeNotifier {
  List<BusModel> _buses = [];
  RouteModel? _selectedRoute;

  List<BusModel> get buses => _buses;
  RouteModel? get selectedRoute => _selectedRoute;

  BusProvider() {
    _loadMockData();
  }

  void _loadMockData() {
    _selectedRoute = RouteModel(
      id: 'route_102',
      name: 'Jammu Bus Stand ⇄ Bari Brahmana',
      lineNumber: '102',
      distanceKm: 16.2,
      estimatedDurationMinutes: 35,
      origin: 'Jammu Bus Stand',
      destination: 'Bari Brahmana',
      stops: [
        RouteStop(
          name: 'Jewel Chowk Terminal',
          latitude: 32.7266,
          longitude: 74.8570,
          sequenceNumber: 1,
          description: 'Corridor Departure Gate 02',
          isPassed: true,
        ),
        RouteStop(
          name: 'Bikram Chowk Bridge',
          latitude: 32.7280,
          longitude: 74.8590,
          sequenceNumber: 2,
          description: 'Heavy boardings • Expect delay',
          isCurrent: true,
        ),
        RouteStop(
          name: 'Satwari Cantt Roundabout',
          latitude: 32.7300,
          longitude: 74.8620,
          sequenceNumber: 3,
          description: 'Smooth traffic flow',
        ),
        RouteStop(
          name: 'Kunjwani Flyover Bypass',
          latitude: 32.7320,
          longitude: 74.8650,
          sequenceNumber: 4,
          description: 'Express corridor merge',
        ),
        RouteStop(
          name: 'Bari Brahmana Industrial Complex',
          latitude: 32.7350,
          longitude: 74.8700,
          sequenceNumber: 5,
          description: 'Zone 4 Transit Hub',
        ),
      ],
    );

    _buses = [
      BusModel(
        id: 'bus_1',
        number: 'JK02-BB-4102',
        type: 'standard',
        line: '102',
        currentOccupancy: 44,
        maxCapacity: 50,
        latitude: 32.7280,
        longitude: 74.8590,
        etaMinutes: 3,
        status: 'approaching',
        hasAC: false,
        hasGPS: true,
        baseFare: 60,
        averageSpeed: 24,
        currentStop: 'Bikram Chowk',
      ),
      BusModel(
        id: 'bus_2',
        number: 'JK02-BT-8921',
        type: 'comfort',
        line: '102',
        currentOccupancy: 17,
        maxCapacity: 50,
        latitude: 32.7300,
        longitude: 74.8620,
        etaMinutes: 7,
        status: 'moving',
        hasAC: true,
        hasGPS: true,
        baseFare: 60,
        comfortPremium: 15,
        averageSpeed: 28,
        currentStop: 'Approaching Satwari',
      ),
    ];

    notifyListeners();
  }

  void refreshBuses() {
    // Simulate bus position update
    notifyListeners();
  }

  void setSelectedRoute(RouteModel route) {
    _selectedRoute = route;
    notifyListeners();
  }
}
