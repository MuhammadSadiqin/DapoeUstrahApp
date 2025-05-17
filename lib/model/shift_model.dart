import 'pengeluaran_model.dart';

class ShiftModel {
  final String id;
  final String namaKasir;
  final String tanggal;
  final String shift;
  final int jumlahDibuat;
  final List<int> transaksi;
  final List<PengeluaranModel> pengeluaran;

  ShiftModel({
    required this.id,
    required this.namaKasir,
    required this.tanggal,
    required this.shift,
    this.jumlahDibuat = 0,
    this.transaksi = const [],
    this.pengeluaran = const [],
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'namaKasir': namaKasir,
    'tanggal': tanggal,
    'shift': shift,
    'jumlahDibuat': jumlahDibuat,
    'transaksi': transaksi,
    'pengeluaran': pengeluaran.map((e) => e.toJson()).toList(),
  };

  factory ShiftModel.fromJson(Map<String, dynamic> json) {
    return ShiftModel(
      id: json['id'] ?? '',
      namaKasir: json['namaKasir'] ?? '',
      tanggal: json['tanggal'] ?? '',
      shift: json['shift'] ?? '',
      jumlahDibuat: json['jumlahDibuat'] ?? 0,
      transaksi: List<int>.from(json['transaksi'] ?? []),
      pengeluaran:
          (json['pengeluaran'] as List<dynamic>? ?? [])
              .map((e) => PengeluaranModel.fromJson(e))
              .toList(),
    );
  }

  int get totalBakpia => transaksi.fold(0, (sum, item) => sum + item);
  int get totalUangMasuk => totalBakpia * 1000;
  int get totalPengeluaran =>
      pengeluaran.fold(0, (sum, item) => sum + item.jumlah);
  int get sisaUang => totalUangMasuk - totalPengeluaran;
  int get jumlahKueSisa => jumlahDibuat - totalBakpia;
}
