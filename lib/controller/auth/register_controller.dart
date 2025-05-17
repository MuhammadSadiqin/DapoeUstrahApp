import 'package:dapoeutsrahapp/config/datasource/auth_datasource.dart';
import 'package:dapoeutsrahapp/config/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> register() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        "Peringatan",
        "Email dan password wajib di isi!",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    try {
      final user = await AuthDatasource().createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (user != null) {
        Get.snackbar(
          "suksess",
          "Akun Berhasil di daftarkan",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed(AppRoutes.login);
      }
    } catch (e) {
      Get.snackbar(
        "error",
        e.toString().replaceAll('Exception: ', ''),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
