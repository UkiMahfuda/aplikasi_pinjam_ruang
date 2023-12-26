import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pinjam_ruang/app/modules/home/views/home_view.dart';
import 'package:flutter_pinjam_ruang/app/modules/tambahruang/controllers/tambahruang_controller.dart';
import 'package:flutter_pinjam_ruang/app/modules/tambahruang/views/tambahruang_view.dart';
import 'package:get/get.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../daftarruang/views/daftarruang_view.dart';

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
  final cAuth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return DashboardPeminjaman();
  }
}

class DashboardPeminjaman extends StatefulWidget {
  const DashboardPeminjaman({super.key});

  @override
  State<DashboardPeminjaman> createState() => _DashboardPeminjamanState();
}

class _DashboardPeminjamanState extends State<DashboardPeminjaman> {
  int _selectedIndex = 0;
  final cAuth = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 15, right: 50, left: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Daftar Peminjaman',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 50,
                  width: 50,
                  child: ClipOval(
                    child: Image.network(
                      "https://i.ibb.co/k34YnYr/uti.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 25, left: 15, right: 15),
            height: 50,
            decoration: BoxDecoration(
              color: Color.fromRGBO(246, 247, 248, 1),
              border: Border.all(color: const Color.fromRGBO(246, 247, 248, 1)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.search,
                    color: Color.fromRGBO(120, 124, 132, 1),
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Cari List Peminjaman',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot<Object?>>(
            stream: Get.put(TambahRuangController()).streamData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                // mengambil data
                var listAllDocs = snapshot.data?.docs ?? [];
                return listAllDocs.length > 0
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: listAllDocs.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () =>
                                showDetailModal(context, listAllDocs[index]),
                            child: Container(
                              margin: EdgeInsets.only(
                                left: 25,
                                right: 25,
                              ),
                              child: Container(
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 241, 241, 241)
                                          .withOpacity(0.8),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text('${index + 1}'),
                                    backgroundColor:
                                        Color.fromARGB(255, 248, 248, 248),
                                  ),
                                  title: Text(
                                    "${(listAllDocs[index].data() as Map<String, dynamic>)["nama"]}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "NPM : ${(listAllDocs[index].data() as Map<String, dynamic>)["npm"]}",
                                      ),
                                      Text(
                                        "Ruangan : ${(listAllDocs[index].data() as Map<String, dynamic>)["namaruang"]}",
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    onPressed: () =>
                                        showOption(listAllDocs[index].id),
                                    icon: Icon(Icons.more_vert),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: Text("Data Kosong"),
                      );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 50,
        color: Color.fromRGBO(246, 247, 248, 1),
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              color: _selectedIndex == 0
                  ? Colors.black
                  : Color.fromRGBO(152, 155, 161, 1),
              onPressed: () {
                _onItemTapped(0);
              },
            ),
            IconButton(
              icon: Icon(Icons.view_list_outlined),
              color: _selectedIndex == 1
                  ? Colors.black
                  : Color.fromRGBO(152, 155, 161, 1),
              onPressed: () {
                _onItemTapped(1);
              },
            ),
            SizedBox(), // Spacer
            IconButton(
              icon: Icon(Icons.archive),
              color: _selectedIndex == 2
                  ? Colors.black
                  : Color.fromRGBO(152, 155, 161, 1),
              onPressed: () {
                _onItemTapped(2);
              },
            ),
            IconButton(
              icon: Icon(Icons.logout),
              color: _selectedIndex == 3
                  ? Colors.black
                  : Color.fromRGBO(152, 155, 161, 1),
              onPressed: () => cAuth.logout(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TambahruangView()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void showDetailModal(
      BuildContext context, QueryDocumentSnapshot<Object?> document) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Detail Data Peminjaman',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              buildDetailRow('Nama : ', document["nama"]),
              buildDetailRow('NPM : ', document["npm"]),
              buildDetailRow('Nomor : ', document["nomor"]),
              buildDetailRow('Kegiatan : ', document["kegiatan"]),
              buildDetailRow('Nama Ruang : ', document["namaruang"]),
              buildDetailRow('Tanggal Pinjam : ', document["tglpinjam"]),
              buildDetailRow('Tanggal Kembali : ', document["tglkembali"]),
            ],
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                child: Text(
                  'Tutup',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeView()),
      );
    } else if (index == 1) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => DaftarruangView()),
      );
    } else if (index == 2) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ListPeminjamanView()),
      );
    }
  }

  void showOption(id) async {
    var result = await Get.dialog(
      SimpleDialog(
        children: [
          ListTile(
            onTap: () {},
            title: Text('Update'),
          ),
          ListTile(
            onTap: () {},
            title: Text('Hapus'),
          ),
          ListTile(
            onTap: () => Get.back(),
            title: Text('Close'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
// onTap: () {
                            //   Navigator.pushNamed(
                            //     context,
                            //     Routes.DESKRIPSIRUANG,
                            //     arguments: {
                            //       'id': listAllDocs[index].id,
                            //       'nama': listAllDocs[index]["nama"],
                            //       'npm': listAllDocs[index]["npm"],
                            //       'nomor': listAllDocs[index]["nomor"],
                            //       'namaruang': listAllDocs[index]["namaruang"],
                            //       'kegiatan': listAllDocs[index]["kegiatan"],
                            //       'tglpinjam': listAllDocs[index]["tglpinjam"],
                            //       'tglkembali': listAllDocs[index]["tglkembali"],
                            //     },
                            //   );
                            // },