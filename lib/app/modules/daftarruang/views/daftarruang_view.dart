import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pinjam_ruang/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'dart:math';
import '../../auth/controllers/auth_controller.dart';
import '../../home/views/home_view.dart';
import '../../tambahruang/views/list_peminjaman_view.dart';
import '../../tambahruang/views/tambahruang_view.dart';
import '../controllers/daftarruang_controller.dart';

//Pilih gambar random
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

class DaftarruangView extends StatelessWidget {
  final cAuth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return DashboardRuang();
  }
}

class DashboardRuang extends StatefulWidget {
  const DashboardRuang({super.key});

  @override
  State<DashboardRuang> createState() => _DashboardRuangState();
}

class _DashboardRuangState extends State<DashboardRuang> {
  int _selectedIndex = 0;
  final cAuth = Get.find<AuthController>();
  String selectedGedung = 'Gedung A';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: CircleAvatar(
                radius: 12.5,
                backgroundImage: NetworkImage(
                  "https://i.ibb.co/YDY6gWG/profile.jpg",
                ),
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
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
                  'Daftar Ruangan',
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
                      hintText: 'Cari Ruangan',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedGedung = 'Gedung A';
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: selectedGedung == 'Gedung A'
                                ? Colors.black87
                                : Color.fromRGBO(246, 247, 248, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            fixedSize: Size(100, 35),
                          ),
                          child: Text('Ged A',
                              style: TextStyle(
                                color: selectedGedung == 'Gedung A'
                                    ? Colors.white
                                    : Colors.black,
                              )),
                        ),
                        SizedBox(width: 10), // Tambahkan jarak antar button
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedGedung = 'Gedung GSG';
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: selectedGedung == 'Gedung GSG'
                                ? Colors.black87
                                : Color.fromRGBO(246, 247, 248, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            fixedSize: Size(100, 35),
                          ),
                          child: Text('Ged GSG',
                              style: TextStyle(
                                color: selectedGedung == 'Gedung GSG'
                                    ? Colors.white
                                    : Colors.black,
                              )),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedGedung = 'Gedung ICT';
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: selectedGedung == 'Gedung ICT'
                                ? Colors.black87
                                : Color.fromRGBO(246, 247, 248, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            fixedSize: Size(100, 35),
                          ),
                          child: Text('Ged ICT',
                              style: TextStyle(
                                color: selectedGedung == 'Gedung ICT'
                                    ? Colors.white
                                    : Colors.black,
                              )),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedGedung = 'Gedung B';
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: selectedGedung == 'Gedung B'
                                ? Colors.black87
                                : Color.fromRGBO(246, 247, 248, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            fixedSize: Size(100, 35),
                          ),
                          child: Text('Ged B',
                              style: TextStyle(
                                color: selectedGedung == 'Gedung B'
                                    ? Colors.white
                                    : Colors.black,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                StreamBuilder<QuerySnapshot<Object?>>(
                  stream: Get.put(DaftarruangController())
                      .streamDataByGedung(selectedGedung),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      var listAllDocs = snapshot.data?.docs ?? [];
                      return listAllDocs.length > 0
                          ? Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Container(
                                  child: Column(
                                children: List.generate(
                                    (listAllDocs.length / 2).ceil(),
                                    (rowIndex) {
                                  int startIndex = rowIndex * 2;
                                  int endIndex = (rowIndex + 1) * 2;
                                  if (endIndex > listAllDocs.length) {
                                    endIndex = listAllDocs.length;
                                  }

                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: List.generate(
                                        endIndex - startIndex, (colIndex) {
                                      int index = startIndex + colIndex;
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            Routes.DESKRIPSIRUANG,
                                            arguments: {
                                              'id': listAllDocs[index].id,
                                              'namaruangan': (listAllDocs[index]
                                                          .data()
                                                      as Map<String, dynamic>)[
                                                  "namaruangan"],
                                              'gedung':
                                                  (listAllDocs[index].data()
                                                      as Map<String,
                                                          dynamic>)["gedung"],
                                              'kapasitas': (listAllDocs[index]
                                                          .data()
                                                      as Map<String, dynamic>)[
                                                  "kapasitas"],
                                              'deskripsi': (listAllDocs[index]
                                                          .data()
                                                      as Map<String, dynamic>)[
                                                  "deskripsi"],
                                            },
                                          );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              bottom: 35, right: 5, left: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color.fromARGB(
                                                        255, 241, 241, 241)
                                                    .withOpacity(0.8),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Column(children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20),
                                              ),
                                              child: Image(
                                                width: 140,
                                                image: NetworkImage(
                                                  ImageRandom.getRandomImage(),
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "${(listAllDocs[index].data() as Map<String, dynamic>)["namaruangan"]}",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "${(listAllDocs[index].data() as Map<String, dynamic>)["gedung"]}",
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "Kapasitas ${(listAllDocs[index].data() as Map<String, dynamic>)["kapasitas"]} Kursi",
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              TambahruangView(),
                                                        ),
                                                      );
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape: CircleBorder(),
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      primary: Colors.black,
                                                    ),
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                ]),
                                          ]),
                                        ),
                                      );
                                    }),
                                  );
                                }),
                              )),
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TambahruangView()),
              );
            },
            title: Text('Pinjam'),
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
