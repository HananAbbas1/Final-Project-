// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_auth/msharlocation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'constants.dart';

class ALmshair extends StatefulWidget {
  @override
  State<ALmshair> createState() => _ALmshairState();
}

class _ALmshairState extends State<ALmshair> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text(
          'المشاعر',
          style: GoogleFonts.cairo(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 20, top: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'العمرة',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MasharLocation(
                                    title: 'السعي',
                                    Lat: 21.42376049271175,
                                    Lng: 39.82736366865262,
                                  )),
                        );
                        print('pressed');
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * .10,
                        width: MediaQuery.of(context).size.width * .25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(
                            color: kPrimaryColor,
                            width:
                                1, //                   <--- border width here
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'السعي',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.cairo(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MasharLocation(
                                  title: 'الطواف',
                                  Lat: 21.422627709133963,
                                  Lng: 39.82614880286758)),
                        );
                        print('pressed');
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * .10,
                        width: MediaQuery.of(context).size.width * .25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(
                            color: kPrimaryColor,
                            width:
                                1, //                   <--- border width here
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'الطواف',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.cairo(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MasharLocation(
                                    title: 'التحلل',
                                    Lat: 21.42405093494354,
                                    Lng: 39.8263633795881,
                                  )),
                        );
                        print('pressed');
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * .10,
                        width: MediaQuery.of(context).size.width * .25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(
                            color: kPrimaryColor,
                            width:
                                1, //                   <--- border width here
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'التحلل',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.cairo(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'الحج',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MasharLocation(
                                    title: 'السعي',
                                    Lat: 21.42376049271175,
                                    Lng: 39.82736366865262,
                                  )),
                        );
                        print('pressed');
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * .10,
                        width: MediaQuery.of(context).size.width * .25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(
                            color: kPrimaryColor,
                            width:
                                1, //                   <--- border width here
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'السعي',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.cairo(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MasharLocation(
                                  title: 'المسجد الحرام',
                                  Lat: 21.422627709133963,
                                  Lng: 39.82614880286758)),
                        );
                        print('pressed');
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * .10,
                        width: MediaQuery.of(context).size.width * .25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(
                            color: kPrimaryColor,
                            width:
                                1, //                   <--- border width here
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'المسجد الحرام',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.cairo(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MasharLocation(
                                    title: 'مزدلفة',
                                    Lat: 21.387160728182153,
                                    Lng: 39.9123732001983,
                                  )),
                        );
                        print('pressed');
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * .10,
                        width: MediaQuery.of(context).size.width * .25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(
                            color: kPrimaryColor,
                            width:
                                1, //                   <--- border width here
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'مزدلفة',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.cairo(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MasharLocation(
                                    title: 'عرفات - جبل الرحمة',
                                    Lat: 21.35484461726572,
                                    Lng: 39.983085961502326,
                                  )),
                        );
                        print('pressed');
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * .10,
                        width: MediaQuery.of(context).size.width * .25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(
                            color: kPrimaryColor,
                            width:
                                1, //                   <--- border width here
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'عرفات - جبل الرحمة',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.cairo(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MasharLocation(
                                    title: 'منى',
                                    Lat: 21.421599935602476,
                                    Lng: 39.87321490882251,
                                  )),
                        );
                        print('pressed');
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * .10,
                        width: MediaQuery.of(context).size.width * .25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(
                            color: kPrimaryColor,
                            width:
                                1, //                   <--- border width here
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'منى',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.cairo(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
