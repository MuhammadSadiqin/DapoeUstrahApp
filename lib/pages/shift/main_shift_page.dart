import 'package:dapoeutsrahapp/config/routes/app_routes.dart';
import 'package:dapoeutsrahapp/controller/shift/shift_controller.dart';
import 'package:dapoeutsrahapp/core/utils/format_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainShiftPage extends StatelessWidget {
  const MainShiftPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Shift Penjualan")),
      body: Obx(() {
        final controller = Get.find<ShiftController>();
        if (controller.shifts.isEmpty) {
          return const Center(child: Text("Belum ada data shift"));
        }
        return ListView.builder(
          itemCount: controller.shifts.length,
          itemBuilder: (context, index) {
            final shift = controller.shifts[index];
            return ListTile(
              title: Text("${shift.namaKasir} - ${shift.shift}"),
              subtitle: Text("Tanggal: ${shift.tanggal}"),
              trailing: Text(FormatUtil.formatRupiah(shift.sisaUang)),
              onTap: () {
                Get.toNamed(AppRoutes.shiftDetail, arguments: shift.id);
              },
            );
          },
        );
      }),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.formShift);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
