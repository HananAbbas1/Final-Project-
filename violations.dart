import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Violations extends StatefulWidget {
  String Id;
  Violations({required this.Id});
  Uri _url = Uri.parse('');

  @override
  State<Violations> createState() => _ViolationsState();
}

class _ViolationsState extends State<Violations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('المخالفات'),
        backgroundColor: kPrimaryColor,
      ),
      body: violationsall(context),
    );
  }

  Widget violationsall(context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('violations')
          .where('id', isEqualTo: widget.Id)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor));
        } else {
          return Padding(
            padding: const EdgeInsets.only(left: 5, right: 5, top: 20),
            child: ListView.builder(
              padding: EdgeInsets.only(bottom: 10),
              shrinkWrap: true,
              //physics: NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              //controller: listScrollController,
              itemBuilder: (context, index) =>
                  postDetails(snapshot.data!.docs[index]),
            ),
          );
        }
      },
    );
  }

  Widget postDetails(DocumentSnapshot document) {
    DateTime myDateTime = (document['time']).toDate();
    return Column(children: <Widget>[
      Divider(
        color: kPrimaryColor,
        height: 1,
        indent: 50,
        endIndent: 50,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                document['id'],
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                ':رقم الهوية',
                style: GoogleFonts.cairo(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                document['name'],
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                ':اسم الحاج',
                style: GoogleFonts.cairo(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            DateFormat.yMMMd().add_jm().format(myDateTime),
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 15,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            ':تاريخها',
            style: GoogleFonts.cairo(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
      SizedBox(
        width: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            document['type'],
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 15,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            ':نوع المخالفة',
            style: GoogleFonts.cairo(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
      Divider(
        color: kPrimaryColor,
        height: 1,
        indent: 50,
        endIndent: 50,
      )
    ]);
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(widget._url)) {
      throw 'Could not launch $widget._url';
    }
  }
}
