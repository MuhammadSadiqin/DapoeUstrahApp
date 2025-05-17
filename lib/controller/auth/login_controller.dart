import 'package:dapoeutsrahapp/config/datasource/auth_datasource.dart';
import 'package:dapoeutsrahapp/config/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
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
      final user = await AuthDatasource().signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (user != null) {
        Get.snackbar(
          "suksess",
          "Login Berhasil",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed(AppRoutes.mainShift);
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
