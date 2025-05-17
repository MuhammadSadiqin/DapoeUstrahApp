class PengeluaranModel {
  final String nama;
  final int jumlah;

  PengeluaranModel({required this.nama, required this.jumlah});

  Map<String, dynamic> toJson() => {'nama': nama, 'jumlah': jumlah};

  factory PengeluaranModel.fromJson(Map<String, dynamic> json) {
    return PengeluaranModel(
      nama: json['nama'] ?? '',
      jumlah: json['jumlah'] ?? 0,
    );
  }
}
