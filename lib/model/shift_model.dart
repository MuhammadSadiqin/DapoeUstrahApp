import 'pengeluaran_model.dart';

class ShiftModel {
  final String id;
  final String namaKasir;
  final DateTime tanggal;
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

  int get totalBakpia => transaksi.fold(0, (sum, pcs) => sum + pcs);

  int get totalUangMasuk => totalBakpia * 1000;

  int get totalPengeluaran =>
      pengeluaran.fold(0, (sum, item) => sum + item.jumlah);

  int get sisaUang => totalUangMasuk - totalPengeluaran;

  int get jumlahKueSisa => jumlahDibuat - totalBakpia;

  String get tanggalFormatted =>
      '${tanggal.day.toString().padLeft(2, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.year}';
}
