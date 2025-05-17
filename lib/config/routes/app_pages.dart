import 'package:dapoeutsrahapp/bindings/login_binding.dart';
import 'package:dapoeutsrahapp/bindings/register_binding.dart';
import 'package:dapoeutsrahapp/bindings/shift_binding.dart';
import 'package:dapoeutsrahapp/config/routes/app_routes.dart';
import 'package:dapoeutsrahapp/pages/auth/login/login_page.dart';
import 'package:dapoeutsrahapp/pages/auth/register/register_page.dart';
import 'package:dapoeutsrahapp/pages/getstarted/get_started_page.dart';
import 'package:dapoeutsrahapp/pages/shift/form_shift_page.dart';
import 'package:dapoeutsrahapp/pages/shift/main_shift_page.dart';
import 'package:dapoeutsrahapp/pages/shift/shift_detail_page.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.getStarted, page: () => const GetStartedPage()),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.mainShift,
      page: () => const MainShiftPage(),
      binding: ShiftBinding(),
    ),
    GetPage(name: AppRoutes.formShift, page: () => const FormShiftPage()),
    GetPage(
      name: AppRoutes.shiftDetail,
      page: () {
        final shiftId = Get.arguments as String;
        return ShiftDetailPage(shiftId: shiftId);
      },
      binding: ShiftBinding(),
    ),
  ];
}
