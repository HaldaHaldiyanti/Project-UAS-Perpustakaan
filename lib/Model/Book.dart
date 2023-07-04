class Book {
  final String id;
  final String judul;
  final String jumlahHalaman;
  final String kodeBuku;
  final String penerbit;
  final String penulis;
  final String sinopsis;
  final String kategori;
  final String? image;

  Book({
    required this.id,
    required this.judul,
    required this.jumlahHalaman,
    required this.kodeBuku,
    required this.penerbit,
    required this.penulis,
    required this.sinopsis,
    required this.kategori,
    this.image,
  });

  factory Book.fromJson(String id, Map<String, dynamic> json) {
    final jumlahHalaman = json['jumlah_halaman'];
    return Book(
      id: id,
      judul: json['judul'] ?? '',
      jumlahHalaman: jumlahHalaman != null ? jumlahHalaman.toString() : '',
      kodeBuku: json['kode_buku'] ?? '',
      penerbit: json['penerbit'] ?? '',
      penulis: json['penulis'] ?? '',
      sinopsis: json['sinopsis'] ?? '',
      kategori: json['kategori'] ?? '',
      image: json['image'],
    );
  }
}
