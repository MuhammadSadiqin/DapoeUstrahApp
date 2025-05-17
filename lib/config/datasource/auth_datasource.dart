import 'package:firebase_auth/firebase_auth.dart';

class AuthDatasource {
  final _auth = FirebaseAuth.instance;
  Future<User?> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      String message = 'Terjadi kesalahan';
      if (e.code == 'weak-password') {
        message = 'Password terlalu lemah.';
      } else if (e.code == 'email-already-in-use') {
        message = 'Email sudah digunakan.';
      } else if (e.code == 'invalid-email') {
        message = 'Format email tidak valid.';
      }
      throw Exception(message); // dilempar ke pemanggil
    }
  }

  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential.user;
    } on FirebaseAuthException catch (e) {
      String message = 'Terjadi kesalahan saat login.';

      if (e.code == 'user-not-found') {
        message = 'Akun tidak ditemukan.';
      } else if (e.code == 'wrong-password') {
        message = 'Password salah.';
      } else if (e.code == 'invalid-email') {
        message = 'Format email salah.';
      }

      throw Exception(message); // Biarkan UI layer yang menangani
    }
  }
}
