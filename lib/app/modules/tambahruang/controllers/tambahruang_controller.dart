import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TambahRuangController extends GetxController {
  late TextEditingController cNama;
  late TextEditingController cNpm;
  late TextEditingController cNamaRuang;
  late TextEditingController cNomorHandphone;
  late TextEditingController cKegiatan;
  late TextEditingController cTanggalPinjam;
  late TextEditingController cTanggalKembali;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<QuerySnapshot<Object?>> GetData() async {
    CollectionReference tambahRuang = firestore.collection('tambahRuang');
    return tambahRuang.get();
  }

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference tambahRuang = firestore.collection('tambahRuang');
    return tambahRuang.snapshots();
  }

  void addData() async {
    CollectionReference ruang = firestore.collection('tambahRuang');

    try {
      await ruang.add({
        "nama": cNama.text,
        "npm": cNpm.text,
        "namaruang": cNamaRuang.text,
        "nomor": cNomorHandphone.text,
        "kegiatan": cKegiatan.text,
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
    cNpm.clear();
    cNamaRuang.clear();
    cNomorHandphone.clear();
    cKegiatan.clear();
    cTanggalPinjam.clear();
    cTanggalKembali.clear();
  }

  Future<DocumentSnapshot<Object?>> getData(String id) async {
    DocumentReference docRef = firestore.collection("tambahRuang").doc(id);
    return docRef.get();
  }

  @override
  void onInit() {
    cNama = TextEditingController();
    cNpm = TextEditingController();
    cNamaRuang = TextEditingController();
    cNomorHandphone = TextEditingController();
    cKegiatan = TextEditingController();
    cTanggalPinjam = TextEditingController();
    cTanggalKembali = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    cNama.dispose();
    cNpm.dispose();
    cNamaRuang.dispose();
    cNomorHandphone.dispose();
    cKegiatan.dispose();
    cTanggalPinjam.dispose();
    cTanggalKembali.dispose();
    super.onClose();
  }
}
