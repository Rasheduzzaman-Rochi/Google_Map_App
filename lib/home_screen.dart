import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  late final GoogleMapController _mapController;

  final Set<Marker> _markers = <Marker>{
    Marker(
      markerId: MarkerId("my-home"),
      position: LatLng(23.82242062483616, 90.42276089152202),
      infoWindow: InfoWindow(
        title: "My Home",
        onTap: () {},
      ),
      onTap: () {},
      // do whatever you want
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
    ),
    Marker(
      markerId: MarkerId("my-home"),
      position: LatLng(20.82242062483616, 90.42276089152202),
      infoWindow: InfoWindow(
        title: "My office",
        onTap: () {},
      ),
      onTap: () {},
      // do whatever you want
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
    ),
    Marker(
      markerId: MarkerId("pick-up-location"),
      position: LatLng(21.82242062483616, 90.42276089152202),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      draggable: true,
      onDragStart: (LatLng startLatLng) {
        print("Start latLng $startLatLng");
      },
      onDragEnd: (LatLng startLatLng) {
        print("Stop latLng $startLatLng");
      },
    ),
  };

  final Set<Polyline> _polylines = <Polyline>{
    Polyline(
      polylineId: PolylineId('home-to-office'),
      points: [
        LatLng(20.82242062483616, 90.42276089152202),
        LatLng(21.82242062483616, 90.42276089152202),
      ],
      color: Colors.pink,
      endCap: Cap.roundCap,
      width: 4,
      jointType: JointType.round,
      startCap: Cap.roundCap,
    ) //one location to another location line create
  };

  final Set<Circle> _circles = <Circle>{
    Circle(
        circleId: CircleId("most-affected"),
        center: LatLng(23.82242062483616, 90.42276089152202),
        radius: 300,
        fillColor: Colors.red.withOpacity(0.3),
        strokeWidth: 3,
        strokeColor: Colors.red)
  };

  final Set<Polygon> _polygons = <Polygon>{
    Polygon(
      polygonId: PolygonId("random-polygon"),
      points: [
        LatLng(22.82242062483616, 90.42276089152202),
        LatLng(23.82242062483616, 90.42276089152202),
        LatLng(24.82242062483616, 90.42276089152202),
        LatLng(22.82242062483616, 90.52276089152202),
      ],
      fillColor: Colors.orange.withOpacity(0.4),
      strokeColor: Colors.orange,
      strokeWidth: 4,
      onTap: () {
        print("Polygon tapped");
      },
    )
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Maps"),
      ),
      body: GoogleMap(
        mapType: MapType.terrain,
        initialCameraPosition: CameraPosition(
          target: LatLng(23.82242062483616, 90.42276089152202),
          zoom: 10.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
        onTap: (LatLng latLng) {
          print("Tapped on $latLng");
        },
        onLongPress: (LatLng latLng) {
          print("Long pressed on $latLng");
        },
        trafficEnabled: true,
        zoomControlsEnabled: true,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        compassEnabled: true,
        markers: _markers,
        polylines: _polylines,
        circles: _circles,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
              onPressed: _addNewMarker,
              child: Icon(Icons.location_on_outlined)),
          SizedBox(width: 16),
          FloatingActionButton(
              onPressed: _addNewMarker, child: Icon(Icons.my_location)),
        ],
      ),
    );
  }

  void _addNewMarker() {
    _markers.add(Marker(
        markerId: MarkerId("New-marker"), position: LatLng(23.77, 90.4158)));
    setState(() {});
  }

  void _goBackToMyLocation() {
    _mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(23.82242062483616, 90.42276089152202),
        zoom: 15.0,
      ),
    ));
  }
}