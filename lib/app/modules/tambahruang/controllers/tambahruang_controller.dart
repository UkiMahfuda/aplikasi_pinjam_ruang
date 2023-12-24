import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TambahRuangController extends GetxController {
  late TextEditingController cNama;
  late TextEditingController cNomorHandphone;
  late TextEditingController cKegiatan;
  late TextEditingController cNamaRuang;
  late TextEditingController cTanggalPinjam;
  late TextEditingController cTanggalKembali;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addData() async {
    CollectionReference ruang = firestore.collection('tambahRuang');

    try {
      await ruang.add({
        "nama": cNama.text,
        "nomor": cNomorHandphone.text,
        "kegiatan": cKegiatan.text,
        "namaruang": cNamaRuang.text,
        "tglpinjam": cTanggalPinjam.text,
        "tglkembali": cTanggalKembali.text,
      });

      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Berhasil menyimpan data peminjaman ruang",
        onConfirm: () {
          clearControllers();
          Get.back();
          Get.back();
        },
        textConfirm: "OK",
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Gagal Menambahkan Peminjaman Ruang.",
      );
    }
  }

  void clearControllers() {
    cNama.clear();
    cNomorHandphone.clear();
    cKegiatan.clear();
    cNamaRuang.clear();
    cTanggalPinjam.clear();
    cTanggalKembali.clear();
  }

  @override
  void onInit() {
    cNama = TextEditingController();
    cNomorHandphone = TextEditingController();
    cKegiatan = TextEditingController();
    cNamaRuang = TextEditingController();
    cTanggalPinjam = TextEditingController();
    cTanggalKembali = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    cNama.dispose();
    cNomorHandphone.dispose();
    cKegiatan.dispose();
    cNamaRuang.dispose();
    cTanggalPinjam.dispose();
    cTanggalKembali.dispose();
    super.onClose();
  }
}
