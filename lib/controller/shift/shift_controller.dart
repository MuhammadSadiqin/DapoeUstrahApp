import 'package:dapoeutsrahapp/model/pengeluaran_model.dart';
import 'package:dapoeutsrahapp/model/shift_model.dart';
import 'package:dapoeutsrahapp/service/shift_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ShiftController extends GetxController {
  final ShiftService _shiftService = ShiftService();

  var shifts = <ShiftModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _listenShifts();
  }

  void _listenShifts() {
    _shiftService.streamShifts().listen((data) {
      shifts.value = data;
    });
  }

  ShiftModel? getShiftById(String id) {
    try {
      return shifts.firstWhere((element) => element.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> saveShift(ShiftModel shift) async {
    await _shiftService.saveShift(shift);
  }

  Future<void> deleteShift(String id) async {
    await _shiftService.deleteShift(id);
  }

  Future<void> tambahTransaksi(String shiftId, int jumlah) async {
    final shift = getShiftById(shiftId);
    if (shift != null) {
      final updated = ShiftModel(
        id: shift.id,
        namaKasir: shift.namaKasir,
        tanggal: shift.tanggal,
        shift: shift.shift,
        jumlahDibuat: shift.jumlahDibuat,
        transaksi: [...shift.transaksi, jumlah],
        pengeluaran: shift.pengeluaran,
      );
      await saveShift(updated);
    }
  }

  Future<void> updateTransaksi(String shiftId, int index, int newJumlah) async {
    final shift = getShiftById(shiftId);
    if (shift != null) {
      final List<int> updatedTransaksi = [...shift.transaksi];
      updatedTransaksi[index] = newJumlah;
      final updated = ShiftModel(
        id: shift.id,
        namaKasir: shift.namaKasir,
        tanggal: shift.tanggal,
        shift: shift.shift,
        jumlahDibuat: shift.jumlahDibuat,
        transaksi: updatedTransaksi,
        pengeluaran: shift.pengeluaran,
      );
      await saveShift(updated);
    }
  }

  Future<void> hapusTransaksi(String shiftId, int index) async {
    final shift = getShiftById(shiftId);
    if (shift != null) {
      final List<int> updatedTransaksi = [...shift.transaksi];
      updatedTransaksi.removeAt(index);
      final updated = ShiftModel(
        id: shift.id,
        namaKasir: shift.namaKasir,
        tanggal: shift.tanggal,
        shift: shift.shift,
        jumlahDibuat: shift.jumlahDibuat,
        transaksi: updatedTransaksi,
        pengeluaran: shift.pengeluaran,
      );
      await saveShift(updated);
    }
  }

  Future<void> tambahPengeluaran(
    String shiftId,
    PengeluaranModel pengeluaran,
  ) async {
    final shift = getShiftById(shiftId);
    if (shift != null) {
      final updated = ShiftModel(
        id: shift.id,
        namaKasir: shift.namaKasir,
        tanggal: shift.tanggal,
        shift: shift.shift,
        jumlahDibuat: shift.jumlahDibuat,
        transaksi: shift.transaksi,
        pengeluaran: [...shift.pengeluaran, pengeluaran],
      );
      await saveShift(updated);
    }
  }

  Future<void> updatePengeluaran(
    String shiftId,
    int index,
    PengeluaranModel newPengeluaran,
  ) async {
    final shift = getShiftById(shiftId);
    if (shift != null) {
      final List<PengeluaranModel> updatedPengeluaran = [...shift.pengeluaran];
      updatedPengeluaran[index] = newPengeluaran;
      final updated = ShiftModel(
        id: shift.id,
        namaKasir: shift.namaKasir,
        tanggal: shift.tanggal,
        shift: shift.shift,
        jumlahDibuat: shift.jumlahDibuat,
        transaksi: shift.transaksi,
        pengeluaran: updatedPengeluaran,
      );
      await saveShift(updated);
    }
  }

  Future<void> hapusPengeluaran(String shiftId, int index) async {
    final shift = getShiftById(shiftId);
    if (shift != null) {
      final List<PengeluaranModel> updatedPengeluaran = [...shift.pengeluaran];
      updatedPengeluaran.removeAt(index);
      final updated = ShiftModel(
        id: shift.id,
        namaKasir: shift.namaKasir,
        tanggal: shift.tanggal,
        shift: shift.shift,
        jumlahDibuat: shift.jumlahDibuat,
        transaksi: shift.transaksi,
        pengeluaran: updatedPengeluaran,
      );
      await saveShift(updated);
    }
  }

  Future<void> updateJumlahDibuat(String shiftId, int jumlah) async {
    final shift = getShiftById(shiftId);
    if (shift != null) {
      final updated = ShiftModel(
        id: shift.id,
        namaKasir: shift.namaKasir,
        tanggal: shift.tanggal,
        shift: shift.shift,
        jumlahDibuat: jumlah,
        transaksi: shift.transaksi,
        pengeluaran: shift.pengeluaran,
      );
      await saveShift(updated);
    }
  }

  Future<void> tambahShift({
    required String namaKasir,
    required String shift,
    required DateTime tanggal,
  }) async {
    final id = const Uuid().v4(); // generate unique id untuk document Firestore

    final newShift = ShiftModel(
      id: id,
      namaKasir: namaKasir,
      shift: shift,
      tanggal: DateFormat(
        'yyyy-MM-dd',
      ).format(tanggal), // simpan string tanggal rapi
      transaksi: [],
      pengeluaran: [],
      jumlahDibuat: 0,
    );

    await _shiftService.saveShift(newShift);
  }
}
