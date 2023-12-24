import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_pinjam_ruang/app/routes/app_pages.dart';
import '../../auth/controllers/auth_controller.dart';

class ImageRandom {
  static String getRandomImage() {
    List<String> imageUrls = [
      'https://i.ibb.co/1Mb4hfC/lab1gsg.jpg',
      'https://i.ibb.co/3y5wj0N/labdigital.jpg',
      'https://i.ibb.co/TH3RTSR/302b.jpg',
      'https://i.ibb.co/vqzxHct/labict.jpg',
      'https://i.ibb.co/S3vKgZq/Lab-Gambar.jpg',
      'https://i.ibb.co/tPKSJpG/Lab2A.jpg',
    ];

    Random random = Random();
    int randomIndex = random.nextInt(imageUrls.length);
    return imageUrls[randomIndex];
  }
}

class ListPeminjamanView extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Peminjaman'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: firestore.collection('tambahRuang').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var bookings = snapshot.data!.docs;

          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              var booking = bookings[index];
              var namaRuang = booking['namaruang'];
              var nama = booking['nama'];
              var nomor = booking['nomor'];
              var kegiatan = booking['kegiatan'];
              var tglPinjam = booking['tglpinjam'];
              var tglKembali = booking['tglkembali'];

              return Container(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image(
                        width: 75,
                        image: NetworkImage(ImageRandom.getRandomImage()),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nama: $nama',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text('Nama Ruang: $namaRuang'),
                            Text('Nomor Handphone: $nomor'),
                            Text('Kegiatan: $kegiatan'),
                            Text('Tanggal Pinjam: $tglPinjam'),
                            Text('Tanggal Kembali: $tglKembali'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
