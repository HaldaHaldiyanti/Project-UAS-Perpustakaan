import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../Model/Book.dart';
import '../login_page.dart';
import 'ProfilePage.dart';
import 'DashboardUserPage.dart';
import 'ReadPage.dart';

class DashboardIlmuPengetahuanPage extends StatefulWidget {
  final String userKey;

  const DashboardIlmuPengetahuanPage({required this.userKey});

  @override
  _DashboardIlmuPengetahuanPageState createState() =>
      _DashboardIlmuPengetahuanPageState();
}

class _DashboardIlmuPengetahuanPageState
    extends State<DashboardIlmuPengetahuanPage> {
  bool isDashboardSelected = true;
  List<Book>? books;
  List<Book>? filteredBooks;
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchBooks().then((books) {
      setState(() {
        this.books = books;
        filteredBooks = books;
      });
    });
  }

  Future<List<Book>> fetchBooks() async {
    final response = await http.get(Uri.parse(
        'https://uas-buku-halda-haldiyanti-default-rtdb.asia-southeast1.firebasedatabase.app/buku.json'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<Book> books = [];

      jsonData.forEach((key, value) {
        if (value['kategori'] == 'Ilmu Pengetahuan') {
          Book book = Book(
            id: key,
            judul: value['judul'],
            jumlahHalaman: value['jumlah_halaman'],
            kodeBuku: value['kode_buku'],
            penerbit: value['penerbit'],
            penulis: value['penulis'],
            sinopsis: value['sinopsis'],
            kategori: value['kategori'],
            image: value['image'],
          );
          books.add(book);
        }
      });

      return books;
    } else {
      throw Exception('Failed to fetch books');
    }
  }

  void filterBooks(String query) {
    setState(() {
      _searchQuery = query;
      filteredBooks = books
          ?.where((book) =>
              book.judul.toLowerCase().contains(query.toLowerCase()) ||
              book.penulis.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
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
            Container(
              width: 360,
              height: 600,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 360,
                    height: 56,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        hintText: "Search",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            _searchController.clear();
                            filterBooks('');
                          },
                        ),
                      ),
                      onChanged: filterBooks,
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: filteredBooks?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          final book = filteredBooks?[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReadPage(
                                        book: book!, userKey: widget.userKey),
                                  ),
                                );
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(width: 15.0),
                                  Container(
                                    width: 125,
                                    child: AspectRatio(
                                      aspectRatio: 2 / 3,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image:
                                                NetworkImage(book?.image ?? ''),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15.0),
                                  Container(
                                    width: 230,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          book?.judul ?? '',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'Penulis: ${book?.penulis ?? ''}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'Kategori: ${book?.kategori ?? ''}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 15.0),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                                  ProfilePage(userKey: widget.userKey)),
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
