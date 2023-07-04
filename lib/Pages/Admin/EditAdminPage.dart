import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

import '../../Model/Book.dart';
import 'DashboardAdminPage.dart';

class EditAdminPage extends StatefulWidget {
  final Book book;

  EditAdminPage({required this.book});

  @override
  _EditAdminPageState createState() => _EditAdminPageState();
}

class _EditAdminPageState extends State<EditAdminPage> {
  TextEditingController _judulController = TextEditingController();
  TextEditingController _penulisController = TextEditingController();
  TextEditingController _halamanController = TextEditingController();
  TextEditingController _kodeBukuController = TextEditingController();
  TextEditingController _penerbitController = TextEditingController();
  TextEditingController _sinopsisController = TextEditingController();
  String? _selectedCategory;
  File? _selectedImage;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _judulController.text = widget.book.judul;
    _penulisController.text = widget.book.penulis;
    _halamanController.text = widget.book.jumlahHalaman;
    _kodeBukuController.text = widget.book.kodeBuku;
    _penerbitController.text = widget.book.penerbit;
    _sinopsisController.text = widget.book.sinopsis;
    _selectedCategory = widget.book.kategori;
    _imageUrl = widget.book.image;
  }

  final List<String> _categories = [
    'Ensiklopedia',
    'Ilmu Pengetahuan',
    'Novel',
  ];

  Future<void> pickImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedImage = File(result.files.first.path!);
      });
    }
  }

  Future<void> uploadImageToImgur(String imagePath) async {
    var url = Uri.parse("https://api.imgur.com/3/image/");
    var request = http.MultipartRequest('POST', url);
    request.headers["Authorization"] = "Client-ID ec1c3ef21b6692e";
    request.files.add(await http.MultipartFile.fromPath("image", imagePath));

    var response = await request.send();
    var responseJson = jsonDecode(await response.stream.bytesToString());
    setState(() {
      _imageUrl = responseJson["data"]["link"];
    });
  }

  Future<void> updateBook() async {
    final String url =
        'https://uas-buku-halda-haldiyanti-default-rtdb.asia-southeast1.firebasedatabase.app/buku/${widget.book.id}.json';
    final response = await http.put(
      Uri.parse(url),
      body: jsonEncode({
        'judul': _judulController.text,
        'penulis': _penulisController.text,
        'jumlah_halaman': _halamanController.text,
        'kode_buku': _kodeBukuController.text,
        'penerbit': _penerbitController.text,
        'sinopsis': _sinopsisController.text,
        'kategori': _selectedCategory,
        'image': _imageUrl,
      }),
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Buku berhasil diupdate!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashboardAdminPage(),
                    ),
                  );
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
            content: Text('Gagal update buku.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashboardAdminPage(),
                    ),
                  );
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Book'),
        backgroundColor: Color(0xff0e4ca4),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DashboardAdminPage(),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_imageUrl != null)
              Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 300,
                        child: Image.network(
                          _imageUrl!,
                          fit: BoxFit
                              .contain, // Atur tipe penyesuaian gambar sesuai kebutuhan Anda
                        ),
                      ),
                      ElevatedButton(
                        onPressed: pickImage,
                        child: Text('Pilih Gambar'),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff0e4ca4),
                        ),
                      ),
                    ]),
              ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _judulController,
              decoration: InputDecoration(labelText: 'Judul'),
            ),
            TextFormField(
              controller: _penulisController,
              decoration: InputDecoration(labelText: 'Penulis'),
            ),
            TextFormField(
              controller: _halamanController,
              decoration: InputDecoration(labelText: 'Jumlah Halaman'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _kodeBukuController,
              decoration: InputDecoration(labelText: 'Kode Buku'),
            ),
            TextFormField(
              controller: _penerbitController,
              decoration: InputDecoration(labelText: 'Penerbit'),
            ),
            TextFormField(
              controller: _sinopsisController,
              decoration: InputDecoration(labelText: 'Sinopsis'),
              maxLines: null,
            ),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: InputDecoration(labelText: 'Kategori'),
              items: _categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
            ),
            if (_imageUrl == null)
              Column(
                children: <Widget>[
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: pickImage,
                    child: Text('Pilih Gambar'),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff0e4ca4),
                    ),
                  ),
                ],
              ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                if (_selectedImage != null) {
                  await uploadImageToImgur(_selectedImage!.path);
                }
                updateBook();
              },
              child: Text('Update'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xff0e4ca4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
