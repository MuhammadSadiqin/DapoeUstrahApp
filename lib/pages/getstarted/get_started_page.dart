import 'package:dapoeutsrahapp/config/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 32, left: 30),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 66),
                width: double.infinity,
                height: 330,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Bakpia_Logo_images.png'),
                  ),
                ),
              ),
              SizedBox(height: 25),
              Text(
                'Yuk, Beli Kue Di\nBakpia Dapoe Utsrah',
                style: GoogleFonts.arimo(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 21),
              Text(
                'Selalu Fresh From Open Setiap Hariya',
                style: GoogleFonts.arimo(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 25),
              SizedBox(
                height: 52,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.login);
                  },
                  child: Text(
                    "Login",
                    style: GoogleFonts.arimo(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff164415),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 21),
              SizedBox(
                height: 52,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.register);
                  },
                  child: Text(
                    "Daftar",
                    style: GoogleFonts.arimo(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xfff2b122),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(color: Color(0xfff2b122)),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
