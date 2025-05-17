import 'package:dapoeutsrahapp/config/custom/custom_text_form_field.dart';
import 'package:dapoeutsrahapp/controller/auth/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final registerC = Get.find<RegisterController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: ListView(
            children: [
              Center(
                child: Container(
                  width: 300,
                  height: 280,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/Bakpia_Logo_images.png'),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                label: 'Masukkan Email',
                controller: registerC.emailController,
              ),
              CustomTextFormField(
                label: 'Masukkan Password',
                controller: registerC.passwordController,
              ),
              SizedBox(
                height: 52,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: registerC.register,
                  child: Text(
                    "Mendaftar",
                    style: GoogleFonts.arimo(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff3498DB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
