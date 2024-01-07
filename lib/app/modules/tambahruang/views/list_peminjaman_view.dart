import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pinjam_ruang/app/modules/home/views/home_view.dart';
import 'package:flutter_pinjam_ruang/app/modules/tambahruang/controllers/tambahruang_controller.dart';
import 'package:flutter_pinjam_ruang/app/modules/tambahruang/views/tambahruang_view.dart';
import 'package:get/get.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../daftarruang/views/daftarruang_view.dart';
import 'update_peminjaman_view.dart';

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
  String searchKeyword = '';
  int _selectedIndex = 0;
  final cAuth = Get.find<AuthController>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.cyan,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 100.0,
                    height: 100.0,
                    child: ClipOval(
                      child: Image(
                        image: NetworkImage(
                          "https://i.ibb.co/YDY6gWG/profile.jpg",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    user?.email ?? '',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, right: 20, left: 20),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => cAuth.logout(),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.logout,
                                size: 20.0,
                                color: Colors.black,
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                'Logout',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
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
                    onChanged: (value) {
                      // print('Search Keyword: $value');
                      setState(() {
                        searchKeyword = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Cari Nama List Peminjaman',
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
                var listAllDocs = snapshot.data?.docs ?? [];
                var filteredList = listAllDocs.where((doc) {
                  String listName =
                      (doc.data() as Map<String, dynamic>)["nama"];
                  // print('List Name: $listName, Search Keyword: $searchKeyword');
                  return listName
                      .trim()
                      .toLowerCase()
                      .contains(searchKeyword.trim().toLowerCase());
                }).toList();

                return filteredList.length > 0
                    ? Expanded(
                        child: ListView(
                          children: List.generate(
                            filteredList.length,
                            (index) {
                              var dataList = filteredList[index].data()
                                  as Map<String, dynamic>;
                              return GestureDetector(
                                onTap: () => showDetailModal(
                                    context, filteredList[index]),
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
                                          color:
                                              Color.fromARGB(255, 241, 241, 241)
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
                                        "${dataList["nama"]}",
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
                                            "${dataList["npm"]}",
                                          ),
                                          Text(
                                            "${dataList["namaruang"]}",
                                          ),
                                        ],
                                      ),
                                      trailing: IconButton(
                                        onPressed: () =>
                                            showOption(filteredList[index].id),
                                        icon: Icon(Icons.more_vert),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
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
              icon: Icon(Icons.account_circle),
              color: _selectedIndex == 3
                  ? Colors.black
                  : Color.fromRGBO(152, 155, 161, 1),
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
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
    final TambahRuangController controller = Get.put(TambahRuangController());

    var result = await Get.dialog(
      SimpleDialog(
        children: [
          ListTile(
            onTap: () {
              Get.back();
              Get.to(
                UpdatePeminjamanView(),
                arguments: id,
              );
            },
            title: Text('Update'),
          ),
          ListTile(
            onTap: () {
              Get.back();
              controller.delete(id);
            },
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
