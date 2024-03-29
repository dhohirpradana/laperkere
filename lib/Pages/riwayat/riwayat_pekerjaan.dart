import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:situsa/Pages/login_page.dart';
import 'package:situsa/api/api.dart';

class RiwayatKerjaPage extends StatefulWidget {
  @override
  _RiwayatKerjaPageState createState() => _RiwayatKerjaPageState();
}

class _RiwayatKerjaPageState extends State<RiwayatKerjaPage> {
  @override
  void initState() {
    super.initState();
    getPref();
  }

  resetSavePref(int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
    });
  }

  int id;
  String token;
  Map<String, dynamic> data;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getInt("id");
      token = preferences.getString("token");
    });
    print("$id, $token");
    getProfile();
  }

  int isLoading = 1;
  getProfile() async {
    var response = await http.get(Uri.encodeFull(BaseUrl.riwayat), headers: {
      HttpHeaders.authorizationHeader: "bearer $token",
      'Accept': 'application-json'
    });

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      print(data);
      print(response.statusCode);
      setState(() {
        isLoading = 0;
      });
    } else {
      setState(() {
        resetSavePref(0);
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPageKu()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "RIWAYAT PEKERJAAN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Icon(Icons.directions_run),
          ],
        ),
        backgroundColor: Color(0xff037171),
      ),
      body: Material(
        child: ListView.builder(
          itemCount: data == null ? 0 : data["data"].length,
          itemBuilder: (BuildContext context, int index) {
            final waktu = data["data"][index]["time"];
            final tahun = waktu.substring(0, 4);
            final bulan = waktu.substring(5, 7);
            final tanggal = waktu.substring(8, 10);
            final jam = waktu.substring(11, 16);
            final image = data["data"][index]["image"];
            final namab = (bulan == "01")
                ? "Januari"
                : (bulan == "02")
                    ? "Februari"
                    : (bulan == "03")
                        ? "Maret"
                        : (bulan == "04")
                            ? "April"
                            : (bulan == "05")
                                ? "Mei"
                                : (bulan == "06")
                                    ? "Juni"
                                    : (bulan == "07")
                                        ? "Juli"
                                        : (bulan == "08")
                                            ? "Agustus"
                                            : (bulan == "09")
                                                ? "September"
                                                : (bulan == "10")
                                                    ? "Oktober"
                                                    : (bulan == "11")
                                                        ? "November"
                                                        : "Dessember";
            final imageurl = BaseUrl.image;
            return Card(
              child: InkWell(
                splashColor: Colors.blue[300],
                onTap: () {
                  showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (BuildContext context) {
                      // return object of type Dialog
                      return AlertDialog(
                        title: Text(
                          "DETAIL RIWAYAT PEKERJAAN",
                          style: TextStyle(
                              color: Colors.blueGrey.withOpacity(0.9)),
                        ),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.all(5),
                                  child: Text(
                                    "$tanggal $namab $tahun, $jam",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                23,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.deepPurple),
                                  ),
                                ),
                                Text(
                                  data["data"][index]["lokasi"],
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              23,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 1, bottom: 3),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.purpleAccent
                                              .withOpacity(0.3),
                                          width: 2.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Flexible(
                              child: Center(
                                child: Image.network("$imageurl/$image"),
                              ),
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          // usually buttons at the bottom of the dialog
                          FlatButton(
                            child: Text(
                              "TUTUP",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 23,
                                  color: Colors.red),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.only(
                      left: 9,
                      right: 9,
                      top: MediaQuery.of(context).size.width / 21,
                      bottom: MediaQuery.of(context).size.width / 21),
                  child: Row(
                    children: <Widget>[
                      Text((index + 1).toString(),
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width / 23)),
                      SizedBox(
                        width: 10,
                        child: Text("."),
                      ),
                      Text(
                        data["data"][index]["time"],
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 23,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Text(data["data"][index]["lokasi"],
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 23,
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
