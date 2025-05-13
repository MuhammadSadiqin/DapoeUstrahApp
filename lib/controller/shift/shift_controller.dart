import 'package:dapoeutsrahapp/model/pengeluaran_model.dart';
import 'package:dapoeutsrahapp/model/shift_model.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class ShiftController extends GetxController {
  var shifts = <ShiftModel>[].obs;
  final _uuid = Uuid();

  // Tambahkan shift baru
  void tambahShift({
    required String namaKasir,
    required String shift,
    required DateTime tanggal,
  }) {
    final newShift = ShiftModel(
      id: _uuid.v4(),
      namaKasir: namaKasir,
      tanggal: tanggal,
      shift: shift,
    );

    shifts.add(newShift);
  }

  // Tambahkan transaksi ke shift tertentu
  void tambahTransaksi(String shiftId, int jumlahPcs) {
    final index = shifts.indexWhere((s) => s.id == shiftId);
    if (index != -1) {
      final current = shifts[index];
      final updated = ShiftModel(
        id: current.id,
        namaKasir: current.namaKasir,
        tanggal: current.tanggal,
        shift: current.shift,
        transaksi: [...current.transaksi, jumlahPcs],
        pengeluaran: current.pengeluaran,
      );
      shifts[index] = updated;
    }
  }

  // Tambahkan pengeluaran
  void tambahPengeluaran(String shiftId, PengeluaranModel item) {
    final index = shifts.indexWhere((s) => s.id == shiftId);
    if (index != -1) {
      final current = shifts[index];
      final updated = ShiftModel(
        id: current.id,
        namaKasir: current.namaKasir,
        tanggal: current.tanggal,
        shift: current.shift,
        transaksi: current.transaksi,
        pengeluaran: [...current.pengeluaran, item],
      );
      shifts[index] = updated;
    }
  }

  void updateJumlahDibuat(String shiftId, int jumlah) {
    final index = shifts.indexWhere((s) => s.id == shiftId);
    if (index != -1) {
      final current = shifts[index];
      final updated = ShiftModel(
        id: current.id,
        namaKasir: current.namaKasir,
        tanggal: current.tanggal,
        shift: current.shift,
        transaksi: current.transaksi,
        pengeluaran: current.pengeluaran,
        jumlahDibuat: jumlah,
      );
      shifts[index] = updated;
    }
  }

  // Cari shift berdasarkan ID
  ShiftModel? getShiftById(String id) {
    return shifts.firstWhereOrNull((s) => s.id == id);
  }
}
