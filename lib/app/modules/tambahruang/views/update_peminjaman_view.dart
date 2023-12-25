import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pinjam_ruang/app/modules/tambahruang/controllers/tambahruang_controller.dart';

import 'package:get/get.dart';

class UpdatePeminjamanView extends GetView<TambahRuangController> {
  const UpdatePeminjamanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Peminjaman'),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot<Object?>>(
        future: controller.getData(Get.arguments),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            controller.cNama.text = data['nama'];
            controller.cNpm.text = data['npm'];
            controller.cNamaRuang.text = data['namaruang'];
            controller.cNomorHandphone.text = data['nomor'];
            controller.cKegiatan.text = data['kegiatan'];
            controller.cTanggalPinjam.text = data['tglpinjam'];
            controller.cTanggalKembali.text = data['tglkembali'];
            return Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  TextField(
                    controller: controller.cNama,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(labelText: "Nama"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: controller.cNpm,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: "NPM"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: controller.cNamaRuang,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: "Nama Ruang"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: controller.cNomorHandphone,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: "Nomor"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: controller.cKegiatan,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: "Kegiatan"),
                  ),
                  SizedBox(
                    height: 10,
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
                  SizedBox(
                    height: 10,
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
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () => controller.Update(
                      controller.cNama.text,
                      controller.cNpm.text,
                      controller.cNamaRuang.text,
                      controller.cNomorHandphone.text,
                      controller.cKegiatan.text,
                      controller.cTanggalPinjam.text,
                      controller.cTanggalKembali.text,
                      Get.arguments,
                    ),
                    child: Text("Ubah"),
                  )
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
