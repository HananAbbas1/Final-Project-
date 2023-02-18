import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';

class ListOfHajaj extends StatefulWidget {
  String campaignnumber;
  ListOfHajaj({required this.campaignnumber});
  Uri _url = Uri.parse('');

  @override
  State<ListOfHajaj> createState() => _ListOfHajajState();
}

class _ListOfHajajState extends State<ListOfHajaj> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'الحجاج',
          style: GoogleFonts.cairo(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: HajajList(context),
    );
  }

  Widget HajajList(context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('hajjaj')
          .where('campaignnumber', isEqualTo: widget.campaignnumber)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor)));
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
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      widget._url = Uri.parse(document['tel']);
                      _launchUrl();
                    });
                  },
                  icon: Icon(Icons.call)),
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
          Divider(
            color: kPrimaryColor,
            height: 1,
            indent: 50,
            endIndent: 50,
          ),
        ]);
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(widget._url)) {
      throw 'Could not launch $widget._url';
    }
  }
}
