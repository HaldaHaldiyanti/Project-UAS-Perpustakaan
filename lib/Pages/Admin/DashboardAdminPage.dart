import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../Model/Book.dart';
import '../login_page.dart';
import 'EditAdminPage.dart';
import 'UploadAdminPage.dart';

class DashboardAdminPage extends StatefulWidget {
  @override
  _DashboardAdminPageScreenState createState() =>
      _DashboardAdminPageScreenState();
}

class _DashboardAdminPageScreenState extends State<DashboardAdminPage> {
  bool isDashboardSelected = true;

  List<Book> books = [];

  List<Book> filteredBooks = [];
  String searchText = '';

  Future<List<Book>> fetchBooks() async {
    final response = await http.get(Uri.parse(
        'https://uas-buku-halda-haldiyanti-default-rtdb.asia-southeast1.firebasedatabase.app/buku.json'));

    if (response.statusCode == 200) {
      final Map<String, dynamic>? data = jsonDecode(response.body);
      if (data != null) {
        data.forEach((key, value) {
          final book = Book.fromJson(key, value);
          books.add(book);
        });
      }
    } else {
      throw Exception('Failed to fetch books');
    }

    return books;
  }

  @override
  void initState() {
    super.initState();
    fetchBooks().then((value) {
      setState(() {
        books = value;
        filteredBooks = value;
      });
    }).catchError((error) {
      print('Error fetching books: $error');
    });
  }

  void navigateToEditBook(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditAdminPage(book: book),
      ),
    ).then((value) {
      if (value != null && value is Book) {
        setState(() {
          final index = books.indexWhere((element) => element.id == value.id);
          if (index != -1) {
            books[index] = value;
            filteredBooks[index] = value;
          }
        });
      }
    });
  }

  Future<void> deleteBook(String id) async {
    final url =
        'https://uas-buku-halda-haldiyanti-default-rtdb.asia-southeast1.firebasedatabase.app/buku/$id.json';
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        books.removeWhere((book) => book.id == id);
        filteredBooks.removeWhere((book) => book.id == id);
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Buku berhasil dihapus!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Buku gagal dihapus.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
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
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(0),
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(0),
                                ),
                              ),
                              hintText: "Search",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              prefixIcon: IconButton(
                                icon: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    filteredBooks = books
                                        .where((book) => book.judul
                                            .toLowerCase()
                                            .contains(searchText.toLowerCase()))
                                        .toList();
                                  });
                                },
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                searchText = value;
                              });
                            },
                            onSubmitted: (value) {
                              setState(() {
                                searchText = value;
                                filteredBooks = books
                                    .where((book) => book.judul
                                        .toLowerCase()
                                        .contains(searchText.toLowerCase()))
                                    .toList();
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 2),
                        Container(
                          width: 56,
                          height: 300,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UploadAdminPage()),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 23.67),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: filteredBooks.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                    itemBuilder: (context, index) {
                      final book = filteredBooks[index];
                      return ListTile(
                        title: Text(book.judul),
                        subtitle: Text(book.penulis),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                navigateToEditBook(book);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Delete Book'),
                                      content: Text(
                                          'Apa kamu yakin ingin menghapus buku?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            deleteBook(book.id);
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Delete'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
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
                        Icons.dashboard,
                        color: isDashboardSelected
                            ? Colors.white
                            : Colors.white.withOpacity(0.54),
                      ),
                      onPressed: () {
                        setState(() {
                          isDashboardSelected = true;
                        });
                        // Add your navigation code here
                      },
                    ),
                    Text(
                      "Dashboard",
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
