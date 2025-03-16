import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

// 1. App needs permission to use GPS
// 2. GPS service status on
// 3. Fetch GPS current location/listen current location

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _listenCurrentLocation();
  }

  Future<void> _listenCurrentLocation() async {
    if (await _checkPermissionStatus()) {
      if (await _isGpsServiceEnabled()) {
        Geolocator.getPositionStream(
            locationSettings: LocationSettings(
          accuracy: LocationAccuracy.best,
          distanceFilter: 2,
          // timeLimit: Duration(seconds: 1),
        )).listen((pos) {
          print(pos);
        });
      } else {
        _requestGpsService();
      }
    } else {
      _requestPermission();
    }
  }

  Future<bool> _checkPermissionStatus() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    }
    return false;
  }

  Future<bool> _requestPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    }
    return false;
  }

  Future<bool> _isGpsServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<void> _requestGpsService() async {
    await Geolocator.openLocationSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Permission status: "),
            Text("GPS status: "),
            Text("Current location: "),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _listenCurrentLocation,
        child: const Icon(Icons.add_location_outlined),
      ),
    );
  }
}
