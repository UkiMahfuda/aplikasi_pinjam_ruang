import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DaftarruangController extends GetxController {
  //TODO: Implement DaftarRuangController
  late TextEditingController cNamaruangan;
  late TextEditingController cGedung;
  late TextEditingController cKapasitas;
  late TextEditingController cDeskripsi;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<QuerySnapshot<Object?>> GetData() async {
    CollectionReference daftarRuang = firestore.collection('daftarRuang');
    return daftarRuang.get();
  }

//Fungsi menampilkan data ruangan berdasarkan gedung
  Stream<QuerySnapshot<Object?>> streamDataByGedung(String gedung) {
    CollectionReference daftarRuang = firestore.collection('daftarRuang');
    return daftarRuang.where('gedung', isEqualTo: gedung).snapshots();
  }

//Fungsi menampilkan data ruangan berdasarkan nama ruangan
  Stream<QuerySnapshot<Object?>> streamDataByNamaRuang(String namaruangan) {
    CollectionReference daftarRuang = firestore.collection('daftarRuang');
    return daftarRuang.where('namaruangan', isEqualTo: namaruangan).snapshots();
  }

//Fungsi menampilkan data namaruangan
  Future<List<String>> getNamaRuang() async {
    List<String> ruanganList = [];
    try {
      QuerySnapshot<Object?> querySnapshot =
          await firestore.collection('daftarRuang').get();
      querySnapshot.docs.forEach((doc) {
        String ruangan = doc['namaruangan'];
        ruanganList.add(ruangan);
      });
    } catch (e) {
      print('Data Gagal Di tampilkan');
    }
    return ruanganList;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    cNamaruangan = TextEditingController();
    cGedung = TextEditingController();
    cKapasitas = TextEditingController();
    cDeskripsi = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    cNamaruangan.dispose();
    cGedung.dispose();
    cKapasitas.dispose();
    cDeskripsi.dispose();
    super.onClose();
  }
}
