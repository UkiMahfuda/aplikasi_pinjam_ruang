import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../tambahruang/views/tambahruang_view.dart';

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

class DeskripsiruangView extends StatelessWidget {
  const DeskripsiruangView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    child: Container(
                      child: Image(
                        width: 500,
                        height: 300,
                        image: NetworkImage(ImageRandom.getRandomImage()),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Get.back();
                        },
                        color: Colors.white,
                        iconSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              right: 35,
              left: 20,
              top: 25,
              bottom: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${data['namaruangan']}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${data['gedung']}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'Kapasitas ${data['kapasitas']} kursi',
                  style: TextStyle(fontSize: 16, color: Colors.grey[500]),
                ),
                SizedBox(height: 30),
                Text(
                  '${data['deskripsi']}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromRGBO(
            246, 247, 248, 1), // Warna latar belakang bottom navigation
        child: Container(
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TambahruangView()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 15, left: 10, right: 10),
                  child: Text(
                    'Pinjam Ruang Ini',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
