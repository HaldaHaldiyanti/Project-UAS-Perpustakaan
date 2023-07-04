import 'package:flutter/material.dart';

import 'DashboardUserPage.dart';
import '../../Model/Book.dart';

class ReadPage extends StatelessWidget {
  final Book book;
  final String userKey;

  ReadPage({required this.book, required this.userKey});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: <Widget>[
            Container(
              height: 655,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Row(children: [
                    SizedBox(width: 5),
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 215,
                        child: Image.network(
                          book.image ?? '',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    Column(children: [
                      Text(
                        "${book.judul}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Penulis: ${book.penulis}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Jumlah Halaman: ${book.jumlahHalaman}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Penerbit: ${book.penerbit}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "ISBN: ${book.kodeBuku}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ]),
                    SizedBox(width: 25),
                  ]),
                  SizedBox(height: 14),
                  Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          book.sinopsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            letterSpacing: 0.18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DashboardUserPage(userKey: userKey),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff0e4ca4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 45),
                      child: Text(
                        "Kembali Ke Home",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
