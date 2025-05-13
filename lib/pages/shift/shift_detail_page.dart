import 'package:dapoeutsrahapp/controller/shift/shift_controller.dart';
import 'package:dapoeutsrahapp/core/utils/format_util.dart';
import 'package:dapoeutsrahapp/model/pengeluaran_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ShiftController>();
    final shift = controller.getShiftById(widget.shiftId);

    if (shift == null) {
      return const Scaffold(body: Center(child: Text("Shift tidak ditemukan")));
    }

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
                        trailing: Text(FormatUtil.formatRupiah(jumlah * 1000)),
                      );
                    },
                  ),
                ),
                const Divider(),
                Text("Total Terjual: ${shift.totalBakpia} pcs"),
                Text(FormatUtil.formatRupiah(shift.totalUangMasuk)),
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
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (jumlahDibuatController.text.isEmpty) return;
                      controller.updateJumlahDibuat(
                        widget.shiftId,
                        int.parse(jumlahDibuatController.text),
                      );
                      setState(() {});
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
                  ...shift.pengeluaran.map(
                    (item) => ListTile(
                      title: Text(item.nama),
                      trailing: Text(FormatUtil.formatRupiah(item.jumlah)),
                    ),
                  ),
                  const Divider(),
                  const Text(
                    "Ringkasan Keuangan:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total Pengeluaran"),
                      Text(FormatUtil.formatRupiah(shift.totalPengeluaran)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Sisa Uang"),
                      Text(FormatUtil.formatRupiah(shift.sisaUang)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
