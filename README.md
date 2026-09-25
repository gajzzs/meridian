# AsteriskPath - Jammu Smart Transit App

A Flutter application for Jammu Smart City hackathon solving traveler comfort and bus operator revenue challenges through comfort-based pricing.

## Problem Statement

Travelers face crowded and uncomfortable bus journeys, while bus owners fear revenue loss from reduced occupancy. Our solution provides:

- **For Passengers**: Comfortable, less-crowded journeys with GPS tracking, estimated arrival times, and guaranteed seating
- **For Bus Operators**: Additional revenue stream through comfort pricing without losing passengers

## Key Features

### 1. Comfort Tier Pricing
- **Short Distance** (<5 km): Base fare + 80% premium
- **Medium Range** (5-15 km): Base fare + 40% premium
- **Long Distance** (>15 km): Base fare + 25% premium

### 2. Live Corridor Telemetry
- Real-time GPS tracking of buses
- Live occupancy levels and crowd information
- Estimated arrival times with ±1-2min accuracy
- Smart capacity balancing suggestions

### 3. Transparent Fare System
- 75% of comfort premium goes directly to bus operators
- 25% platform fee for system maintenance
- Complete fare breakdown showing operator benefits
- RTO-verified pricing compliance

### 4. Digital Comfort Pass
- QR code for quick boarding
- Audio verification PIN for conductors
- Seat preference selection (Window/Aisle/Quiet Zone)
- 100% money-back guarantee if occupancy exceeds 50%

## Running the App

\`\`\`bash
cd /Users/adarshraj/Desktop/smarthackathon
flutter pub get
flutter run
\`\`\`

## Tech Stack

- **Framework**: Flutter 3.10+
- **State Management**: Provider
- **UI Components**: Material Design 3
- **Fonts**: Google Fonts (Inter, Space Grotesk)
- **Location**: Geolocator
