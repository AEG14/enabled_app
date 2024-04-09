import 'dart:async';
import 'package:enabled_app/User%20Screens/details_page.dart';
import 'package:enabled_app/app_styles.dart';
import 'package:enabled_app/widgets/searchBarCard.dart';
import 'package:enabled_app/providers/firebaseFunctions.dart';
import '../consts.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../push_animation.dart';
import 'package:flutter/services.dart' show rootBundle;

class MapHome extends StatefulWidget {
  const MapHome({Key? key}) : super(key: key);

  @override
  State<MapHome> createState() => _MapHomeState();
}

class _MapHomeState extends State<MapHome> {
  Location _locationController = Location();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  LatLng? _currentPosition;
  List<DocumentSnapshot> _enabledLocations = [];
  bool _initialCameraMoved = false;

  @override
  void initState() {
    super.initState();
    _getLocationUpdates();
    _getEnabledLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _currentPosition ?? LatLng(0, 0),
                zoom: 13,
              ),
              markers: _buildMarkers(),
              onTap: (_) {
                // Hide any visible information when the map is tapped
                // You can dismiss the dialog or bottom sheet here
              },
              cloudMapId: '98480eb43e9d4bc7',
            ),
          ),
          Positioned(
            top: 20.0,
            left: 20.0,
            right: 20.0,
            child: SearchBarWidget(
              onClear: () {},
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_currentPosition != null) {
            _cameraToPosition(_currentPosition!);
          }
        },
        child: Icon(Icons.my_location),
        backgroundColor: tPaleBlue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    _mapController.complete(controller);
    if (!_initialCameraMoved && _currentPosition != null) {
      await _cameraToPosition(_currentPosition!);
      _initialCameraMoved = true;
    }
  }

  void _getLocationUpdates() {
    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentPosition =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
        });
      }
    });
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(target: pos, zoom: 17);
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition));
  }

  void _getEnabledLocations() {
    _firestore.collection('ENABLED_locations').get().then((snapshot) {
      setState(() {
        _enabledLocations = snapshot.docs;
      });
    });
  }

  Set<Marker> _buildMarkers() {
    Set<Marker> markers = {};

    // Add markers for ENABLED_locations
    _enabledLocations.forEach((doc) {
      String accessibilityText = '';
      GeoPoint location = doc['location'];
      double latitude = location.latitude;
      double longitude = location.longitude;
      markers.add(
        Marker(
          markerId: MarkerId(doc.id),
          position: LatLng(latitude, longitude),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow: InfoWindow(
            title: doc['name'],
            snippet: 'View Accessibilities',
            onTap: () {
              Navigator.push(
                context,
                PageRouteUtils.createSlidePageRoute(
                    EnabledLocationDetails(enabledLocation: doc)),
              );
            },
          ),
        ),
      );
    });

    // Add marker for current location
    if (_currentPosition != null) {
      BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48, 48)),
        "assets/images/accessible.png",
      ).then((descriptor) {
        markers.add(
          Marker(
            markerId: MarkerId('currentLocation'),
            position: _currentPosition!,
            icon: descriptor,
          ),
        );
      });
    }

    return markers;
  }
}
