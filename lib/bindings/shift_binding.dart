import 'package:dapoeutsrahapp/controller/shift/shift_controller.dart';
import 'package:get/get.dart';

class ShiftBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShiftController());
  }
}
