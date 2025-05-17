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

  // Hapus transaksi
  void hapusTransaksi(String shiftId, int index) {
    final idx = shifts.indexWhere((s) => s.id == shiftId);
    if (idx != -1) {
      final cur = shifts[idx];
      final updatedTransaksi = List<int>.from(cur.transaksi)..removeAt(index);
      final updated = ShiftModel(
        id: cur.id,
        namaKasir: cur.namaKasir,
        tanggal: cur.tanggal,
        shift: cur.shift,
        transaksi: updatedTransaksi,
        pengeluaran: cur.pengeluaran,
        jumlahDibuat: cur.jumlahDibuat,
      );
      shifts[idx] = updated;
    }
  }

  // Update transaksi
  void updateTransaksi(String shiftId, int index, int newJumlah) {
    final idx = shifts.indexWhere((s) => s.id == shiftId);
    if (idx != -1) {
      final cur = shifts[idx];
      final updatedTransaksi = List<int>.from(cur.transaksi);
      updatedTransaksi[index] = newJumlah;
      final updated = ShiftModel(
        id: cur.id,
        namaKasir: cur.namaKasir,
        tanggal: cur.tanggal,
        shift: cur.shift,
        transaksi: updatedTransaksi,
        pengeluaran: cur.pengeluaran,
        jumlahDibuat: cur.jumlahDibuat,
      );
      shifts[idx] = updated;
    }
  }

  // Hapus pengeluaran
  void hapusPengeluaran(String shiftId, int index) {
    final idx = shifts.indexWhere((s) => s.id == shiftId);
    if (idx != -1) {
      final cur = shifts[idx];
      final updatedPengeluaran = List<PengeluaranModel>.from(cur.pengeluaran)
        ..removeAt(index);
      final updated = ShiftModel(
        id: cur.id,
        namaKasir: cur.namaKasir,
        tanggal: cur.tanggal,
        shift: cur.shift,
        transaksi: cur.transaksi,
        pengeluaran: updatedPengeluaran,
        jumlahDibuat: cur.jumlahDibuat,
      );
      shifts[idx] = updated;
    }
  }

  // Update pengeluaran
  void updatePengeluaran(String shiftId, int index, PengeluaranModel newItem) {
    final idx = shifts.indexWhere((s) => s.id == shiftId);
    if (idx != -1) {
      final cur = shifts[idx];
      final updatedPengeluaran = List<PengeluaranModel>.from(cur.pengeluaran);
      updatedPengeluaran[index] = newItem;
      final updated = ShiftModel(
        id: cur.id,
        namaKasir: cur.namaKasir,
        tanggal: cur.tanggal,
        shift: cur.shift,
        transaksi: cur.transaksi,
        pengeluaran: updatedPengeluaran,
        jumlahDibuat: cur.jumlahDibuat,
      );
      shifts[idx] = updated;
    }
  }

  // Cari shift berdasarkan ID
  ShiftModel? getShiftById(String id) {
    return shifts.firstWhereOrNull((s) => s.id == id);
  }
}
