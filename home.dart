import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Location.dart';
import 'package:flutter_auth/almshar.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/permissions.dart';
import 'package:flutter_auth/violations.dart';
import 'package:flutter_auth/violationsall.dart';
import 'package:google_fonts/google_fonts.dart';

import 'hajjInfo.dart';
import 'landingScreen.dart';
import 'listofHajaj.dart';

class HomePage extends StatefulWidget {
  bool isItCamping = false;
  HomePage({Key? key, required this.isItCamping}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            FirebaseAuth.instance.signOut().then(
              (value) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => LandingScreen()));
              },
            );
          },
        ),
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text(
          'نسكي',
          style: GoogleFonts.cairo(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: widget.isItCamping
          ? SingleChildScrollView(child: campaigns(context))
          : SingleChildScrollView(child: HajajInfo(context)),
    );
  }

  Widget campaigns(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('campaigns')
            .doc(FirebaseAuth.instance.currentUser?.uid)
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
            var assetsImage = new AssetImage(
                'assets/images/52.png'); //<- Creates an object that fetches an image.
            var image = new Image(image: assetsImage, height: 300); //<- C
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  image,
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        snapshot.data!['name'],
                        style: GoogleFonts.cairo(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'حملة ',
                        style: GoogleFonts.cairo(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * .05,
                    width: MediaQuery.of(context).size.width * .70,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        backgroundColor:
                            kPrimaryColor, // background (button) color
                        foregroundColor:
                            Colors.white, // foreground (text) color
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListOfHajaj(
                                    campaignnumber: snapshot.data!['id'],
                                  )),
                        );
                        print('pressed');
                      },
                      child: Text(
                        'الحجاج',
                        style: GoogleFonts.cairo(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * .05,
                    width: MediaQuery.of(context).size.width * .70,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        backgroundColor:
                            kPrimaryColor, // background (button) color
                        foregroundColor:
                            Colors.white, // foreground (text) color
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Permissions(
                                    isitcomp: widget.isItCamping,
                                    Id: snapshot.data!['id'],
                                  )),
                        );
                        print('pressed');
                      },
                      child: Text(
                        'التصاريح',
                        style: GoogleFonts.cairo(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * .05,
                    width: MediaQuery.of(context).size.width * .70,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        backgroundColor:
                            kPrimaryColor, // background (button) color
                        foregroundColor:
                            Colors.white, // foreground (text) color
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Violationsall(
                                    Id: snapshot.data!['id'],
                                  )),
                        );
                        print('pressed');
                      },
                      child: Text(
                        'المخالفات',
                        style: GoogleFonts.cairo(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        });
  }
}

Widget HajajInfo(BuildContext context) {
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('hajjaj')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return SafeArea(
            child: Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor))),
          );
        } else {
          var assetsImage = new AssetImage(
              'assets/images/52.png'); //<- Creates an object that fetches an image.
          var image = new Image(image: assetsImage, height: 300); //
          return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                image,
                SizedBox(
                  height: MediaQuery.of(context).size.height * .05,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ALmshair()),
                    );
                    print('pressed');
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * .05,
                    width: MediaQuery.of(context).size.width * .70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                        color: kPrimaryColor,
                        width: 1, //                   <--- border width here
                      ),
                    ),
                    child: Text(
                      'المشاعر',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cairo(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * .05,
                  width: MediaQuery.of(context).size.width * .70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(
                      color: kPrimaryColor,
                      width: 1, //                   <--- border width here
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Locationofhajj(
                                  name: snapshot.data!['name'],
                                  Id: snapshot.data!['id'],
                                  Cid: snapshot.data!['campaignnumber'],
                                )),
                      );
                      print('pressed');
                    },
                    child: Center(
                      child: Text(
                        'موقع تجمع الحملة',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cairo(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HajjInfo()),
                    );
                    print('pressed');
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * .05,
                    width: MediaQuery.of(context).size.width * .70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                        color: kPrimaryColor,
                        width: 1, //                   <--- border width here
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'العضوية',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cairo(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Permissions(
                                isitcomp: false,
                                Id: snapshot.data!['campaignnumber'],
                              )),
                    );
                    print('pressed');
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * .05,
                    width: MediaQuery.of(context).size.width * .70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                        color: kPrimaryColor,
                        width: 1, //                   <--- border width here
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'التصاريح',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cairo(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Violations(
                                Id: snapshot.data!['id'],
                              )),
                    );
                    print('pressed');
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * .05,
                    width: MediaQuery.of(context).size.width * .70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                        color: kPrimaryColor,
                        width: 1, //                   <--- border width here
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'المخالفات',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cairo(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                      ),
                    ),
                  ),
                ),
              ]));
        }
      });
}
