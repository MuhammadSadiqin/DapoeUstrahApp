import 'package:dapoeutsrahapp/controller/shift/shift_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FormShiftPage extends StatefulWidget {
  const FormShiftPage({super.key});

  @override
  State<FormShiftPage> createState() => _FormShiftPageState();
}

class _FormShiftPageState extends State<FormShiftPage> {
  final namaKasirController = TextEditingController();
  String selectedShift = 'Siang';
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ShiftController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Buat Shift Penjualan")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: namaKasirController,
              decoration: const InputDecoration(labelText: "Nama Kasir"),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedShift,
              items: const [
                DropdownMenuItem(value: 'Siang', child: Text('Siang')),
                DropdownMenuItem(value: 'Malam', child: Text('Malam')),
              ],
              onChanged: (value) => setState(() => selectedShift = value!),
              decoration: const InputDecoration(labelText: "Shift"),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: Text(
                "Tanggal: ${DateFormat('dd MMMM yyyy').format(selectedDate)}",
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                );
                if (date != null) {
                  setState(() => selectedDate = date);
                }
              },
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (namaKasirController.text.isEmpty) {
                    Get.snackbar("Peringatan", "Nama kasir wajib diisi");
                    return;
                  }

                  controller.tambahShift(
                    namaKasir: namaKasirController.text,
                    shift: selectedShift,
                    tanggal: selectedDate,
                  );

                  Get.back(); // kembali ke main_page
                },
                child: const Text("Simpan Shift"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
