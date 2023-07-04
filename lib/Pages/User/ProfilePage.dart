import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../login_page.dart';
import 'DashboardUserPage.dart';

class ProfilePage extends StatefulWidget {
  final String userKey;

  const ProfilePage({required this.userKey});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isDashboardSelected = true;

  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://uas-buku-halda-haldiyanti-default-rtdb.asia-southeast1.firebasedatabase.app/user/${widget.userKey}.json'));

    if (response.statusCode == 200) {
      setState(() {
        userData = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }

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
            Center(
                child: Container(
              width: 560,
              height: 870,
              color: Colors.white,
              padding: const EdgeInsets.only(
                top: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 286,
                    height: 264,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 132,
                      backgroundImage: NetworkImage("${userData?['image']}"),
                    ),
                  ),
                  SizedBox(height: 34.25),
                  Container(
                    width: 340,
                    height: 105,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 340,
                          height: 105,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 340,
                                height: 105,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.33),
                                    topRight: Radius.circular(5.33),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(0),
                                  ),
                                  color: Color.fromARGB(255, 229, 229, 229),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 16,
                                      top: 14,
                                      child: SizedBox(
                                        width: 206.67,
                                        height: 25.33,
                                        child: Text(
                                          "Nama :",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 21.33,
                                            letterSpacing: 0.21,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 16,
                                      top: 64,
                                      child: SizedBox(
                                        width: 310,
                                        height: 25.33,
                                        child: TextField(
                                          enabled: false,
                                          decoration: InputDecoration(
                                            hintText: "${userData?['nama']}",
                                            hintStyle: TextStyle(
                                              fontSize: 21,
                                              letterSpacing: 0.21,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Opacity(
                                          opacity: 0.38,
                                          child: Container(
                                            width: 286.67,
                                            height: 1.33,
                                            color: Color.fromARGB(
                                                255, 229, 229, 229),
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
                      ],
                    ),
                  ),
                  SizedBox(height: 27),
                  Container(
                    width: 340,
                    height: 105,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 340,
                          height: 105,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 340,
                                height: 105,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.33),
                                    topRight: Radius.circular(5.33),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(0),
                                  ),
                                  color: Color.fromARGB(255, 229, 229, 229),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 16,
                                      top: 14,
                                      child: SizedBox(
                                        width: 206.67,
                                        height: 25.33,
                                        child: Text(
                                          "NPM :",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 21.33,
                                            letterSpacing: 0.21,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 16,
                                      top: 64,
                                      child: SizedBox(
                                        width: 310,
                                        height: 25.33,
                                        child: TextField(
                                          enabled: false,
                                          decoration: InputDecoration(
                                            hintText: "${userData?['npm']}",
                                            hintStyle: TextStyle(
                                              fontSize: 21,
                                              letterSpacing: 0.21,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Opacity(
                                          opacity: 0.38,
                                          child: Container(
                                            width: 286.67,
                                            height: 1.33,
                                            color: Color.fromARGB(
                                                255, 229, 229, 229),
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
                      ],
                    ),
                  ),
                  SizedBox(height: 27),
                  Container(
                    width: 340,
                    height: 105,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 340,
                          height: 105,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 340,
                                height: 105,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.33),
                                    topRight: Radius.circular(5.33),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(0),
                                  ),
                                  color: Color.fromARGB(255, 229, 229, 229),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 16,
                                      top: 14,
                                      child: SizedBox(
                                        width: 206.67,
                                        height: 25.33,
                                        child: Text(
                                          "Jurusan :",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 21.33,
                                            letterSpacing: 0.21,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 16,
                                      top: 64,
                                      child: SizedBox(
                                        width: 310,
                                        height: 25.33,
                                        child: TextField(
                                          enabled: false,
                                          decoration: InputDecoration(
                                            hintText: "${userData?['jurusan']}",
                                            hintStyle: TextStyle(
                                              fontSize: 21,
                                              letterSpacing: 0.21,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Opacity(
                                          opacity: 0.38,
                                          child: Container(
                                            width: 286.67,
                                            height: 1.33,
                                            color: Color.fromARGB(
                                                255, 229, 229, 229),
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
                      ],
                    ),
                  ),
                  SizedBox(height: 27),
                  Container(
                    width: 340,
                    height: 105,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 340,
                          height: 105,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 340,
                                height: 105,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.33),
                                    topRight: Radius.circular(5.33),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(0),
                                  ),
                                  color: Color.fromARGB(255, 229, 229, 229),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 16,
                                      top: 14,
                                      child: SizedBox(
                                        width: 206.67,
                                        height: 25.33,
                                        child: Text(
                                          "Angkatan :",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 21.33,
                                            letterSpacing: 0.21,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 16,
                                      top: 64,
                                      child: SizedBox(
                                        width: 310,
                                        height: 25.33,
                                        child: TextField(
                                          enabled: false,
                                          decoration: InputDecoration(
                                            hintText:
                                                "${userData?['angkatan']}",
                                            hintStyle: TextStyle(
                                              fontSize: 21,
                                              letterSpacing: 0.21,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Opacity(
                                          opacity: 0.38,
                                          child: Container(
                                            width: 286.67,
                                            height: 1.33,
                                            color: Color.fromARGB(
                                                255, 229, 229, 229),
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
                      ],
                    ),
                  ),
                ],
              ),
            ))
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
                        color: Colors.white.withOpacity(0.54),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DashboardUserPage(userKey: widget.userKey)),
                        );
                      },
                    ),
                    Text(
                      "Category",
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
                        Icons.person,
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
                      "Profile",
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
