import 'package:dapoeutsrahapp/controller/shift/shift_controller.dart';
import 'package:dapoeutsrahapp/core/utils/format_util.dart';
import 'package:dapoeutsrahapp/pages/shift/shift_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'form_shift_page.dart';

class MainShiftPage extends StatelessWidget {
  const MainShiftPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ShiftController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Shift Penjualan")),
      body: Obx(() {
        if (controller.shifts.isEmpty) {
          return const Center(child: Text("Belum ada shift hari ini"));
        }

        return ListView.builder(
          itemCount: controller.shifts.length,
          itemBuilder: (context, index) {
            final shift = controller.shifts[index];

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text("${shift.namaKasir} - ${shift.shift}"),
                subtitle: Text("Tanggal: ${shift.tanggalFormatted}"),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Total: ${shift.totalBakpia} pcs"),
                    Text(FormatUtil.formatRupiah(shift.totalUangMasuk)),
                  ],
                ),
                onTap: () {
                  Get.to(() => ShiftDetailPage(shiftId: shift.id));
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const FormShiftPage());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
