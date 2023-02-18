import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/permissions.dart';
import 'package:flutter_auth/violations.dart';
import 'almshar.dart';
import 'landingScreen.dart';
import 'listofHajaj.dart';

class MenuPage extends StatefulWidget {
  bool isItCamping = false;

  MenuPage({Key? key, required this.isItCamping}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: true,
        title: Text(widget.isItCamping ? 'الحملات' : 'الحجاج'),
        centerTitle: true,
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
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'حملة ',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
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
                      child: const Text(
                        'الحجاج',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
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
                                    isitcomp: true,
                                    Id: snapshot.data!['id'],
                                  )),
                        );
                        print('pressed');
                      },
                      child: const Text(
                        'التصاريح',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
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
                        print('pressed');
                      },
                      child: const Text(
                        'المخالفات',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
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
                Container(
                  height: MediaQuery.of(context).size.height * .10,
                  width: MediaQuery.of(context).size.width * .70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://www.almowaten.net/wp-content/uploads/2022/07/%D9%85%D8%B4%D8%B9%D8%B1-%D9%85%D9%86%D9%89.jpg'),
                          fit: BoxFit.cover)),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ALmshair()),
                      );
                      print('pressed');
                    },
                    child: Center(
                      child: Text(
                        'المشاعر',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 55,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .05,
                ),
                Container(
                  height: 100,
                  width: 200,
                  child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.account_circle,
                        color: Colors.black,
                        size: 100,
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      snapshot.data!['name'],
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'مرحبا ',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      snapshot.data!['id'],
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ':رقم الهوية ',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      snapshot.data!['campaignnumber'],
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ':رقم الحملة ',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      snapshot.data!['campaignname'],
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ':اسم الحملة ',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .10,
                ),
              ],
            ),
          );
        }
      });
}
