import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:situsa/Pages/presensi/main_absen.dart';
import 'package:situsa/Pages/profile_page.dart';
import 'package:situsa/Pages/riwayat/riwayat_pekerjaan.dart';

import 'presensi/absen_page.dart';

class HalamanUtama extends StatefulWidget {
  final VoidCallback signOut;
  HalamanUtama(this.signOut);
  @override
  _HalamanUtamaState1 createState() => _HalamanUtamaState1();
}

class _HalamanUtamaState1 extends State<HalamanUtama> {
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  int id;
  String name, token;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString("name");
      id = preferences.getInt("id");
      token = preferences.getString("token");
    });
    print("$id, $name, $token");
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  double top = 105;
  double left = 360;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 20),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Color(0xff037171),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(left: 15),
                          width: MediaQuery.of(context).size.width / 9,
                          child: Image(
                              image: AssetImage('lib/assets/jepara.png'))),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "SAPU BERSIH",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width / 17),
                          ),
                          Text("SISTEM ABSENSI PETUGAS KEBERSIHAN KAB JEPARA",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 33)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 6.7),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(90))),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(90)),
                child: Column(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 15),
                          width: MediaQuery.of(context).size.width / 6.3,
                          child: Container(
                              child: Icon(Icons.people,
                                  size: MediaQuery.of(context).size.width / 7,
                                  color: Color(0xff037171))
                              // Image(
                              //     image: AssetImage('lib/assets/bio.png')),

                              )),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 9),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MainPresensiPage1()));
                                },
                                child: Material(
                                  borderRadius: BorderRadius.circular(10),
                                  elevation: 9,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3.5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.assignment_turned_in,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              6,
                                          color: Color(0xff037171),
                                        ),
                                        Text("PRESENSI",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    25)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RiwayatKerjaPage()));
                                },
                                child: Material(
                                  borderRadius: BorderRadius.circular(10),
                                  elevation: 9,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3.5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.assignment,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              6,
                                          color: Color(0xff037171),
                                        ),
                                        Column(
                                          children: <Widget>[
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text("RIWAYAT",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            25)),
                                            Text("PEKERJAAN",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            25)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 7),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProfilePage()));
                                },
                                child: Material(
                                  borderRadius: BorderRadius.circular(10),
                                  elevation: 9,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3.5,
                                    // margin: EdgeInsets.only(right: 17),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.person,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              6,
                                          color: Color(0xff037171),
                                        ),
                                        Text("PROFILE",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    25)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // signOut();
                                  _showDialog();
                                },
                                child: Material(
                                  borderRadius: BorderRadius.circular(10),
                                  elevation: 13,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3.5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.exit_to_app,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              6,
                                          color: Color(0xff037171),
                                        ),
                                        Text("LOGOUT",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    25)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("KELUAR ?"),
          // content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("BATAL"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  signOut();
                },
                child: Text(
                  "KELUAR",
                  style: TextStyle(color: Colors.red),
                ))
          ],
        );
      },
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Ketuk lagi untuk keluar");
      return Future.value(false);
    }
    return Future.value(true);
  }

  DateTime currentBackPressTime;
}