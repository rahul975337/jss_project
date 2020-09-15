import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  BitmapDescriptor myIcon;
  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(48, 48)), 'lib/assets/JSS_Logo.png')
        .then((onValue) {
      myIcon = onValue;
    });
  }

  // static final CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );
  static const LatLng _collegeLoc = const LatLng(12.901249, 77.504066);
  static final CameraPosition collegeLoc = CameraPosition(
      bearing: 192.8334901395799,
      target: _collegeLoc,
      tilt: 59.440717697143555,
      zoom: 19);
  final Set<Marker> _markers = {
    // Marker(
    //   markerId: MarkerId('Bairagarh'),
    //   position: _collegeLoc,
    //   infoWindow: InfoWindow(title: 'Gourav'),
    //   icon: BitmapDescriptor.fromAsset("lib/assets/JSS_Logo.png"),
    // ),
    Marker(
        markerId: MarkerId(_collegeLoc.toString()),
        position: _collegeLoc,
        icon: BitmapDescriptor.defaultMarker)
  };
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        markers: _markers,
        mapToolbarEnabled: true,
        zoomControlsEnabled: false,
        myLocationEnabled: true,
        compassEnabled: false,
        indoorViewEnabled: true,
        // padding: EdgeInsets.all(100),
        myLocationButtonEnabled: true,
        rotateGesturesEnabled: true,
        zoomGesturesEnabled: true,
        buildingsEnabled: true,
        mapType: MapType.satellite,
        initialCameraPosition: collegeLoc,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: Text('To the lake!'),
      //   icon: Icon(Icons.directions_boat),
      // ),
    );
  }

  // Future<void> goTOCollege() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(collegeLoc));
  // }
}
