import 'package:dapoeutsrahapp/controller/shift/shift_controller.dart';
import 'package:dapoeutsrahapp/model/pengeluaran_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ShiftDetailPage extends StatefulWidget {
  final String shiftId;

  const ShiftDetailPage({super.key, required this.shiftId});

  @override
  State<ShiftDetailPage> createState() => _ShiftDetailPageState();
}

class _ShiftDetailPageState extends State<ShiftDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final pcsController = TextEditingController();
  final namaPengeluaranController = TextEditingController();
  final jumlahPengeluaranController = TextEditingController();
  final jumlahDibuatController = TextEditingController();
  final controller = Get.find<ShiftController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    pcsController.dispose();
    namaPengeluaranController.dispose();
    jumlahPengeluaranController.dispose();
    jumlahDibuatController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _showDeleteConfirmDialog(BuildContext context, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Konfirmasi"),
          content: const Text("Yakin ingin menghapus data ini?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                onConfirm();
              },
              child: const Text("Hapus"),
            ),
          ],
        );
      },
    );
  }

  void _showEditTransaksiDialog(
    BuildContext context,
    int index,
    int currentValue,
    String shiftId,
  ) {
    final controller = Get.find<ShiftController>();
    final editController = TextEditingController(text: currentValue.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Jumlah Penjualan"),
          content: TextField(
            controller: editController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Jumlah pcs"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                final newValue = int.tryParse(editController.text);
                if (newValue != null && newValue > 0) {
                  controller.updateTransaksi(shiftId, index, newValue);
                  Navigator.pop(context);
                  setState(() {});
                }
              },
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  void _showEditPengeluaranDialog(
    BuildContext context,
    int index,
    PengeluaranModel currentItem,
    String shiftId,
  ) {
    final controller = Get.find<ShiftController>();
    final namaController = TextEditingController(text: currentItem.nama);
    final jumlahController = TextEditingController(
      text: currentItem.jumlah.toString(),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Pengeluaran"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: namaController,
                decoration: const InputDecoration(
                  labelText: "Nama Pengeluaran",
                ),
              ),
              TextField(
                controller: jumlahController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Jumlah (Rp)"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                final newNama = namaController.text.trim();
                final newJumlah = int.tryParse(jumlahController.text);
                if (newNama.isNotEmpty && newJumlah != null && newJumlah > 0) {
                  controller.updatePengeluaran(
                    shiftId,
                    index,
                    PengeluaranModel(nama: newNama, jumlah: newJumlah),
                  );
                  Navigator.pop(context);
                  setState(() {});
                }
              },
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ShiftController>();
    final shift = controller.getShiftById(widget.shiftId);

    final formatRupiah = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    if (shift == null) {
      return const Scaffold(body: Center(child: Text("Shift tidak ditemukan")));
    }

    jumlahDibuatController.text = shift.jumlahDibuat.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text("Shift ${shift.namaKasir} - ${shift.shift}"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [Tab(text: "Penjualan"), Tab(text: "Pengeluaran")],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab Penjualan
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: pcsController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Jumlah pcs terjual",
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (pcsController.text.isEmpty) return;
                        controller.tambahTransaksi(
                          widget.shiftId,
                          int.parse(pcsController.text),
                        );
                        pcsController.clear();
                        setState(() {});
                      },
                      child: const Text("+ Tambah"),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: shift.transaksi.length,
                    itemBuilder: (context, index) {
                      final jumlah = shift.transaksi[index];
                      return ListTile(
                        leading: const Icon(Icons.shopping_cart),
                        title: Text("$jumlah pcs"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                _showEditTransaksiDialog(
                                  context,
                                  index,
                                  jumlah,
                                  shift.id,
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _showDeleteConfirmDialog(context, () {
                                  controller.hapusTransaksi(shift.id, index);
                                  Navigator.pop(context);
                                  setState(() {});
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const Divider(),
                Text("Total Terjual: ${shift.totalBakpia} pcs"),
                Text(
                  "Total Uang Masuk: ${formatRupiah.format(shift.totalUangMasuk)}",
                ),
              ],
            ),
          ),

          // Tab Pengeluaran
          Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: jumlahDibuatController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Jumlah Kue Dibuat",
                    ),
                    onSubmitted: (value) {
                      final jumlah = int.tryParse(value);
                      if (jumlah != null) {
                        controller.updateJumlahDibuat(widget.shiftId, jumlah);
                        setState(() {});
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      final jumlah = int.tryParse(jumlahDibuatController.text);
                      if (jumlah != null) {
                        controller.updateJumlahDibuat(widget.shiftId, jumlah);
                        setState(() {});
                      }
                    },
                    child: const Text("Simpan Jumlah Dibuat"),
                  ),
                  const Divider(),
                  Text("Kue Terjual: ${shift.totalBakpia}"),
                  Text("Kue Sisa: ${shift.jumlahKueSisa}"),
                  const Divider(),
                  TextField(
                    controller: namaPengeluaranController,
                    decoration: const InputDecoration(
                      labelText: "Nama Pengeluaran",
                    ),
                  ),
                  TextField(
                    controller: jumlahPengeluaranController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "Jumlah (Rp)"),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (namaPengeluaranController.text.isEmpty ||
                          jumlahPengeluaranController.text.isEmpty)
                        return;

                      controller.tambahPengeluaran(
                        widget.shiftId,
                        PengeluaranModel(
                          nama: namaPengeluaranController.text,
                          jumlah: int.parse(jumlahPengeluaranController.text),
                        ),
                      );
                      namaPengeluaranController.clear();
                      jumlahPengeluaranController.clear();
                      setState(() {});
                    },
                    child: const Text("+ Tambah Pengeluaran"),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Daftar Pengeluaran:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ...shift.pengeluaran.asMap().entries.map((entry) {
                    int index = entry.key;
                    final item = entry.value;
                    return ListTile(
                      title: Text(item.nama),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              _showEditPengeluaranDialog(
                                context,
                                index,
                                item,
                                shift.id,
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _showDeleteConfirmDialog(context, () {
                                controller.hapusPengeluaran(shift.id, index);
                                Navigator.pop(context);
                                setState(() {});
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  const Divider(),
                  Text(
                    "Total Pengeluaran: ${formatRupiah.format(shift.totalPengeluaran)}",
                  ),
                  Text("Sisa Uang: ${formatRupiah.format(shift.sisaUang)}"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
