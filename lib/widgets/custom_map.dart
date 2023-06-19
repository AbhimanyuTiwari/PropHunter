import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/properties.dart';

dynamic func(int i) {}

class CustomMap extends StatelessWidget {
  CustomMap({this.press = func, Key? key, required this.propertyList}) : super(key: key);
  final void Function(int) press;
  List<Properties> propertyList;
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> markers = {}; //markers for google map
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(25.1048, 55.2608),
    zoom: 10.8746,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Set<Marker>>(
        future: getMarkers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GoogleMap(
              initialCameraPosition: CustomMap._kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: markers,
            );
          }
          return const CircularProgressIndicator();
        });
  }

  Future<Set<Marker>> getMarkers() async {
    BitmapDescriptor myIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(68, 68)), 'assets/icons/map_icon.png');

    for (int i = 0; i < propertyList.length; i++) {
      markers.add(
        Marker(
            //add first marker
            markerId: MarkerId(propertyList[i].id.toString()),
            position: LatLng(propertyList[i].lat, propertyList[i].lan),
            //position of marker
            infoWindow: InfoWindow(
              //popup info
              title: propertyList[i].name,
            ),
            onTap: () {
              press(i);
            },
            icon: myIcon), //Icon for Marker
      );
    }

    return markers;
  }
}
