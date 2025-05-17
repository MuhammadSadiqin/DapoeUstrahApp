import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/shift_model.dart';

class ShiftService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveShift(ShiftModel shift) async {
    await _db.collection('shifts').doc(shift.id).set(shift.toJson());
  }

  Stream<List<ShiftModel>> streamShifts() {
    return _db
        .collection('shifts')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => ShiftModel.fromJson(doc.data()))
                  .toList(),
        );
  }

  Future<void> deleteShift(String id) async {
    await _db.collection('shifts').doc(id).delete();
  }
}
