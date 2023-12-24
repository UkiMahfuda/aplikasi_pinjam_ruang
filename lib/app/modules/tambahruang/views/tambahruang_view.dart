import 'package:flutter/material.dart';
import 'package:flutter_pinjam_ruang/app/modules/tambahruang/controllers/tambahruang_controller.dart';
import 'package:get/get.dart';
import '../controllers/tambahruang_controller.dart';

class TambahruangView extends StatelessWidget {
  final TambahRuangController controller = Get.put(TambahRuangController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pinjam Ruang'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            TextFormField(
              controller: controller.cNama,
              autocorrect: false,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: "Nama"),
            ),
            TextFormField(
              controller: controller.cNomorHandphone,
              autocorrect: false,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: "Nomor Handphone"),
            ),
            TextFormField(
              controller: controller.cKegiatan,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: "Kegiatan"),
            ),
            TextFormField(
              controller: controller.cNamaRuang,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: "Nama Ruang"),
            ),
            TextFormField(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );

                if (pickedDate != null) {
                  controller.cTanggalPinjam.text =
                      "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                }
              },
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Tanggal Pinjam",
                suffixIcon: Icon(Icons.calendar_today),
              ),
              controller: controller.cTanggalPinjam,
            ),
            TextFormField(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );

                if (pickedDate != null) {
                  controller.cTanggalKembali.text =
                      "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                }
              },
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Tanggal Kembali",
                suffixIcon: Icon(Icons.calendar_today),
              ),
              controller: controller.cTanggalKembali,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                controller.addData();
              },
              child: Text('Pinjam Ruang'),
            ),
          ],
        ),
      ),
    );
  }
}
