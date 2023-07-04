import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Admin/DashboardAdminPage.dart';
import 'User/DashboardUserPage.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? userKey;

  LoginPage({Key? key, this.userKey}) : super(key: key);

  void _login(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      final response = await http.get(
        Uri.parse(
            'https://uas-buku-halda-haldiyanti-default-rtdb.asia-southeast1.firebasedatabase.app/user.json'),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        String? role;
        data.forEach((key, value) {
          if (value['email'] == email && value['password'] == password) {
            role = value['role'];
            userKey = key;
          }
        });

        if (role != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                if (role == '0') {
                  return DashboardAdminPage();
                } else {
                  return DashboardUserPage(userKey: userKey?.toString());
                }
              },
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Login Error'),
                content: Text('Email dan password salah. Silahkan coba lagi.'),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Login Error'),
              content: Text('Gagal login. Silahkan coba lagi.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Login Error'),
            content: Text('Gagal login. Silahkan coba lagi.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0e6ea4),
      body: ListView(
        children: <Widget>[
          Center(
            child: Container(
              color: Color(0xff0e6ea4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 26.40),
                  SizedBox(
                    width: 250,
                    height: 69,
                    child: Text(
                      "WELCOME TO LIBRARY STMIK AMIKBANDUNG",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Container(
                    width: 425,
                    child: Image.asset(
                      'assets/images/login/amik.png',
                      width: 360,
                      height: 425,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 26.40),
                  Container(
                    width: 267,
                    height: 56,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 267,
                          height: 56,
                          child: Stack(
                            children: [
                              Container(
                                width: 267,
                                height: 56,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Color(0xff263238),
                                    width: 1,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                          width: 243,
                                          height: 36,
                                          child: TextField(
                                            controller: _emailController,
                                            decoration: InputDecoration(
                                              hintText: "",
                                              hintStyle: TextStyle(
                                                color: Color(0xff263238),
                                                fontSize: 16,
                                                letterSpacing: 0.16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: SizedBox(
                                    width: 263,
                                    height: 24,
                                    child: Text(
                                      "E-mail",
                                      style: TextStyle(
                                        color: Color(0xff263238),
                                        fontSize: 12,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w500,
                                      ),
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
                  SizedBox(height: 26.40),
                  Container(
                    width: 269,
                    height: 56,
                    color: Color(0xff0e6ea4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 269,
                          height: 56,
                          child: Stack(
                            children: [
                              Container(
                                width: 269,
                                height: 56,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Color(0xff263238),
                                    width: 1,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                          width: 245,
                                          height: 36,
                                          child: TextField(
                                            controller: _passwordController,
                                            obscureText: true,
                                            decoration: InputDecoration(
                                              hintText: "**",
                                              hintStyle: TextStyle(
                                                color: Color(0xff263238),
                                                fontSize: 16,
                                                letterSpacing: 0.16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: SizedBox(
                                    width: 265,
                                    height: 24,
                                    child: Text(
                                      "Password",
                                      style: TextStyle(
                                        color: Color(0xff263238),
                                        fontSize: 12,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w500,
                                      ),
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
                  SizedBox(height: 26.40),
                  Container(
                    width: 267,
                    height: 56,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 267,
                          height: 56,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 267,
                                height: 56,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
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
                                ),
                                child: ElevatedButton(
                                  onPressed: () => _login(context),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    onPrimary: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    "LOGIN",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w600,
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
                  SizedBox(height: 56.40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
