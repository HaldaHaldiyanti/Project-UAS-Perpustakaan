import 'package:flutter/material.dart';

import '../login_page.dart';
import 'ProfilePage.dart';
import 'DashboardEnsiklopediaPage.dart';
import 'DashboardIlmuPengetahuanPage.dart';
import 'DashboardNovelPage.dart';

class DashboardUserPage extends StatefulWidget {
  final String? userKey;

  DashboardUserPage({required this.userKey});

  @override
  _DashboardUserPageState createState() => _DashboardUserPageState();
}

class _DashboardUserPageState extends State<DashboardUserPage> {
  bool isDashboardSelected = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: ListView(
          children: <Widget>[
            Container(
              width: 360,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 63.67),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DashboardNovelPage(
                                  userKey: widget.userKey!)));
                    },
                    child: Container(
                      child: Stack(
                        children: [
                          Container(
                            width: 319,
                            height: 142,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 319,
                                  height: 142,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x19000000),
                                        blurRadius: 8,
                                        offset: Offset(0, 1),
                                      ),
                                      BoxShadow(
                                        color: Color(0x1e000000),
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                      BoxShadow(
                                        color: Color(0x28000000),
                                        blurRadius: 2,
                                        offset: Offset(0, 1),
                                      ),
                                    ],
                                    color: Color(0xff0e4ca4),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "NOVEL",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 23.67),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DashboardIlmuPengetahuanPage(
                                      userKey: widget.userKey!)));
                    },
                    child: Container(
                      child: Stack(
                        children: [
                          Container(
                            width: 319,
                            height: 142,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 319,
                                  height: 142,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x19000000),
                                        blurRadius: 8,
                                        offset: Offset(0, 1),
                                      ),
                                      BoxShadow(
                                        color: Color(0x1e000000),
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                      BoxShadow(
                                        color: Color(0x28000000),
                                        blurRadius: 2,
                                        offset: Offset(0, 1),
                                      ),
                                    ],
                                    color: Color(0xff0e4ca4),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "ILMU PENGETAHUAN",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 23.67),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DashboardEnsiklopediaPage(
                                  userKey: widget.userKey!)));
                    },
                    child: Container(
                      child: Stack(
                        children: [
                          Container(
                            width: 319,
                            height: 142,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 319,
                                  height: 142,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x19000000),
                                        blurRadius: 8,
                                        offset: Offset(0, 1),
                                      ),
                                      BoxShadow(
                                        color: Color(0x1e000000),
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                      BoxShadow(
                                        color: Color(0x28000000),
                                        blurRadius: 2,
                                        offset: Offset(0, 1),
                                      ),
                                    ],
                                    color: Color(0xff0e4ca4),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "ENSIKLOPEDIA",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 23.67),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            width: 360,
            height: 66,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              color: Color(0xff0e4ca4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.category,
                        color: isDashboardSelected
                            ? Colors.white
                            : Colors.white.withOpacity(0.54),
                      ),
                      onPressed: () {
                        setState(() {
                          isDashboardSelected = true;
                        });
                      },
                    ),
                    Text(
                      "Category",
                      style: TextStyle(
                        color: isDashboardSelected
                            ? Colors.white
                            : Colors.white.withOpacity(0.54),
                        fontSize: 12,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.person,
                        color: Colors.white.withOpacity(0.54),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProfilePage(userKey: widget.userKey!)),
                        );
                      },
                    ),
                    Text(
                      "Profile",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.54),
                        fontSize: 12,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.logout,
                        color: Colors.white.withOpacity(0.54),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                    ),
                    Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.54),
                        fontSize: 12,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
