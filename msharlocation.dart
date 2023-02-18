// ignore_for_file: prefer_const_constructors, unused_element

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'constants.dart';
import 'package:permission_handler/permission_handler.dart';

class MasharLocation extends StatefulWidget {
  String title = '';
  double Lat = 0.0;
  double Lng = 0.0;

  MasharLocation({required this.title, required this.Lat, required this.Lng});

  @override
  State<MasharLocation> createState() => _MasharLocationState();
}

class _MasharLocationState extends State<MasharLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text(
          widget.title,
          style: GoogleFonts.cairo(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: GoogleMap(
        markers: {
          Marker(
            markerId: const MarkerId("marker1"),
            position: LatLng(widget.Lat, widget.Lng),
            draggable: true,
            onDragEnd: (value) {
              // value is the new position
            },
            // To do: custom marker icon
          ),
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        circles: <Circle>{
          Circle(
              radius: 100,
              circleId: CircleId('1'),
              center: LatLng(widget.Lat, widget.Lng))
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.Lat, widget.Lng),
          zoom: 18,
        ),
      ),
    );
  }
}
