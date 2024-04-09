import 'dart:async';
import 'package:enabled_app/app_styles.dart';
import 'package:enabled_app/widgets/searchBarCard.dart';
import 'package:enabled_app/providers/firebaseFunctions.dart';
import '../consts.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart' show rootBundle;

class MapPage extends StatefulWidget {
  final DocumentSnapshot enabledLocation;
  const MapPage({Key? key, required this.enabledLocation}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Location _locationController = Location();
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  LatLng? _currentPosition;
  late LatLng _destinationPosition;

  Map<PolylineId, Polyline> polylines = {};
  late StreamSubscription<LocationData> _locationSubscription;

  late BitmapDescriptor customIcon;

  @override
  void initState() {
    super.initState();
    _destinationPosition = LatLng(
      widget.enabledLocation['location'].latitude,
      widget.enabledLocation['location'].longitude,
    );
    getLocationUpdates();
    loadCustomIcon();
  }

  @override
  void dispose() {
    _locationSubscription.cancel();
    super.dispose();
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
              onMapCreated: ((GoogleMapController controller) =>
                  _mapController.complete(controller)),
              initialCameraPosition:
                  CameraPosition(target: _destinationPosition, zoom: 13),
              markers: {
                if (_currentPosition != null)
                  Marker(
                    markerId: MarkerId("_currentLocation"),
                    icon: customIcon != null
                        ? customIcon
                        : BitmapDescriptor.defaultMarker,
                    position: _currentPosition!,
                  ),
                Marker(
                  markerId: MarkerId("_destinationLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _destinationPosition,
                )
              },
              polylines: Set<Polyline>.of(polylines.values),
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
    );
  }

  Future<void> loadCustomIcon() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(48, 48)), // Adjust size as needed
      "assets/images/accessible_forward.png",
    );
    setState(() {}); // trigger a rebuild after loading the custom icon
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(target: pos, zoom: 17);

    await controller
        .animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition));
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
    }

    _locationSubscription = _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentPosition =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
        });
        _cameraToPosition(_currentPosition!);
        getPolylinePoints();
      }
    });
  }

  Future<void> getPolylinePoints() async {
    if (_currentPosition == null || _destinationPosition == null) return;

    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      GOOGLE_MAPS_API_KEY,
      PointLatLng(_currentPosition!.latitude, _currentPosition!.longitude),
      PointLatLng(
          _destinationPosition.latitude, _destinationPosition.longitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }

    generatePolyLineFromPoints(polylineCoordinates);
  }

  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: tBlue,
      points: polylineCoordinates,
      width: 8,
    );
    setState(() {
      polylines[id] = polyline;
    });
  }
}
