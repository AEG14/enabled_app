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

  bool _showAccessible = true;
  bool _showPartiallyAccessible = true;
  bool _showNotAccessible = true;

  bool _tempShowAccessible = true;
  bool _tempShowPartiallyAccessible = true;
  bool _tempShowNotAccessible = true;

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
              mapType: MapType.normal,
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
          Positioned(
            top: 80.0,
            left: 20.0,
            child: ElevatedButton(
              onPressed: () {
                _showFilterDialog();
              },
              child: Text('Filter'),
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
      int accessibilityCount = doc['accessibility'].length;
      GeoPoint location = doc['location'];
      double latitude = location.latitude;
      double longitude = location.longitude;

      if (_showAccessible && accessibilityCount >= 3 ||
          _showPartiallyAccessible &&
              accessibilityCount >= 1 &&
              accessibilityCount <= 2 ||
          _showNotAccessible && accessibilityCount == 0) {
        BitmapDescriptor markerIcon;
        if (accessibilityCount == 0) {
          markerIcon =
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
        } else if (accessibilityCount <= 2) {
          markerIcon =
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
        } else {
          markerIcon =
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
        }

        markers.add(
          Marker(
            markerId: MarkerId(doc.id),
            position: LatLng(latitude, longitude),
            icon: markerIcon,
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
      }
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

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Filter'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CheckboxListTile(
                    title: Text('Accessible (3>)'),
                    value: _tempShowAccessible,
                    onChanged: (bool? value) {
                      setState(() {
                        _tempShowAccessible = value ?? false;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('Partially Accessible (1-2)'),
                    value: _tempShowPartiallyAccessible,
                    onChanged: (bool? value) {
                      setState(() {
                        _tempShowPartiallyAccessible = value ?? false;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('Not Accessible (0)'),
                    value: _tempShowNotAccessible,
                    onChanged: (bool? value) {
                      setState(() {
                        _tempShowNotAccessible = value ?? false;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showAccessible = _tempShowAccessible;
                      _showPartiallyAccessible = _tempShowPartiallyAccessible;
                      _showNotAccessible = _tempShowNotAccessible;
                    });
                    _getEnabledLocations(); // Apply changes to map
                    Navigator.of(context).pop(); // Close dialog
                  },
                  child: Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
