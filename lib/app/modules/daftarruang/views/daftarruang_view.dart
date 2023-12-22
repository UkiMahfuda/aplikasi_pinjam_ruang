import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import '../../auth/controllers/auth_controller.dart';
import '../../home/views/home_view.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      "https://i.ibb.co/YDY6gWG/profile.jpg",
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
                      hintText: 'Search Room',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
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
                    ? Expanded(
                        child: ListView.builder(
                        itemCount: listAllDocs.length,
                        itemBuilder: (context, index) => ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image(
                              width: 75,
                              image: NetworkImage(ImageRandom.getRandomImage()),
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            "${(listAllDocs[index].data() as Map<String, dynamic>)["namaruangan"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${(listAllDocs[index].data() as Map<String, dynamic>)["gedung"]}",
                              ),
                              Text(
                                "Kapasitas ${(listAllDocs[index].data() as Map<String, dynamic>)["kapasitas"]} Kursi",
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () => showOption(listAllDocs[index].id),
                            icon: Icon(Icons.more_vert),
                          ),
                        ),
                      ))
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
                  ? Color.fromRGBO(127, 116, 235, 1)
                  : Color.fromRGBO(152, 155, 161, 1),
              onPressed: () {
                _onItemTapped(0);
              },
            ),
            IconButton(
              icon: Icon(Icons.view_list_outlined),
              color: _selectedIndex == 1
                  ? Color.fromRGBO(127, 116, 235, 1)
                  : Color.fromRGBO(152, 155, 161, 1),
              onPressed: () {
                _onItemTapped(1);
              },
            ),
            SizedBox(), // Spacer
            IconButton(
              icon: Icon(Icons.archive),
              color: _selectedIndex == 2
                  ? Color.fromRGBO(127, 116, 235, 1)
                  : Color.fromRGBO(152, 155, 161, 1),
              onPressed: () {
                _onItemTapped(2);
              },
            ),
            IconButton(
              icon: Icon(Icons.logout),
              color: _selectedIndex == 3
                  ? Color.fromRGBO(127, 116, 235, 1)
                  : Color.fromRGBO(152, 155, 161, 1),
              onPressed: () => cAuth.logout(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle FloatingActionButton press
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(127, 116, 235, 1),
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
    }
  }

  void showOption(id) async {
    var result = await Get.dialog(
      SimpleDialog(
        children: [
          ListTile(
            onTap: () {},
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


  //  Container(
  //                                 child: Row(
  //                                   children: [
  //                                     Container(
  //                                       margin: EdgeInsets.only(bottom: 15),
  //                                       decoration: BoxDecoration(
  //                                         boxShadow: [
  //                                           BoxShadow(
  //                                             color: const Color.fromARGB(
  //                                                 179, 236, 236, 236),
  //                                             blurRadius: 10.0,
  //                                             offset: Offset(0, 3),
  //                                             spreadRadius: 2.0,
  //                                           ),
  //                                         ],
  //                                         color: Colors.white,
  //                                         borderRadius: BorderRadius.only(
  //                                           bottomLeft: Radius.circular(20),
  //                                           bottomRight: Radius.circular(20),
  //                                           topLeft: Radius.circular(20),
  //                                           topRight: Radius.circular(20),
  //                                         ),
  //                                       ),
  //                                       child: Column(
  //                                         children: [
  //                                           ClipRRect(
  //                                             borderRadius: BorderRadius.only(
  //                                                 topRight: Radius.circular(20),
  //                                                 topLeft: Radius.circular(20)),
  //                                             child: Image(
  //                                               width: 140,
  //                                               image: NetworkImage(ImageRandom
  //                                                   .getRandomImage()),
  //                                               fit: BoxFit.cover,
  //                                             ),
  //                                           ),
  //                                           Column(
  //                                             crossAxisAlignment:
  //                                                 CrossAxisAlignment.start,
  //                                             children: [
  //                                               Text(
  //                                                 "${(listAllDocs[index].data() as Map<String, dynamic>)["namaruangan"]}",
  //                                                 style: TextStyle(
  //                                                   fontSize: 18,
  //                                                   fontWeight: FontWeight.w600,
  //                                                 ),
  //                                               ),
  //                                               Text(
  //                                                 "${(listAllDocs[index].data() as Map<String, dynamic>)["gedung"]}",
  //                                               ),
  //                                               Text(
  //                                                 "Kapasitas ${(listAllDocs[index].data() as Map<String, dynamic>)["kapasitas"]} Kursi",
  //                                               ),
  //                                               IconButton(
  //                                                 onPressed: () => showOption(
  //                                                     listAllDocs[index].id),
  //                                                 icon: Icon(Icons.add,
  //                                                     color: Colors.black),
  //                                               ),
  //                                             ],
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     )
  //                                   ],
  //                                 ),
  //                               )),
                    