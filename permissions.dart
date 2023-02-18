// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Permissions extends StatefulWidget {
  String Id;
  bool isitcomp;
  bool loding = false;
  String? _currentAddress;
  Position? _currentPosition;
  Permissions({required this.Id, required this.isitcomp});

  @override
  State<Permissions> createState() => _PermissionsState();
}

class _PermissionsState extends State<Permissions> {
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
          'التصاريح',
          style: GoogleFonts.cairo(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: widget.loding
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(child: Center(child: permissionget(context))),
    );
  }

  Widget permissionget(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('permissions')
            .doc(widget.Id)
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
            DateTime myDateTime = (snapshot.data!['time']).toDate();
            double distance = Geolocator.distanceBetween(
                widget._currentPosition!.latitude,
                widget._currentPosition!.longitude,
                21.421599935602476,
                39.87321490882251);
            if (distance > 500 ||
                myDateTime.isAfter(DateTime.now()) &&
                    myDateTime.isAfter(DateTime.now())) {
              FirebaseFirestore.instance
                  .collection('hajjaj')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .get()
                  .then((value) {
                FirebaseFirestore.instance.collection('violations').add({
                  'action': 'مراجعة',
                  'campingnumber': value['campaignnumber'],
                  'id': value['id'],
                  'name': value['name'],
                  'type': 'الدخول بدون تصريح',
                  'time': Timestamp.now()
                });
              });
            }
            return Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'تصريح لرمي الجمرات',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    DateFormat.yMMMd().add_jm().format(myDateTime),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        DateFormat.jm()
                            .format(myDateTime.add(Duration(hours: 2))),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text(
                        'وقت الخروج',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text(
                        DateFormat.jm().format(myDateTime),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text(
                        'وقت الدخول',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  QrImage(
                    data: DateFormat.yMMMd().add_jm().format(myDateTime),
                    version: QrVersions.auto,
                    size: 320,
                    foregroundColor: myDateTime.add(Duration(hours: 2)).hour >
                                (DateTime.now().hour) &&
                            myDateTime.hour <= (DateTime.now().hour) &&
                            myDateTime.day <= (DateTime.now().day)
                        ? Colors.green
                        : Colors.red,
                    gapless: false,
                    embeddedImage: AssetImage('assets/images/52.png'),
                    embeddedImageStyle: QrEmbeddedImageStyle(
                      size: Size(100, 100),
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}
