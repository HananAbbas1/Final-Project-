// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, unused_field, non_constant_identifier_names, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'constants.dart';

class Locationofhajj extends StatefulWidget {
  String Id;
  String Cid;
  String name;

  bool loding = false;
  String? _currentAddress;
  Position? _currentPosition;

  // ignore: non_constant_identifier_names
  Locationofhajj({
    Key? key,
    required this.Id,
    required this.Cid,
    required this.name,
  }) : super(key: key);

  @override
  State<Locationofhajj> createState() => _LocationofhajjState();
}

class _LocationofhajjState extends State<Locationofhajj> {
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    setState(() {
      widget.loding = true;
    });
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => widget._currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
    setState(() {
      widget.loding = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: Text(
            'الموقع',
            style: GoogleFonts.cairo(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: widget.loding
            ? Center(
                child: CircularProgressIndicator(),
              )
            : HajajLocation(context));
  }

  Widget HajajLocation(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('location')
            .doc(widget.Cid)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return SafeArea(
              child: Center(
                  child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(kPrimaryColor))),
            );
          } else {
            double distance = Geolocator.distanceBetween(
                widget._currentPosition!.latitude,
                widget._currentPosition!.longitude,
                snapshot.data!['Location'].latitude,
                snapshot.data!['Location'].longitude);
            if (distance > 50) {
              FirebaseFirestore.instance.collection('violations').add({
                'action': 'مراجعة',
                'campingnumber': widget.Cid,
                'id': widget.Id,
                'name': widget.name,
                'type': 'تخلف عن التجمع',
                'time': Timestamp.now()
              });
            }
            return Stack(
              children: [
                GoogleMap(
                  markers: {
                    Marker(
                      markerId: MarkerId("marker1"),
                      position: LatLng(widget._currentPosition!.latitude,
                          widget._currentPosition!.longitude),
                      draggable: true,
                      onDragEnd: (value) {
                        // value is the new position
                      },
                      // To do: custom marker icon
                    ),
                  },
                  circles: {
                    Circle(
                      circleId: CircleId('currentCircle'),
                      center: LatLng(snapshot.data!['Location'].latitude,
                          snapshot.data!['Location'].longitude),
                      radius: 50,
                      fillColor: Colors.blue.shade100.withOpacity(0.5),
                      strokeColor: Colors.blue.shade100.withOpacity(0.1),
                    ),
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(snapshot.data!['Location'].latitude,
                        snapshot.data!['Location'].longitude),
                    zoom: 18,
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                    ),
                    height: media.size.height * .15,
                    width: media.size.width,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ":يتوجب عليك التواجد في الموقع التالي",
                              style: GoogleFonts.cairo(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              snapshot.data!['name'],
                              style: GoogleFonts.cairo(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              " في حال خروجك عن الدائرة ",
                              style: GoogleFonts.cairo(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "المخصص للحملة سيتم تحرير مخالفة",
                              style: GoogleFonts.cairo(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    )),
              ],
            );
          }
        });
  }
}
