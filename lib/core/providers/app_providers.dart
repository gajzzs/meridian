import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'bus_provider.dart';
import 'booking_provider.dart';

class AppProviders {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => BusProvider()),
    ChangeNotifierProvider(create: (_) => BookingProvider()),
  ];
}
