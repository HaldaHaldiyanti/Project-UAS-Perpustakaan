import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

import 'DashboardAdminPage.dart';

class UploadAdminPage extends StatefulWidget {
  @override
  _UploadAdminPageState createState() => _UploadAdminPageState();
}

class _UploadAdminPageState extends State<UploadAdminPage> {
  TextEditingController _judulController = TextEditingController();
  TextEditingController _penulisController = TextEditingController();
  TextEditingController _halamanController = TextEditingController();
  TextEditingController _kodeBukuController = TextEditingController();
  TextEditingController _penerbitController = TextEditingController();
  TextEditingController _sinopsisController = TextEditingController();
  String? _selectedCategory;
  File? _selectedImage;
  String? _imageUrl;

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

  Future<void> uploadBook() async {
    final String url =
        'https://uas-buku-halda-haldiyanti-default-rtdb.asia-southeast1.firebasedatabase.app/buku.json';
    final response = await http.post(
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
            content: Text('Buku berhasil diupload!'),
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
            content: Text('Gagal upload buku.'),
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
        title: Text('Upload Book'),
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
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: pickImage,
              child: Text('Pilih Gambar'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xff0e4ca4),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                if (_selectedImage != null &&
                    _judulController.text.isNotEmpty &&
                    _penulisController.text.isNotEmpty &&
                    _halamanController.text.isNotEmpty &&
                    _kodeBukuController.text.isNotEmpty &&
                    _penerbitController.text.isNotEmpty &&
                    _sinopsisController.text.isNotEmpty &&
                    _selectedCategory != null) {
                  await uploadImageToImgur(_selectedImage!.path);
                  uploadBook();
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content:
                            Text('Harap lengkapi semua form dan pilih gambar.'),
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
              },
              child: Text('Upload'),
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
